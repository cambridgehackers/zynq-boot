`timescale 1 ps / 1 ps

module system_wrapper (
   AC_BCLK, AC_MCLK, AC_MUTE_N, AC_PBLRC, AC_RECLRC, AC_SDATA_O,
    DDR_addr, DDR_ba, DDR_cas_n, DDR_ck_n, DDR_ck_p, DDR_cke, DDR_cs_n, DDR_dm,
    DDR_dq, DDR_dqs_n, DDR_dqs_p, DDR_odt, DDR_ras_n, DDR_reset_n, DDR_we_n,
    FIXED_IO_ddr_vrn, FIXED_IO_ddr_vrp, FIXED_IO_mio, FIXED_IO_ps_clk, FIXED_IO_ps_porb, FIXED_IO_ps_srstb,
    iic_0_scl_io, iic_0_sda_io);
  output [0:0]AC_BCLK; output AC_MCLK; output [0:0]AC_MUTE_N;
  output [0:0]AC_PBLRC; output [0:0]AC_RECLRC; output [0:0]AC_SDATA_O;
  inout [14:0]DDR_addr; inout [2:0]DDR_ba; inout DDR_cas_n; inout DDR_ck_n;
  inout DDR_ck_p; inout DDR_cke; inout DDR_cs_n; inout [3:0]DDR_dm;
  inout [31:0]DDR_dq; inout [3:0]DDR_dqs_n; inout [3:0]DDR_dqs_p; inout DDR_odt;
  inout DDR_ras_n; inout DDR_reset_n; inout DDR_we_n;
  inout FIXED_IO_ddr_vrn; inout FIXED_IO_ddr_vrp; inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk; inout FIXED_IO_ps_porb; inout FIXED_IO_ps_srstb;
  inout iic_0_scl_io; inout iic_0_sda_io;

  wire IIC_0_scl_i; wire IIC_0_scl_io; wire IIC_0_scl_o; wire IIC_0_scl_t;
  wire IIC_0_sda_i; wire IIC_0_sda_io; wire IIC_0_sda_o; wire IIC_0_sda_t;

IOBUF iic_0_scl_iobuf (.I(IIC_0_scl_o), .IO(iic_0_scl_io), .O(IIC_0_scl_i), .T(IIC_0_scl_t));
IOBUF iic_0_sda_iobuf (.I(IIC_0_sda_o), .IO(iic_0_sda_io), .O(IIC_0_sda_i), .T(IIC_0_sda_t));

ps7_0 processing_system7_0
       (.DDR_Addr(DDR_addr), .DDR_BankAddr(DDR_ba),
        .DDR_CAS_n(DDR_cas_n), .DDR_CKE(DDR_cke),
        .DDR_CS_n(DDR_cs_n), .DDR_Clk(DDR_ck_p), .DDR_Clk_n(DDR_ck_n),
        .DDR_DM(DDR_dm), .DDR_DQ(DDR_dq), .DDR_DQS(DDR_dqs_p), .DDR_DQS_n(DDR_dqs_n),
        .DDR_DRSTB(DDR_reset_n), .DDR_ODT(DDR_odt), .DDR_RAS_n(DDR_ras_n), .DDR_VRN(FIXED_IO_ddr_vrn),
        .DDR_VRP(FIXED_IO_ddr_vrp), .DDR_WEB(DDR_we_n),
        .I2C0_SCL_I(IIC_0_scl_i), .I2C0_SCL_O(IIC_0_scl_o),
        .I2C0_SCL_T(IIC_0_scl_t), .I2C0_SDA_I(IIC_0_sda_i),
        .I2C0_SDA_O(IIC_0_sda_o), .I2C0_SDA_T(IIC_0_sda_t),
        .MIO(FIXED_IO_mio),
        .PS_CLK(FIXED_IO_ps_clk), .PS_PORB(FIXED_IO_ps_porb), .PS_SRSTB(FIXED_IO_ps_srstb)
);
endmodule
