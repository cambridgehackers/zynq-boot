/* Copyright (c) 2013 Quanta Research Cambridge, Inc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include <stdint-gcc.h>
#define XILINX_EP107		3378
/* This code initializes the parts of the ARM processor that were previously
 * initialized by u-boot (git://git.xilinx.com/u-boot-xlnx.git)
 * in arch/arm/cpu/armv7/zynq/cpu.c:lowlevel_init().
 *
 * FSBL has already initialized UART and stack
 */
#define SLCR_LOCK_MAGIC           0x767B
#define SLCR_UNLOCK_MAGIC         0xDF0D

#define XPSS_SYS_CTRL_BASEADDR    0xF8000000
#define XPSS_DEV_CFG_APB_BASEADDR 0xF8007000
#define XPSS_SCU_BASEADDR         0xF8F00000

#define STDOUT_BASEADDRESS        0xE0001000
#define XUARTPS_SR_OFFSET         0x2C       /**< Channel Status [14:0] */
#define XUARTPS_SR_TXFULL         0x00000010 /**< TX FIFO full */
#define XUARTPS_FIFO_OFFSET       0x30       /**< FIFO [7:0] */

// SLCR
#define XSLCR_MIO_PIN_00_OFFSET    0x700 /* MIO PIN0 control register */
#define XSLCR_MIO_L0_SHIFT             1
#define XSLCR_MIO_L1_SHIFT             2
#define XSLCR_MIO_L2_SHIFT             3
#define XSLCR_MIO_L3_SHIFT             5
#define XSLCR_MIO_LMASK             0xFE
#define XSLCR_MIO_PIN_XX_TRI_ENABLE    1
#define XSLCR_MIO_PIN_GPIO_ENABLE   (0x00 << XSLCR_MIO_L3_SHIFT)
#define XSLCR_MIO_PIN_SDIO_ENABLE   (0x04 << XSLCR_MIO_L3_SHIFT)

#define PINOFF(PIN) (XPSS_SYS_CTRL_BASEADDR + XSLCR_MIO_PIN_00_OFFSET + (PIN) * 4)
// #define EMIO_SDIO1


static void Xil_Out32(uint32_t OutAddress, uint32_t Value);
static uint32_t Xil_In32(uint32_t Addr);
static void debug_puts(const char *ptr);
static const struct {
    uint32_t pinaddr;
    uint32_t enable;
} sdio1_pindef[] = {
#ifdef BOARD_zedboard
    {PINOFF(10), XSLCR_MIO_PIN_SDIO_ENABLE}, 
    {PINOFF(11), XSLCR_MIO_PIN_SDIO_ENABLE}, 
    {PINOFF(12), XSLCR_MIO_PIN_SDIO_ENABLE}, 
    {PINOFF(13), XSLCR_MIO_PIN_SDIO_ENABLE}, 
    {PINOFF(14), XSLCR_MIO_PIN_SDIO_ENABLE}, 
    {PINOFF(15), XSLCR_MIO_PIN_SDIO_ENABLE}, 
#endif
    {0,0}};

void _binary_imagefiles_zImage_start(int, int, int);
void clearreg(void)
{
    uint32_t pinaddr, ind = 0;
	uint32_t tmpcnt=0;
    debug_puts("Start clearreg\n\r");
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x8, SLCR_UNLOCK_MAGIC); //slcr_unlock
    /* remap DDR to zero, FILTERSTART */
    Xil_Out32(XPSS_SCU_BASEADDR + 0x40, 0);                     //filter_start
    /* Device config APB, unlock the PCAP */
    Xil_Out32(XPSS_DEV_CFG_APB_BASEADDR + 0x34, 0x757BDF0D);    //unlock
    Xil_Out32(XPSS_DEV_CFG_APB_BASEADDR + 0x28, 0xFFFFFFFF);    //rom_shadow
    /* OCM_CFG, Mask out the ROM, map ram into upper addresses */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x910, 0x1F);            //ocm_cfg
    /* FPGA_RST_CTRL, clear resets on AXI fabric ports */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x240, 0);             //fpga_rst_ctrl
    /* TZ_DDR_RAM, Set DDR trust zone non-secure */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x430, 0xFFFFFFFF);      //trust_zone
    /* Set urgent bits with register */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x61c, 0);             //ddr_urgent_sel
    /* Urgent write, ports S2/S3 */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x600, 0xC);             //ddr_urgent
    while ((pinaddr = sdio1_pindef[ind].pinaddr)) {
#ifndef EMIO_SDIO1
        /* release pin set tri-state */
        Xil_Out32(pinaddr, (Xil_In32(pinaddr) & ~XSLCR_MIO_LMASK) | XSLCR_MIO_PIN_XX_TRI_ENABLE);
        /* assign pin to this peripheral */
        Xil_Out32(pinaddr, sdio1_pindef[ind].enable);
#endif
        ind++;
    }

#ifdef BOARD_zc706
	/* 800MHz Clock support */
    debug_puts("Start 800MHz Clock\n\r");
	/* ARM_PLL_CFG update (LOCKCNT=0xFA, PLL_CD=0x2, PLL_RES=0x4)*/
	Xil_Out32(0xF8000110, 0x000FA240);
	/* Update FB_DIV=0x30 (48)*/
	Xil_Out32(0xF8000100, (Xil_In32(0xF8000100) & ~(0x0007F000)) | 0x00030000);
	/* Set Bypass PLL */
	Xil_Out32(0xF8000100, (Xil_In32(0xF8000100) & ~(0x00000010)) | 0x00000010);
	/* Assert Reset */
	Xil_Out32(0xF8000100, (Xil_In32(0xF8000100) & ~(0x00000001)) | 0x00000001);
	/* Deassert Reset */
	Xil_Out32(0xF8000100, (Xil_In32(0xF8000100) & ~(0x00000001)) | 0x00000000);

	/* Check PLL Status */

	while ( !(Xil_In32(0xF800010C) & (0x00000001)) ) {
		tmpcnt++;
		if( tmpcnt > 0x0000FFFF ) {
			debug_puts("PLL timeout\n\r");
			break;
		}
	}

	/* Remove Bypass PLL */
	Xil_Out32(0xF8000100, (Xil_In32(0xF8000100) & ~(0x00000010)) | 0x00000000);
	debug_puts("Finish 800MHz Clock\n\r");
#endif

    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x4, SLCR_LOCK_MAGIC);   //slcr_lock
    debug_puts("Jump to linux\n\r");
    _binary_imagefiles_zImage_start(0, XILINX_EP107, 0x1000000 /* address of devicetree data */);
}
static void Xil_Out32(uint32_t OutAddress, uint32_t Value)
{
    *(volatile uint32_t *) OutAddress = Value;
}
static uint32_t Xil_In32(uint32_t Addr)
{
    return *(volatile uint32_t *) Addr;
}
static void debug_puts(const char *ptr)
{
    while (*ptr) {
        while((Xil_In32(STDOUT_BASEADDRESS + XUARTPS_SR_OFFSET) & XUARTPS_SR_TXFULL));
        Xil_Out32(STDOUT_BASEADDRESS + XUARTPS_FIFO_OFFSET, *ptr++);
    }
}
