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

static void Xil_Out32(uint32_t OutAddress, uint32_t Value);
static uint32_t Xil_In32(uint32_t Addr);
static void debug_puts(const char *ptr);

void _binary_imagefiles_zImage_start(int, int, int);
void clearreg(void)
{
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
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x240, 0x0);             //fpga_rst_ctrl
    /* TZ_DDR_RAM, Set DDR trust zone non-secure */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x430, 0xFFFFFFFF);      //trust_zone
    /* Set urgent bits with register */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x61c, 0x0);             //ddr_urgent_sel
    /* Urgent write, ports S2/S3 */
    Xil_Out32(XPSS_SYS_CTRL_BASEADDR + 0x600, 0xC);             //ddr_urgent
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
