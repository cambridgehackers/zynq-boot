(*POWER= "<PROCESSOR name={system} numA9Cores={2} clockFreq={650.000000} load={0.5} /><MEMORY name={code} memType={DDR3} dataWidth={32} clockFreq={525.000000} readRate={0.5} writeRate={0.5} /><IO interface={I2C} ioStandard={} bidis={1} ioBank={} clockFreq={108.333336} usageRate={0.5} /><IO interface={UART} ioStandard={LVCMOS18} bidis={2} ioBank={Vcco_p1} clockFreq={50.000000} usageRate={0.5} /><IO interface={SD} ioStandard={LVCMOS18} bidis={7} ioBank={Vcco_p1} clockFreq={50.000000} usageRate={0.5} /><IO interface={USB} ioStandard={LVCMOS18} bidis={12} ioBank={Vcco_p1} clockFreq={60} usageRate={0.5} /><IO interface={GigE} ioStandard={LVCMOS18} bidis={14} ioBank={Vcco_p1} clockFreq={125.000000} usageRate={0.5} /><IO interface={QSPI} ioStandard={LVCMOS33} bidis={7} ioBank={Vcco_p0} clockFreq={200} usageRate={0.5} /><PLL domain={Processor} vco={1300.000} /><PLL domain={Memory} vco={1050.000} /><PLL domain={IO} vco={1000.000} /><AXI interface={S_AXI_HP0} dataWidth={64} clockFreq={150} usageRate={0.5} /><AXI interface={M_AXI_GP0} dataWidth={32} clockFreq={100} usageRate={0.5} />/>" *)

module processing_system7_v5_4_processing_system7 #(
  parameter integer C_USE_DEFAULT_ACP_USER_VAL = 1,
  parameter integer C_S_AXI_ACP_ARUSER_VAL = 31,
  parameter integer C_S_AXI_ACP_AWUSER_VAL = 31,
  parameter integer C_M_AXI_GP0_THREAD_ID_WIDTH = 12,
  parameter integer C_M_AXI_GP1_THREAD_ID_WIDTH = 12,
  parameter integer C_M_AXI_GP0_ENABLE_STATIC_REMAP = 1,
  parameter integer C_M_AXI_GP1_ENABLE_STATIC_REMAP = 1,
  parameter integer C_M_AXI_GP0_ID_WIDTH = 12,
  parameter integer C_M_AXI_GP1_ID_WIDTH = 12,
  parameter integer C_S_AXI_GP0_ID_WIDTH = 6,
  parameter integer C_S_AXI_GP1_ID_WIDTH = 6,
  parameter integer C_S_AXI_HP0_ID_WIDTH = 6,
  parameter integer C_S_AXI_HP1_ID_WIDTH = 6,
  parameter integer C_S_AXI_HP2_ID_WIDTH = 6,
  parameter integer C_S_AXI_HP3_ID_WIDTH = 6,
  parameter integer C_S_AXI_ACP_ID_WIDTH = 3,
  parameter integer C_S_AXI_HP0_DATA_WIDTH = 64,
  parameter integer C_S_AXI_HP1_DATA_WIDTH = 64,
  parameter integer C_S_AXI_HP2_DATA_WIDTH = 64,
  parameter integer C_S_AXI_HP3_DATA_WIDTH = 64,
  parameter integer C_INCLUDE_ACP_TRANS_CHECK = 0,
  parameter integer C_NUM_F2P_INTR_INPUTS = 1,
  parameter         C_FCLK_CLK0_BUF = "TRUE",
  parameter         C_FCLK_CLK1_BUF = "TRUE",
  parameter         C_FCLK_CLK2_BUF = "TRUE",
  parameter         C_FCLK_CLK3_BUF = "TRUE",
  parameter integer C_EMIO_GPIO_WIDTH = 64,
  parameter integer C_INCLUDE_TRACE_BUFFER = 0,
  parameter integer C_TRACE_BUFFER_FIFO_SIZE = 128,
  parameter integer C_TRACE_BUFFER_CLOCK_DELAY = 12,
  parameter integer USE_TRACE_DATA_EDGE_DETECTOR = 0,
  parameter integer C_TRACE_PIPELINE_WIDTH = 8,
  parameter         C_PS7_SI_REV = "PRODUCTION",
  parameter integer C_EN_EMIO_ENET0 = 0,
  parameter integer C_EN_EMIO_ENET1 = 0,
  parameter integer C_EN_EMIO_TRACE = 0,
  parameter integer C_DQ_WIDTH = 32,
  parameter integer C_DQS_WIDTH = 4,
  parameter integer C_DM_WIDTH = 4,
  parameter integer C_MIO_PRIMITIVE = 54,
  parameter            C_PACKAGE_NAME = "clg484",
  parameter C_IRQ_F2P_MODE = "DIRECT"
)
(
  output          CAN0_PHY_TX,
  input           CAN0_PHY_RX,
  output          CAN1_PHY_TX,
  input           CAN1_PHY_RX,
  output reg      ENET0_GMII_TX_EN,
  output reg      ENET0_GMII_TX_ER,
  output          ENET0_MDIO_MDC,
  output          ENET0_MDIO_O,
  output          ENET0_MDIO_T,
  output          ENET0_PTP_DELAY_REQ_RX,
  output          ENET0_PTP_DELAY_REQ_TX,
  output          ENET0_PTP_PDELAY_REQ_RX,
  output          ENET0_PTP_PDELAY_REQ_TX,
  output          ENET0_PTP_PDELAY_RESP_RX,
  output          ENET0_PTP_PDELAY_RESP_TX,
  output          ENET0_PTP_SYNC_FRAME_RX,
  output          ENET0_PTP_SYNC_FRAME_TX,
  output          ENET0_SOF_RX,
  output          ENET0_SOF_TX,
  output reg [7:0]    ENET0_GMII_TXD,
  input           ENET0_GMII_COL,
  input           ENET0_GMII_CRS,
  input           ENET0_GMII_RX_CLK,
  input           ENET0_GMII_RX_DV,
  input           ENET0_GMII_RX_ER,
  input           ENET0_GMII_TX_CLK,
  input           ENET0_MDIO_I,
  input           ENET0_EXT_INTIN,
  input [7:0]     ENET0_GMII_RXD,
  output reg      ENET1_GMII_TX_EN,
  output reg      ENET1_GMII_TX_ER,
  output          ENET1_MDIO_MDC,
  output          ENET1_MDIO_O,
  output          ENET1_MDIO_T,
  output          ENET1_PTP_DELAY_REQ_RX,
  output          ENET1_PTP_DELAY_REQ_TX,
  output          ENET1_PTP_PDELAY_REQ_RX,
  output          ENET1_PTP_PDELAY_REQ_TX,
  output          ENET1_PTP_PDELAY_RESP_RX,
  output          ENET1_PTP_PDELAY_RESP_TX,
  output          ENET1_PTP_SYNC_FRAME_RX,
  output          ENET1_PTP_SYNC_FRAME_TX,
  output          ENET1_SOF_RX,
  output          ENET1_SOF_TX,
  output reg [7:0]    ENET1_GMII_TXD,
  input          ENET1_GMII_COL,
  input          ENET1_GMII_CRS,
  input          ENET1_GMII_RX_CLK,
  input          ENET1_GMII_RX_DV,
  input          ENET1_GMII_RX_ER,
  input          ENET1_GMII_TX_CLK,
  input          ENET1_MDIO_I,
  input          ENET1_EXT_INTIN,
  input [7:0]    ENET1_GMII_RXD,
  input    [(C_EMIO_GPIO_WIDTH-1):0] GPIO_I,
  output   [(C_EMIO_GPIO_WIDTH-1):0] GPIO_O,
  output   [(C_EMIO_GPIO_WIDTH-1):0] GPIO_T,
  input           I2C0_SDA_I,
  output          I2C0_SDA_O,
  output          I2C0_SDA_T,
  input           I2C0_SCL_I,
  output          I2C0_SCL_O,
  output          I2C0_SCL_T,
  input           I2C1_SDA_I,
  output          I2C1_SDA_O,
  output          I2C1_SDA_T,
  input           I2C1_SCL_I,
  output          I2C1_SCL_O,
  output          I2C1_SCL_T,
  input           PJTAG_TCK,
  input           PJTAG_TMS,
  input           PJTAG_TD_I,
  output          PJTAG_TD_T,
  output          PJTAG_TD_O,
  output          SDIO0_CLK,
  input           SDIO0_CLK_FB,
  output          SDIO0_CMD_O,
  input           SDIO0_CMD_I,
  output          SDIO0_CMD_T,
  input     [3:0] SDIO0_DATA_I,
  output    [3:0] SDIO0_DATA_O,
  output    [3:0] SDIO0_DATA_T,
  output          SDIO0_LED,
  input           SDIO0_CDN,
  input           SDIO0_WP,
  output          SDIO0_BUSPOW,
  output    [2:0] SDIO0_BUSVOLT,
  output          SDIO1_CLK,
  input           SDIO1_CLK_FB,
  output          SDIO1_CMD_O,
  input           SDIO1_CMD_I,
  output          SDIO1_CMD_T,
  input     [3:0] SDIO1_DATA_I,
  output    [3:0] SDIO1_DATA_O,
  output    [3:0] SDIO1_DATA_T,
  output          SDIO1_LED,
  input           SDIO1_CDN,
  input           SDIO1_WP,
  output          SDIO1_BUSPOW,
  output    [2:0] SDIO1_BUSVOLT,
  input           SPI0_SCLK_I,
  output          SPI0_SCLK_O,
  output          SPI0_SCLK_T,
  input           SPI0_MOSI_I,
  output          SPI0_MOSI_O,
  output          SPI0_MOSI_T,
  input           SPI0_MISO_I,
  output          SPI0_MISO_O,
  output          SPI0_MISO_T,
  input           SPI0_SS_I,
  output          SPI0_SS_O,
  output          SPI0_SS1_O,
  output          SPI0_SS2_O,
  output          SPI0_SS_T,
  input           SPI1_SCLK_I,
  output          SPI1_SCLK_O,
  output          SPI1_SCLK_T,
  input           SPI1_MOSI_I,
  output          SPI1_MOSI_O,
  output          SPI1_MOSI_T,
  input           SPI1_MISO_I,
  output          SPI1_MISO_O,
  output          SPI1_MISO_T,
  input           SPI1_SS_I,
  output          SPI1_SS_O,
  output          SPI1_SS1_O,
  output          SPI1_SS2_O,
  output          SPI1_SS_T,
  output          UART0_DTRN,
  output          UART0_RTSN,
  output          UART0_TX,
  input           UART0_CTSN,
  input           UART0_DCDN,
  input           UART0_DSRN,
  input           UART0_RIN,
  input           UART0_RX,
  output          UART1_DTRN,
  output          UART1_RTSN,
  output          UART1_TX,
  input           UART1_CTSN,
  input           UART1_DCDN,
  input           UART1_DSRN,
  input           UART1_RIN,
  input           UART1_RX,
  output                    TTC0_WAVE0_OUT,
  output                    TTC0_WAVE1_OUT,
  output                    TTC0_WAVE2_OUT,
  input                     TTC0_CLK0_IN,
  input                     TTC0_CLK1_IN,
  input                     TTC0_CLK2_IN,
  output                    TTC1_WAVE0_OUT,
  output                    TTC1_WAVE1_OUT,
  output                    TTC1_WAVE2_OUT,
  input                     TTC1_CLK0_IN,
  input                     TTC1_CLK1_IN,
  input                     TTC1_CLK2_IN,
  input           WDT_CLK_IN,
  output          WDT_RST_OUT,
  input           TRACE_CLK,
  output          TRACE_CTL,
  output   [31:0] TRACE_DATA,
  output   reg                  TRACE_CLK_OUT,
  output   [1:0]  USB0_PORT_INDCTL,
  output          USB0_VBUS_PWRSELECT,
  input           USB0_VBUS_PWRFAULT,
  output   [1:0]  USB1_PORT_INDCTL,
  output          USB1_VBUS_PWRSELECT,
  input           USB1_VBUS_PWRFAULT,
  input           SRAM_INTIN,
  output M_AXI_GP0_ARESETN,
  output M_AXI_GP0_ARVALID,
  output M_AXI_GP0_AWVALID,
  output M_AXI_GP0_BREADY,
  output M_AXI_GP0_RREADY,
  output M_AXI_GP0_WLAST,
  output M_AXI_GP0_WVALID,
  output [(C_M_AXI_GP0_THREAD_ID_WIDTH - 1):0] M_AXI_GP0_ARID,
  output [(C_M_AXI_GP0_THREAD_ID_WIDTH - 1):0] M_AXI_GP0_AWID,
  output [(C_M_AXI_GP0_THREAD_ID_WIDTH - 1):0] M_AXI_GP0_WID,
  output [1:0] M_AXI_GP0_ARBURST,
  output [1:0] M_AXI_GP0_ARLOCK,
  output [2:0] M_AXI_GP0_ARSIZE,
  output [1:0] M_AXI_GP0_AWBURST,
  output [1:0] M_AXI_GP0_AWLOCK,
  output [2:0] M_AXI_GP0_AWSIZE,
  output [2:0] M_AXI_GP0_ARPROT,
  output [2:0] M_AXI_GP0_AWPROT,
  output [31:0] M_AXI_GP0_ARADDR,
  output [31:0] M_AXI_GP0_AWADDR,
  output [31:0] M_AXI_GP0_WDATA,
  output [3:0] M_AXI_GP0_ARCACHE,
  output [3:0] M_AXI_GP0_ARLEN,
  output [3:0] M_AXI_GP0_ARQOS,
  output [3:0] M_AXI_GP0_AWCACHE,
  output [3:0] M_AXI_GP0_AWLEN,
  output [3:0] M_AXI_GP0_AWQOS,
  output [3:0] M_AXI_GP0_WSTRB,
  input M_AXI_GP0_ACLK,
  input M_AXI_GP0_ARREADY,
  input M_AXI_GP0_AWREADY,
  input M_AXI_GP0_BVALID,
  input M_AXI_GP0_RLAST,
  input M_AXI_GP0_RVALID,
  input M_AXI_GP0_WREADY,
  input [(C_M_AXI_GP0_THREAD_ID_WIDTH - 1):0] M_AXI_GP0_BID,
  input [(C_M_AXI_GP0_THREAD_ID_WIDTH - 1):0] M_AXI_GP0_RID,
  input [1:0] M_AXI_GP0_BRESP,
  input [1:0] M_AXI_GP0_RRESP,
  input [31:0] M_AXI_GP0_RDATA,
  output M_AXI_GP1_ARESETN,
  output M_AXI_GP1_ARVALID,
  output M_AXI_GP1_AWVALID,
  output M_AXI_GP1_BREADY,
  output M_AXI_GP1_RREADY,
  output M_AXI_GP1_WLAST,
  output M_AXI_GP1_WVALID,
  output [(C_M_AXI_GP1_THREAD_ID_WIDTH - 1):0] M_AXI_GP1_ARID,
  output [(C_M_AXI_GP1_THREAD_ID_WIDTH - 1):0] M_AXI_GP1_AWID,
  output [(C_M_AXI_GP1_THREAD_ID_WIDTH - 1):0] M_AXI_GP1_WID,
  output [1:0] M_AXI_GP1_ARBURST,
  output [1:0] M_AXI_GP1_ARLOCK,
  output [2:0] M_AXI_GP1_ARSIZE,
  output [1:0] M_AXI_GP1_AWBURST,
  output [1:0] M_AXI_GP1_AWLOCK,
  output [2:0] M_AXI_GP1_AWSIZE,
  output [2:0] M_AXI_GP1_ARPROT,
  output [2:0] M_AXI_GP1_AWPROT,
  output [31:0] M_AXI_GP1_ARADDR,
  output [31:0] M_AXI_GP1_AWADDR,
  output [31:0] M_AXI_GP1_WDATA,
  output [3:0] M_AXI_GP1_ARCACHE,
  output [3:0] M_AXI_GP1_ARLEN,
  output [3:0] M_AXI_GP1_ARQOS,
  output [3:0] M_AXI_GP1_AWCACHE,
  output [3:0] M_AXI_GP1_AWLEN,
  output [3:0] M_AXI_GP1_AWQOS,
  output [3:0] M_AXI_GP1_WSTRB,
  input M_AXI_GP1_ACLK,
  input M_AXI_GP1_ARREADY,
  input M_AXI_GP1_AWREADY,
  input M_AXI_GP1_BVALID,
  input M_AXI_GP1_RLAST,
  input M_AXI_GP1_RVALID,
  input M_AXI_GP1_WREADY,
  input [(C_M_AXI_GP1_THREAD_ID_WIDTH - 1):0] M_AXI_GP1_BID,
  input [(C_M_AXI_GP1_THREAD_ID_WIDTH - 1):0] M_AXI_GP1_RID,
  input [1:0] M_AXI_GP1_BRESP,
  input [1:0] M_AXI_GP1_RRESP,
  input [31:0] M_AXI_GP1_RDATA,
  output S_AXI_GP0_ARESETN,
  output S_AXI_GP0_ARREADY,
  output S_AXI_GP0_AWREADY,
  output S_AXI_GP0_BVALID,
  output S_AXI_GP0_RLAST,
  output S_AXI_GP0_RVALID,
  output S_AXI_GP0_WREADY,
  output [1:0] S_AXI_GP0_BRESP,
  output [1:0] S_AXI_GP0_RRESP,
  output [31:0] S_AXI_GP0_RDATA,
  output [(C_S_AXI_GP0_ID_WIDTH - 1) : 0] S_AXI_GP0_BID,
  output [(C_S_AXI_GP0_ID_WIDTH - 1) : 0] S_AXI_GP0_RID,
  input S_AXI_GP0_ACLK,
  input S_AXI_GP0_ARVALID,
  input S_AXI_GP0_AWVALID,
  input S_AXI_GP0_BREADY,
  input S_AXI_GP0_RREADY,
  input S_AXI_GP0_WLAST,
  input S_AXI_GP0_WVALID,
  input [1:0] S_AXI_GP0_ARBURST,
  input [1:0] S_AXI_GP0_ARLOCK,
  input [2:0] S_AXI_GP0_ARSIZE,
  input [1:0] S_AXI_GP0_AWBURST,
  input [1:0] S_AXI_GP0_AWLOCK,
  input [2:0] S_AXI_GP0_AWSIZE,
  input [2:0] S_AXI_GP0_ARPROT,
  input [2:0] S_AXI_GP0_AWPROT,
  input [31:0] S_AXI_GP0_ARADDR,
  input [31:0] S_AXI_GP0_AWADDR,
  input [31:0] S_AXI_GP0_WDATA,
  input [3:0] S_AXI_GP0_ARCACHE,
  input [3:0] S_AXI_GP0_ARLEN,
  input [3:0] S_AXI_GP0_ARQOS,
  input [3:0] S_AXI_GP0_AWCACHE,
  input [3:0] S_AXI_GP0_AWLEN,
  input [3:0] S_AXI_GP0_AWQOS,
  input [3:0] S_AXI_GP0_WSTRB,
  input [(C_S_AXI_GP0_ID_WIDTH - 1) : 0] S_AXI_GP0_ARID,
  input [(C_S_AXI_GP0_ID_WIDTH - 1) : 0] S_AXI_GP0_AWID,
  input [(C_S_AXI_GP0_ID_WIDTH - 1) : 0] S_AXI_GP0_WID,
  output S_AXI_GP1_ARESETN,
  output S_AXI_GP1_ARREADY,
  output S_AXI_GP1_AWREADY,
  output S_AXI_GP1_BVALID,
  output S_AXI_GP1_RLAST,
  output S_AXI_GP1_RVALID,
  output S_AXI_GP1_WREADY,
  output [1:0] S_AXI_GP1_BRESP,
  output [1:0] S_AXI_GP1_RRESP,
  output [31:0] S_AXI_GP1_RDATA,
  output [(C_S_AXI_GP1_ID_WIDTH - 1) : 0] S_AXI_GP1_BID,
  output [(C_S_AXI_GP1_ID_WIDTH - 1) : 0] S_AXI_GP1_RID,
  input S_AXI_GP1_ACLK,
  input S_AXI_GP1_ARVALID,
  input S_AXI_GP1_AWVALID,
  input S_AXI_GP1_BREADY,
  input S_AXI_GP1_RREADY,
  input S_AXI_GP1_WLAST,
  input S_AXI_GP1_WVALID,
  input [1:0] S_AXI_GP1_ARBURST,
  input [1:0] S_AXI_GP1_ARLOCK,
  input [2:0] S_AXI_GP1_ARSIZE,
  input [1:0] S_AXI_GP1_AWBURST,
  input [1:0] S_AXI_GP1_AWLOCK,
  input [2:0] S_AXI_GP1_AWSIZE,
  input [2:0] S_AXI_GP1_ARPROT,
  input [2:0] S_AXI_GP1_AWPROT,
  input [31:0] S_AXI_GP1_ARADDR,
  input [31:0] S_AXI_GP1_AWADDR,
  input [31:0] S_AXI_GP1_WDATA,
  input [3:0] S_AXI_GP1_ARCACHE,
  input [3:0] S_AXI_GP1_ARLEN,
  input [3:0] S_AXI_GP1_ARQOS,
  input [3:0] S_AXI_GP1_AWCACHE,
  input [3:0] S_AXI_GP1_AWLEN,
  input [3:0] S_AXI_GP1_AWQOS,
  input [3:0] S_AXI_GP1_WSTRB,
  input [(C_S_AXI_GP1_ID_WIDTH - 1) : 0] S_AXI_GP1_ARID,
  input [(C_S_AXI_GP1_ID_WIDTH - 1) : 0] S_AXI_GP1_AWID,
  input [(C_S_AXI_GP1_ID_WIDTH - 1) : 0] S_AXI_GP1_WID,
  output S_AXI_ACP_ARESETN,
  output S_AXI_ACP_ARREADY,
  output S_AXI_ACP_AWREADY,
  output S_AXI_ACP_BVALID,
  output S_AXI_ACP_RLAST,
  output S_AXI_ACP_RVALID,
  output S_AXI_ACP_WREADY,
  output [1:0] S_AXI_ACP_BRESP,
  output [1:0] S_AXI_ACP_RRESP,
  output [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ACP_BID,
  output [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ACP_RID,
  output [63:0] S_AXI_ACP_RDATA,
  input S_AXI_ACP_ACLK,
  input S_AXI_ACP_ARVALID,
  input S_AXI_ACP_AWVALID,
  input S_AXI_ACP_BREADY,
  input S_AXI_ACP_RREADY,
  input S_AXI_ACP_WLAST,
  input S_AXI_ACP_WVALID,
  input [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ACP_ARID,
  input [2:0] S_AXI_ACP_ARPROT,
  input [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ACP_AWID,
  input [2:0] S_AXI_ACP_AWPROT,
  input [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ACP_WID,
  input [31:0] S_AXI_ACP_ARADDR,
  input [31:0] S_AXI_ACP_AWADDR,
  input [3:0] S_AXI_ACP_ARCACHE,
  input [3:0] S_AXI_ACP_ARLEN,
  input [3:0] S_AXI_ACP_ARQOS,
  input [3:0] S_AXI_ACP_AWCACHE,
  input [3:0] S_AXI_ACP_AWLEN,
  input [3:0] S_AXI_ACP_AWQOS,
  input [1:0] S_AXI_ACP_ARBURST,
  input [1:0] S_AXI_ACP_ARLOCK,
  input [2:0] S_AXI_ACP_ARSIZE,
  input [1:0] S_AXI_ACP_AWBURST,
  input [1:0] S_AXI_ACP_AWLOCK,
  input [2:0] S_AXI_ACP_AWSIZE,
  input [4:0] S_AXI_ACP_ARUSER,
  input [4:0] S_AXI_ACP_AWUSER,
  input [63:0] S_AXI_ACP_WDATA,
  input [7:0] S_AXI_ACP_WSTRB,
  output S_AXI_HP0_ARESETN,
  output S_AXI_HP0_ARREADY,
  output S_AXI_HP0_AWREADY,
  output S_AXI_HP0_BVALID,
  output S_AXI_HP0_RLAST,
  output S_AXI_HP0_RVALID,
  output S_AXI_HP0_WREADY,
  output [1:0] S_AXI_HP0_BRESP,
  output [1:0] S_AXI_HP0_RRESP,
  output [(C_S_AXI_HP0_ID_WIDTH - 1) : 0] S_AXI_HP0_BID,
  output [(C_S_AXI_HP0_ID_WIDTH - 1) : 0] S_AXI_HP0_RID,
  output [(C_S_AXI_HP0_DATA_WIDTH - 1) :0] S_AXI_HP0_RDATA,
  output [7:0] S_AXI_HP0_RCOUNT,
  output [7:0] S_AXI_HP0_WCOUNT,
  output [2:0] S_AXI_HP0_RACOUNT,
  output [5:0] S_AXI_HP0_WACOUNT,
  input S_AXI_HP0_ACLK,
  input S_AXI_HP0_ARVALID,
  input S_AXI_HP0_AWVALID,
  input S_AXI_HP0_BREADY,
  input S_AXI_HP0_RDISSUECAP1_EN,
  input S_AXI_HP0_RREADY,
  input S_AXI_HP0_WLAST,
  input S_AXI_HP0_WRISSUECAP1_EN,
  input S_AXI_HP0_WVALID,
  input [1:0] S_AXI_HP0_ARBURST,
  input [1:0] S_AXI_HP0_ARLOCK,
  input [2:0] S_AXI_HP0_ARSIZE,
  input [1:0] S_AXI_HP0_AWBURST,
  input [1:0] S_AXI_HP0_AWLOCK,
  input [2:0] S_AXI_HP0_AWSIZE,
  input [2:0] S_AXI_HP0_ARPROT,
  input [2:0] S_AXI_HP0_AWPROT,
  input [31:0] S_AXI_HP0_ARADDR,
  input [31:0] S_AXI_HP0_AWADDR,
  input [3:0] S_AXI_HP0_ARCACHE,
  input [3:0] S_AXI_HP0_ARLEN,
  input [3:0] S_AXI_HP0_ARQOS,
  input [3:0] S_AXI_HP0_AWCACHE,
  input [3:0] S_AXI_HP0_AWLEN,
  input [3:0] S_AXI_HP0_AWQOS,
  input [(C_S_AXI_HP0_ID_WIDTH - 1) : 0] S_AXI_HP0_ARID,
  input [(C_S_AXI_HP0_ID_WIDTH - 1) : 0] S_AXI_HP0_AWID,
  input [(C_S_AXI_HP0_ID_WIDTH - 1) : 0] S_AXI_HP0_WID,
  input [(C_S_AXI_HP0_DATA_WIDTH - 1) :0] S_AXI_HP0_WDATA,
  input [((C_S_AXI_HP0_DATA_WIDTH/8)-1):0] S_AXI_HP0_WSTRB,
  output S_AXI_HP1_ARESETN,
  output S_AXI_HP1_ARREADY,
  output S_AXI_HP1_AWREADY,
  output S_AXI_HP1_BVALID,
  output S_AXI_HP1_RLAST,
  output S_AXI_HP1_RVALID,
  output S_AXI_HP1_WREADY,
  output [1:0] S_AXI_HP1_BRESP,
  output [1:0] S_AXI_HP1_RRESP,
  output [(C_S_AXI_HP1_ID_WIDTH - 1) : 0] S_AXI_HP1_BID,
  output [(C_S_AXI_HP1_ID_WIDTH - 1) : 0] S_AXI_HP1_RID,
  output [(C_S_AXI_HP1_DATA_WIDTH - 1) :0] S_AXI_HP1_RDATA,
  output [7:0] S_AXI_HP1_RCOUNT,
  output [7:0] S_AXI_HP1_WCOUNT,
  output [2:0] S_AXI_HP1_RACOUNT,
  output [5:0] S_AXI_HP1_WACOUNT,
  input S_AXI_HP1_ACLK,
  input S_AXI_HP1_ARVALID,
  input S_AXI_HP1_AWVALID,
  input S_AXI_HP1_BREADY,
  input S_AXI_HP1_RDISSUECAP1_EN,
  input S_AXI_HP1_RREADY,
  input S_AXI_HP1_WLAST,
  input S_AXI_HP1_WRISSUECAP1_EN,
  input S_AXI_HP1_WVALID,
  input [1:0] S_AXI_HP1_ARBURST,
  input [1:0] S_AXI_HP1_ARLOCK,
  input [2:0] S_AXI_HP1_ARSIZE,
  input [1:0] S_AXI_HP1_AWBURST,
  input [1:0] S_AXI_HP1_AWLOCK,
  input [2:0] S_AXI_HP1_AWSIZE,
  input [2:0] S_AXI_HP1_ARPROT,
  input [2:0] S_AXI_HP1_AWPROT,
  input [31:0] S_AXI_HP1_ARADDR,
  input [31:0] S_AXI_HP1_AWADDR,
  input [3:0] S_AXI_HP1_ARCACHE,
  input [3:0] S_AXI_HP1_ARLEN,
  input [3:0] S_AXI_HP1_ARQOS,
  input [3:0] S_AXI_HP1_AWCACHE,
  input [3:0] S_AXI_HP1_AWLEN,
  input [3:0] S_AXI_HP1_AWQOS,
  input [(C_S_AXI_HP1_ID_WIDTH - 1) : 0] S_AXI_HP1_ARID,
  input [(C_S_AXI_HP1_ID_WIDTH - 1) : 0] S_AXI_HP1_AWID,
  input [(C_S_AXI_HP1_ID_WIDTH - 1) : 0] S_AXI_HP1_WID,
  input [(C_S_AXI_HP1_DATA_WIDTH - 1) :0] S_AXI_HP1_WDATA,
  input [((C_S_AXI_HP1_DATA_WIDTH/8)-1):0] S_AXI_HP1_WSTRB,
  output S_AXI_HP2_ARESETN,
  output S_AXI_HP2_ARREADY,
  output S_AXI_HP2_AWREADY,
  output S_AXI_HP2_BVALID,
  output S_AXI_HP2_RLAST,
  output S_AXI_HP2_RVALID,
  output S_AXI_HP2_WREADY,
  output [1:0] S_AXI_HP2_BRESP,
  output [1:0] S_AXI_HP2_RRESP,
  output [(C_S_AXI_HP2_ID_WIDTH - 1) : 0] S_AXI_HP2_BID,
  output [(C_S_AXI_HP2_ID_WIDTH - 1) : 0] S_AXI_HP2_RID,
  output [(C_S_AXI_HP2_DATA_WIDTH - 1) :0] S_AXI_HP2_RDATA,
  output [7:0] S_AXI_HP2_RCOUNT,
  output [7:0] S_AXI_HP2_WCOUNT,
  output [2:0] S_AXI_HP2_RACOUNT,
  output [5:0] S_AXI_HP2_WACOUNT,
  input S_AXI_HP2_ACLK,
  input S_AXI_HP2_ARVALID,
  input S_AXI_HP2_AWVALID,
  input S_AXI_HP2_BREADY,
  input S_AXI_HP2_RDISSUECAP1_EN,
  input S_AXI_HP2_RREADY,
  input S_AXI_HP2_WLAST,
  input S_AXI_HP2_WRISSUECAP1_EN,
  input S_AXI_HP2_WVALID,
  input [1:0] S_AXI_HP2_ARBURST,
  input [1:0] S_AXI_HP2_ARLOCK,
  input [2:0] S_AXI_HP2_ARSIZE,
  input [1:0] S_AXI_HP2_AWBURST,
  input [1:0] S_AXI_HP2_AWLOCK,
  input [2:0] S_AXI_HP2_AWSIZE,
  input [2:0] S_AXI_HP2_ARPROT,
  input [2:0] S_AXI_HP2_AWPROT,
  input [31:0] S_AXI_HP2_ARADDR,
  input [31:0] S_AXI_HP2_AWADDR,
  input [3:0] S_AXI_HP2_ARCACHE,
  input [3:0] S_AXI_HP2_ARLEN,
  input [3:0] S_AXI_HP2_ARQOS,
  input [3:0] S_AXI_HP2_AWCACHE,
  input [3:0] S_AXI_HP2_AWLEN,
  input [3:0] S_AXI_HP2_AWQOS,
  input [(C_S_AXI_HP2_ID_WIDTH - 1) : 0] S_AXI_HP2_ARID,
  input [(C_S_AXI_HP2_ID_WIDTH - 1) : 0] S_AXI_HP2_AWID,
  input [(C_S_AXI_HP2_ID_WIDTH - 1) : 0] S_AXI_HP2_WID,
  input [(C_S_AXI_HP2_DATA_WIDTH - 1) :0] S_AXI_HP2_WDATA,
  input [((C_S_AXI_HP2_DATA_WIDTH/8)-1):0] S_AXI_HP2_WSTRB,
  output S_AXI_HP3_ARESETN,
  output S_AXI_HP3_ARREADY,
  output S_AXI_HP3_AWREADY,
  output S_AXI_HP3_BVALID,
  output S_AXI_HP3_RLAST,
  output S_AXI_HP3_RVALID,
  output S_AXI_HP3_WREADY,
  output [1:0] S_AXI_HP3_BRESP,
  output [1:0] S_AXI_HP3_RRESP,
  output [(C_S_AXI_HP3_ID_WIDTH - 1) : 0] S_AXI_HP3_BID,
  output [(C_S_AXI_HP3_ID_WIDTH - 1) : 0] S_AXI_HP3_RID,
  output [(C_S_AXI_HP3_DATA_WIDTH - 1) :0] S_AXI_HP3_RDATA,
  output [7:0] S_AXI_HP3_RCOUNT,
  output [7:0] S_AXI_HP3_WCOUNT,
  output [2:0] S_AXI_HP3_RACOUNT,
  output [5:0] S_AXI_HP3_WACOUNT,
  input S_AXI_HP3_ACLK,
  input S_AXI_HP3_ARVALID,
  input S_AXI_HP3_AWVALID,
  input S_AXI_HP3_BREADY,
  input S_AXI_HP3_RDISSUECAP1_EN,
  input S_AXI_HP3_RREADY,
  input S_AXI_HP3_WLAST,
  input S_AXI_HP3_WRISSUECAP1_EN,
  input S_AXI_HP3_WVALID,
  input [1:0] S_AXI_HP3_ARBURST,
  input [1:0] S_AXI_HP3_ARLOCK,
  input [2:0] S_AXI_HP3_ARSIZE,
  input [1:0] S_AXI_HP3_AWBURST,
  input [1:0] S_AXI_HP3_AWLOCK,
  input [2:0] S_AXI_HP3_AWSIZE,
  input [2:0] S_AXI_HP3_ARPROT,
  input [2:0] S_AXI_HP3_AWPROT,
  input [31:0] S_AXI_HP3_ARADDR,
  input [31:0] S_AXI_HP3_AWADDR,
  input [3:0] S_AXI_HP3_ARCACHE,
  input [3:0] S_AXI_HP3_ARLEN,
  input [3:0] S_AXI_HP3_ARQOS,
  input [3:0] S_AXI_HP3_AWCACHE,
  input [3:0] S_AXI_HP3_AWLEN,
  input [3:0] S_AXI_HP3_AWQOS,
  input [(C_S_AXI_HP3_ID_WIDTH - 1) : 0] S_AXI_HP3_ARID,
  input [(C_S_AXI_HP3_ID_WIDTH - 1) : 0] S_AXI_HP3_AWID,
  input [(C_S_AXI_HP3_ID_WIDTH - 1) : 0] S_AXI_HP3_WID,
  input [(C_S_AXI_HP3_DATA_WIDTH - 1) :0] S_AXI_HP3_WDATA,
  input [((C_S_AXI_HP3_DATA_WIDTH/8)-1):0] S_AXI_HP3_WSTRB,
  output IRQ_P2F_DMAC_ABORT ,
  output IRQ_P2F_DMAC0,
  output IRQ_P2F_DMAC1,
  output IRQ_P2F_DMAC2,
  output IRQ_P2F_DMAC3,
  output IRQ_P2F_DMAC4,
  output IRQ_P2F_DMAC5,
  output IRQ_P2F_DMAC6,
  output IRQ_P2F_DMAC7,
  output IRQ_P2F_SMC,
  output IRQ_P2F_QSPI,
  output IRQ_P2F_CTI,
  output IRQ_P2F_GPIO,
  output IRQ_P2F_USB0,
  output IRQ_P2F_ENET0,
  output IRQ_P2F_ENET_WAKE0,
  output IRQ_P2F_SDIO0,
  output IRQ_P2F_I2C0,
  output IRQ_P2F_SPI0,
  output IRQ_P2F_UART0,
  output IRQ_P2F_CAN0,
  output IRQ_P2F_USB1,
  output IRQ_P2F_ENET1,
  output IRQ_P2F_ENET_WAKE1,
  output IRQ_P2F_SDIO1,
  output IRQ_P2F_I2C1,
  output IRQ_P2F_SPI1,
  output IRQ_P2F_UART1,
  output IRQ_P2F_CAN1,
  input  [(C_NUM_F2P_INTR_INPUTS-1):0] IRQ_F2P,
  input         Core0_nFIQ,
  input         Core0_nIRQ,
  input         Core1_nFIQ,
  input         Core1_nIRQ,
  output [1:0] DMA0_DATYPE,
  output DMA0_DAVALID,
  output DMA0_DRREADY,
  output DMA0_RSTN,
  output [1:0] DMA1_DATYPE,
  output DMA1_DAVALID,
  output DMA1_DRREADY,
  output DMA1_RSTN,
  output [1:0] DMA2_DATYPE,
  output DMA2_DAVALID,
  output DMA2_DRREADY,
  output DMA2_RSTN,
  output [1:0] DMA3_DATYPE,
  output DMA3_DAVALID,
  output DMA3_DRREADY,
  output DMA3_RSTN,
  input DMA0_ACLK,
  input DMA0_DAREADY,
  input DMA0_DRLAST,
  input DMA0_DRVALID,
  input DMA1_ACLK,
  input DMA1_DAREADY,
  input DMA1_DRLAST,
  input DMA1_DRVALID,
  input DMA2_ACLK,
  input DMA2_DAREADY,
  input DMA2_DRLAST,
  input DMA2_DRVALID,
  input DMA3_ACLK,
  input DMA3_DAREADY,
  input DMA3_DRLAST,
  input DMA3_DRVALID,
  input [1:0] DMA0_DRTYPE,
  input [1:0] DMA1_DRTYPE,
  input [1:0] DMA2_DRTYPE,
  input [1:0] DMA3_DRTYPE,
  output    FCLK_CLK3,
  output    FCLK_CLK2,
  output    FCLK_CLK1,
  output    FCLK_CLK0,
  input     FCLK_CLKTRIG3_N,
  input     FCLK_CLKTRIG2_N,
  input     FCLK_CLKTRIG1_N,
  input     FCLK_CLKTRIG0_N,
  output    FCLK_RESET3_N,
  output    FCLK_RESET2_N,
  output    FCLK_RESET1_N,
  output    FCLK_RESET0_N,
  input    [31:0] FTMD_TRACEIN_DATA,
  input           FTMD_TRACEIN_VALID,
  input           FTMD_TRACEIN_CLK,
  input    [3:0]  FTMD_TRACEIN_ATID,
  input     FTMT_F2P_TRIG_0,
  output    FTMT_F2P_TRIGACK_0,
  input     FTMT_F2P_TRIG_1,
  output    FTMT_F2P_TRIGACK_1,
  input     FTMT_F2P_TRIG_2,
  output    FTMT_F2P_TRIGACK_2,
  input     FTMT_F2P_TRIG_3,
  output    FTMT_F2P_TRIGACK_3,
  input     [31:0] FTMT_F2P_DEBUG,
  input     FTMT_P2F_TRIGACK_0,
  output    FTMT_P2F_TRIG_0,
  input     FTMT_P2F_TRIGACK_1,
  output    FTMT_P2F_TRIG_1,
  input     FTMT_P2F_TRIGACK_2,
  output    FTMT_P2F_TRIG_2,
  input     FTMT_P2F_TRIGACK_3,
  output    FTMT_P2F_TRIG_3,
  output    [31:0] FTMT_P2F_DEBUG,
  input           FPGA_IDLE_N,
  output EVENT_EVENTO,
  output [1:0] EVENT_STANDBYWFE,
  output [1:0] EVENT_STANDBYWFI,
  input EVENT_EVENTI,
  input     [3:0] DDR_ARB,
  inout     [C_MIO_PRIMITIVE - 1:0] MIO,
  inout         DDR_CAS_n,       // CASB
  inout         DDR_CKE,         // CKE
  inout         DDR_Clk_n,       // CKN
  inout         DDR_Clk,         // CKP
  inout         DDR_CS_n,        // CSB
  inout         DDR_DRSTB,       // DDR_DRSTB
  inout         DDR_ODT,         // ODT
  inout         DDR_RAS_n,       // RASB
  inout         DDR_WEB,
  inout  [2:0]  DDR_BankAddr,    // BA
  inout  [14:0] DDR_Addr,        // A
  inout          DDR_VRN,
  inout          DDR_VRP,
  inout   [C_DM_WIDTH - 1:0]  DDR_DM,          // DM
  inout   [C_DQ_WIDTH - 1:0] DDR_DQ,          // DQ
  inout   [C_DQS_WIDTH -1:0]  DDR_DQS_n,       // DQSN
  inout   [C_DQS_WIDTH - 1:0]  DDR_DQS,         // DQSP
  inout          PS_SRSTB,        // SRSTB
  inout          PS_CLK,          // CLK
  inout          PS_PORB         // PORB
);
wire [11:0]  M_AXI_GP0_AWID_FULL;
wire [11:0]  M_AXI_GP0_WID_FULL;
wire [11:0]  M_AXI_GP0_ARID_FULL;
wire [11:0]  M_AXI_GP0_BID_FULL;
wire [11:0]  M_AXI_GP0_RID_FULL;
wire [11:0]  M_AXI_GP1_AWID_FULL;
wire [11:0]  M_AXI_GP1_WID_FULL;
wire [11:0]  M_AXI_GP1_ARID_FULL;
wire [11:0]  M_AXI_GP1_BID_FULL;
wire [11:0]  M_AXI_GP1_RID_FULL;
wire         ENET0_GMII_TX_EN_i;
wire         ENET0_GMII_TX_ER_i;
reg          ENET0_GMII_COL_i;
reg          ENET0_GMII_CRS_i;
reg          ENET0_GMII_RX_DV_i;
reg          ENET0_GMII_RX_ER_i;
reg [7:0]    ENET0_GMII_RXD_i;
wire [7:0]   ENET0_GMII_TXD_i;
wire         ENET1_GMII_TX_EN_i;
wire         ENET1_GMII_TX_ER_i;
reg          ENET1_GMII_COL_i;
reg          ENET1_GMII_CRS_i;
reg          ENET1_GMII_RX_DV_i;
reg          ENET1_GMII_RX_ER_i;
reg [7:0]    ENET1_GMII_RXD_i;
wire [7:0]   ENET1_GMII_TXD_i;
reg    [31:0] FTMD_TRACEIN_DATA_notracebuf;
reg           FTMD_TRACEIN_VALID_notracebuf;
reg    [3:0]  FTMD_TRACEIN_ATID_notracebuf;
wire    [31:0] FTMD_TRACEIN_DATA_i;
wire           FTMD_TRACEIN_VALID_i;
wire    [3:0]  FTMD_TRACEIN_ATID_i;
wire    [31:0] FTMD_TRACEIN_DATA_tracebuf;
wire           FTMD_TRACEIN_VALID_tracebuf;
wire    [3:0]  FTMD_TRACEIN_ATID_tracebuf;
wire [5:0]    S_AXI_GP0_BID_out;
wire [5:0]    S_AXI_GP0_RID_out;
wire [5:0]    S_AXI_GP0_ARID_in;
wire [5:0]    S_AXI_GP0_AWID_in;
wire [5:0]    S_AXI_GP0_WID_in;
wire [5:0]    S_AXI_GP1_BID_out;
wire [5:0]    S_AXI_GP1_RID_out;
wire [5:0]    S_AXI_GP1_ARID_in;
wire [5:0]    S_AXI_GP1_AWID_in;
wire [5:0]    S_AXI_GP1_WID_in;
wire [5:0]    S_AXI_HP0_BID_out;
wire [5:0]    S_AXI_HP0_RID_out;
wire [5:0]    S_AXI_HP0_ARID_in;
wire [5:0]    S_AXI_HP0_AWID_in;
wire [5:0]    S_AXI_HP0_WID_in;
wire [5:0]    S_AXI_HP1_BID_out;
wire [5:0]    S_AXI_HP1_RID_out;
wire [5:0]    S_AXI_HP1_ARID_in;
wire [5:0]    S_AXI_HP1_AWID_in;
wire [5:0]    S_AXI_HP1_WID_in;
wire [5:0]    S_AXI_HP2_BID_out;
wire [5:0]    S_AXI_HP2_RID_out;
wire [5:0]    S_AXI_HP2_ARID_in;
wire [5:0]    S_AXI_HP2_AWID_in;
wire [5:0]    S_AXI_HP2_WID_in;
wire [5:0]    S_AXI_HP3_BID_out;
wire [5:0]    S_AXI_HP3_RID_out;
wire [5:0]    S_AXI_HP3_ARID_in;
wire [5:0]    S_AXI_HP3_AWID_in;
wire [5:0]    S_AXI_HP3_WID_in;
wire [2:0]    S_AXI_ACP_BID_out;
wire [2:0]    S_AXI_ACP_RID_out;
wire [2:0]    S_AXI_ACP_ARID_in;
wire [2:0]    S_AXI_ACP_AWID_in;
wire [2:0]    S_AXI_ACP_WID_in;
wire [63:0]   S_AXI_HP0_WDATA_in;
wire [7:0]    S_AXI_HP0_WSTRB_in;
wire [63:0]   S_AXI_HP0_RDATA_out;
wire [63:0]   S_AXI_HP1_WDATA_in;
wire [7:0]    S_AXI_HP1_WSTRB_in;
wire [63:0]   S_AXI_HP1_RDATA_out;
wire [63:0]   S_AXI_HP2_WDATA_in;
wire [7:0]    S_AXI_HP2_WSTRB_in;
wire [63:0]   S_AXI_HP2_RDATA_out;
wire [63:0]   S_AXI_HP3_WDATA_in;
wire [7:0]    S_AXI_HP3_WSTRB_in;
wire [63:0]   S_AXI_HP3_RDATA_out;
wire [1:0]    M_AXI_GP0_ARSIZE_i;
wire [1:0]    M_AXI_GP0_AWSIZE_i;
wire [1:0]    M_AXI_GP1_ARSIZE_i;
wire [1:0]    M_AXI_GP1_AWSIZE_i;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0]    SAXIACPBID_W;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0]    SAXIACPRID_W;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0]    SAXIACPARID_W;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0]    SAXIACPAWID_W;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0]    SAXIACPWID_W;
wire SAXIACPARREADY_W;
wire SAXIACPAWREADY_W;
wire SAXIACPBVALID_W;
wire SAXIACPRLAST_W;
wire SAXIACPRVALID_W;
wire SAXIACPWREADY_W;
wire [1:0] SAXIACPBRESP_W;
wire [1:0] SAXIACPRRESP_W;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ATC_BID;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ATC_RID;
wire [63:0] SAXIACPRDATA_W;
wire S_AXI_ATC_ARVALID;
wire S_AXI_ATC_AWVALID;
wire S_AXI_ATC_BREADY;
wire S_AXI_ATC_RREADY;
wire S_AXI_ATC_WLAST;
wire S_AXI_ATC_WVALID;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ATC_ARID;
wire [2:0] S_AXI_ATC_ARPROT;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ATC_AWID;
wire [2:0] S_AXI_ATC_AWPROT;
wire [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] S_AXI_ATC_WID;
wire [31:0] S_AXI_ATC_ARADDR;
wire [31:0] S_AXI_ATC_AWADDR;
wire [3:0] S_AXI_ATC_ARCACHE;
wire [3:0] S_AXI_ATC_ARLEN;
wire [3:0] S_AXI_ATC_ARQOS;
wire [3:0] S_AXI_ATC_AWCACHE;
wire [3:0] S_AXI_ATC_AWLEN;
wire [3:0] S_AXI_ATC_AWQOS;
wire [1:0] S_AXI_ATC_ARBURST;
wire [1:0] S_AXI_ATC_ARLOCK;
wire [2:0] S_AXI_ATC_ARSIZE;
wire [1:0] S_AXI_ATC_AWBURST;
wire [1:0] S_AXI_ATC_AWLOCK;
wire [2:0] S_AXI_ATC_AWSIZE;
wire [4:0] S_AXI_ATC_ARUSER;
wire [4:0] S_AXI_ATC_AWUSER;
wire [63:0] S_AXI_ATC_WDATA;
wire [7:0] S_AXI_ATC_WSTRB;
wire SAXIACPARVALID_W;
wire SAXIACPAWVALID_W;
wire SAXIACPBREADY_W;
wire SAXIACPRREADY_W;
wire SAXIACPWLAST_W;
wire SAXIACPWVALID_W;
wire [2:0] SAXIACPARPROT_W;
wire [2:0] SAXIACPAWPROT_W;
wire [31:0] SAXIACPARADDR_W;
wire [31:0] SAXIACPAWADDR_W;
wire [3:0] SAXIACPARCACHE_W;
wire [3:0] SAXIACPARLEN_W;
wire [3:0] SAXIACPARQOS_W;
wire [3:0] SAXIACPAWCACHE_W;
wire [3:0] SAXIACPAWLEN_W;
wire [3:0] SAXIACPAWQOS_W;
wire [1:0] SAXIACPARBURST_W;
wire [1:0] SAXIACPARLOCK_W;
wire [2:0] SAXIACPARSIZE_W;
wire [1:0] SAXIACPAWBURST_W;
wire [1:0] SAXIACPAWLOCK_W;
wire [2:0] SAXIACPAWSIZE_W;
wire [4:0] SAXIACPARUSER_W;
wire [4:0] SAXIACPAWUSER_W;
wire [63:0] SAXIACPWDATA_W;
wire [7:0] SAXIACPWSTRB_W;
wire [4:0] param_aruser;
wire [4:0] param_awuser;
wire [3:0]   fclk_clktrig_gnd = 4'h0;
wire [19:0]   irq_f2p_i;
wire [15:0]   irq_f2p_null = 16'h0000;
wire          I2C0_SDA_T_n;
wire          I2C0_SCL_T_n;
wire          I2C1_SDA_T_n;
wire          I2C1_SCL_T_n;
wire          SPI0_SCLK_T_n;
wire          SPI0_MOSI_T_n;
wire          SPI0_MISO_T_n;
wire          SPI0_SS_T_n;
wire          SPI1_SCLK_T_n;
wire          SPI1_MOSI_T_n;
wire          SPI1_MISO_T_n;
wire          SPI1_SS_T_n;
wire          ENET0_MDIO_T_n;
wire          ENET1_MDIO_T_n;
wire  [(C_EMIO_GPIO_WIDTH-1):0]        GPIO_T_n;
wire [63:0]   gpio_out_t_n;
wire [63:0]   gpio_out;
wire [63:0]   gpio_in63_0;
wire    [3:0] FCLK_CLK_unbuffered;
wire    [3:0] FCLK_CLK_buffered;
wire          PJTAG_TD_T_n;
wire          SDIO0_CMD_T_n;
wire [3:0]    SDIO0_DATA_T_n;
wire          SDIO1_CMD_T_n;
wire [3:0]    SDIO1_DATA_T_n;
wire  [C_MIO_PRIMITIVE - 1:0]  buffered_MIO;
wire  buffered_DDR_WEB;
wire  buffered_DDR_CAS_n;
wire  buffered_DDR_CKE;
wire  buffered_DDR_Clk_n;
wire  buffered_DDR_Clk;
wire  buffered_DDR_CS_n;
wire  buffered_DDR_DRSTB;
wire  buffered_DDR_ODT;
wire  buffered_DDR_RAS_n;
wire  [2:0]  buffered_DDR_BankAddr;
wire  [14:0]  buffered_DDR_Addr;
wire  buffered_DDR_VRN;
wire  buffered_DDR_VRP;
wire  [C_DM_WIDTH - 1:0]  buffered_DDR_DM;
wire  [C_DQ_WIDTH - 1:0]  buffered_DDR_DQ;
wire  [C_DQS_WIDTH -1:0]  buffered_DDR_DQS_n;
wire  [C_DQS_WIDTH - 1:0]  buffered_DDR_DQS;
wire  buffered_PS_SRSTB;
wire  buffered_PS_CLK;
wire  buffered_PS_PORB;
wire [31:0] TRACE_DATA_i;
wire TRACE_CTL_i;
reg   TRACE_CTL_PIPE [(C_TRACE_PIPELINE_WIDTH - 1):0];
reg   [31:0] TRACE_DATA_PIPE [(C_TRACE_PIPELINE_WIDTH - 1):0];
integer j;
assign TRACE_CTL = TRACE_CTL_PIPE[0];
assign TRACE_DATA = TRACE_DATA_PIPE[0];
generate
  if(C_NUM_F2P_INTR_INPUTS == 0) begin : irq_f2p_select_null
    assign irq_f2p_i[19:0] = {Core1_nFIQ,Core0_nFIQ,Core1_nIRQ,Core0_nIRQ,irq_f2p_null[15:0]};
  end else if(C_NUM_F2P_INTR_INPUTS == 16) begin : irq_f2p_select_all
    assign irq_f2p_i[19:0] = {Core1_nFIQ,Core0_nFIQ,Core1_nIRQ,Core0_nIRQ,IRQ_F2P[15:0]};
  end else begin : irq_f2p_select
        if (C_IRQ_F2P_MODE == "DIRECT") begin
    assign irq_f2p_i[19:0] = {Core1_nFIQ,Core0_nFIQ,Core1_nIRQ,Core0_nIRQ,
                                irq_f2p_null[(15-C_NUM_F2P_INTR_INPUTS):0],
                                IRQ_F2P[(C_NUM_F2P_INTR_INPUTS-1):0]};
        end else begin
        assign irq_f2p_i[19:0] = {Core1_nFIQ,Core0_nFIQ,Core1_nIRQ,Core0_nIRQ,
                                IRQ_F2P[(C_NUM_F2P_INTR_INPUTS-1):0],
                                irq_f2p_null[(15-C_NUM_F2P_INTR_INPUTS):0]};
        end
  end
endgenerate
assign M_AXI_GP0_ARSIZE[2:0] = {1'b0, M_AXI_GP0_ARSIZE_i[1:0]};
assign M_AXI_GP0_AWSIZE[2:0] = {1'b0, M_AXI_GP0_AWSIZE_i[1:0]};
assign M_AXI_GP1_ARSIZE[2:0] = {1'b0, M_AXI_GP1_ARSIZE_i[1:0]};
assign M_AXI_GP1_AWSIZE[2:0] = {1'b0, M_AXI_GP1_AWSIZE_i[1:0]};
        function [5:0] compress_id;
                input [11:0] id;
                        begin
                                compress_id[0] = id[7] | (id[4] & id[2]) | (~id[11] & id[2]) | (id[11] & id[0]);
                                compress_id[1] = id[8] | id[5] | (~id[11] & id[3]);
                                compress_id[2] = id[9] | (id[6] & id[3] & id[2]) | (~id[11] & id[4]);
                                compress_id[3] = (id[11] & id[10] & id[4]) | (id[11] & id[10] & id[2]) | (~id[11] & id[10] & ~id[5] & ~id[0]);
                                compress_id[4] = (id[11] & id[3]) | (id[10] & id[0]) | (id[11] & id[10] & ~id[2] &~id[6]);
                                compress_id[5] = id[11] & id[10] & ~id[3];
                        end
        endfunction
        function [11:0] uncompress_id;
                input [5:0] id;
                        begin
                                case (id[5:0])
                                        // dmac0
                                        6'b000_010 : uncompress_id = 12'b010000_1000_00 ;
                                        6'b001_000 : uncompress_id = 12'b010000_0000_00 ;
                                        6'b001_001 : uncompress_id = 12'b010000_0001_00 ;
                                        6'b001_010 : uncompress_id = 12'b010000_0010_00 ;
                                        6'b001_011 : uncompress_id = 12'b010000_0011_00 ;
                                        6'b001_100 : uncompress_id = 12'b010000_0100_00 ;
                                        6'b001_101 : uncompress_id = 12'b010000_0101_00 ;
                                        6'b001_110 : uncompress_id = 12'b010000_0110_00 ;
                                        6'b001_111 : uncompress_id = 12'b010000_0111_00 ;
                                        // ioum
                                        6'b010_000 : uncompress_id = 12'b0100000_000_01 ;
                                        6'b010_001 : uncompress_id = 12'b0100000_001_01 ;
                                        6'b010_010 : uncompress_id = 12'b0100000_010_01 ;
                                        6'b010_011 : uncompress_id = 12'b0100000_011_01 ;
                                        6'b010_100 : uncompress_id = 12'b0100000_100_01 ;
                                        6'b010_101 : uncompress_id = 12'b0100000_101_01 ;
                                        // devci
                                        6'b000_000 : uncompress_id = 12'b1000_0000_0000 ;
                                        // dap
                                        6'b000_001 : uncompress_id = 12'b1000_0000_0001 ;
                                        // l2m1 (CPU000)
                                        6'b110_000 : uncompress_id = 12'b11_000_000_00_00 ;
                                        6'b110_010 : uncompress_id = 12'b11_010_000_00_00 ;
                                        6'b110_011 : uncompress_id = 12'b11_011_000_00_00 ;
                                        6'b110_100 : uncompress_id = 12'b11_100_000_00_00 ;
                                        6'b110_101 : uncompress_id = 12'b11_101_000_00_00 ;
                                        6'b110_110 : uncompress_id = 12'b11_110_000_00_00 ;
                                        6'b110_111 : uncompress_id = 12'b11_111_000_00_00 ;
                                        // l2m1 (CPU001)
                                        6'b111_000 : uncompress_id = 12'b11_000_001_00_00 ;
                                        6'b111_010 : uncompress_id = 12'b11_010_001_00_00 ;
                                        6'b111_011 : uncompress_id = 12'b11_011_001_00_00 ;
                                        6'b111_100 : uncompress_id = 12'b11_100_001_00_00 ;
                                        6'b111_101 : uncompress_id = 12'b11_101_001_00_00 ;
                                        6'b111_110 : uncompress_id = 12'b11_110_001_00_00 ;
                                        6'b111_111 : uncompress_id = 12'b11_111_001_00_00 ;
                                        // l2m1 (L2CC)
                                        6'b101_001 : uncompress_id = 12'b11_000_00101_00 ;
                                        6'b101_010 : uncompress_id = 12'b11_000_01001_00 ;
                                        6'b101_011 : uncompress_id = 12'b11_000_01101_00 ;
                                        6'b011_100 : uncompress_id = 12'b11_000_10011_00 ;
                                        6'b011_101 : uncompress_id = 12'b11_000_10111_00 ;
                                        6'b011_110 : uncompress_id = 12'b11_000_11011_00 ;
                                        6'b011_111 : uncompress_id = 12'b11_000_11111_00 ;
                                        6'b011_000 : uncompress_id = 12'b11_000_00011_00 ;
                                        6'b011_001 : uncompress_id = 12'b11_000_00111_00 ;
                                        6'b011_010 : uncompress_id = 12'b11_000_01011_00 ;
                                        6'b011_011 : uncompress_id = 12'b11_000_01111_00 ;
                                        6'b101_000 : uncompress_id = 12'b11_000_00001_00 ;
                                        // l2m1 (ACP)
                                        6'b100_000 : uncompress_id = 12'b11_000_10000_00 ;
                                        6'b100_001 : uncompress_id = 12'b11_001_10000_00 ;
                                        6'b100_010 : uncompress_id = 12'b11_010_10000_00 ;
                                        6'b100_011 : uncompress_id = 12'b11_011_10000_00 ;
                                        6'b100_100 : uncompress_id = 12'b11_100_10000_00 ;
                                        6'b100_101 : uncompress_id = 12'b11_101_10000_00 ;
                                        6'b100_110 : uncompress_id = 12'b11_110_10000_00 ;
                                        6'b100_111 : uncompress_id = 12'b11_111_10000_00 ;
                                        default : uncompress_id = 12'hx ;
                                endcase
                        end
        endfunction
        assign M_AXI_GP0_AWID        = (C_M_AXI_GP0_ENABLE_STATIC_REMAP == 1) ? compress_id(M_AXI_GP0_AWID_FULL) : M_AXI_GP0_AWID_FULL;
        assign M_AXI_GP0_WID         = (C_M_AXI_GP0_ENABLE_STATIC_REMAP == 1) ? compress_id(M_AXI_GP0_WID_FULL)  : M_AXI_GP0_WID_FULL;
        assign M_AXI_GP0_ARID        = (C_M_AXI_GP0_ENABLE_STATIC_REMAP == 1) ? compress_id(M_AXI_GP0_ARID_FULL) : M_AXI_GP0_ARID_FULL;
        assign M_AXI_GP0_BID_FULL    = (C_M_AXI_GP0_ENABLE_STATIC_REMAP == 1) ? uncompress_id(M_AXI_GP0_BID)     : M_AXI_GP0_BID;
        assign M_AXI_GP0_RID_FULL    = (C_M_AXI_GP0_ENABLE_STATIC_REMAP == 1) ? uncompress_id(M_AXI_GP0_RID)     : M_AXI_GP0_RID;
        assign M_AXI_GP1_AWID        = (C_M_AXI_GP1_ENABLE_STATIC_REMAP == 1) ? compress_id(M_AXI_GP1_AWID_FULL) : M_AXI_GP1_AWID_FULL;
        assign M_AXI_GP1_WID         = (C_M_AXI_GP1_ENABLE_STATIC_REMAP == 1) ? compress_id(M_AXI_GP1_WID_FULL)  : M_AXI_GP1_WID_FULL;
        assign M_AXI_GP1_ARID        = (C_M_AXI_GP1_ENABLE_STATIC_REMAP == 1) ? compress_id(M_AXI_GP1_ARID_FULL) : M_AXI_GP1_ARID_FULL;
        assign M_AXI_GP1_BID_FULL    = (C_M_AXI_GP1_ENABLE_STATIC_REMAP == 1) ? uncompress_id(M_AXI_GP1_BID)     : M_AXI_GP1_BID;
        assign M_AXI_GP1_RID_FULL    = (C_M_AXI_GP1_ENABLE_STATIC_REMAP == 1) ? uncompress_id(M_AXI_GP1_RID)     : M_AXI_GP1_RID;
     function [5:0] id_in_gp0;
       input [(C_S_AXI_GP0_ID_WIDTH - 1) : 0] axi_id_gp0_in;
     begin
              id_in_gp0 =  axi_id_gp0_in;
     end
     endfunction
    assign S_AXI_GP0_ARID_in = id_in_gp0(S_AXI_GP0_ARID);
    assign S_AXI_GP0_AWID_in = id_in_gp0(S_AXI_GP0_AWID);
    assign S_AXI_GP0_WID_in  = id_in_gp0(S_AXI_GP0_WID);
     function [5:0] id_out_gp0;
       input [(C_S_AXI_GP0_ID_WIDTH - 1) : 0] axi_id_gp0_out;
     begin
              id_out_gp0 =  axi_id_gp0_out;
     end
     endfunction
    assign S_AXI_GP0_BID     = id_out_gp0(S_AXI_GP0_BID_out);
    assign S_AXI_GP0_RID     = id_out_gp0(S_AXI_GP0_RID_out);
     function [5:0] id_in_gp1;
       input [(C_S_AXI_GP1_ID_WIDTH - 1) : 0] axi_id_gp1_in;
     begin
              id_in_gp1 =  axi_id_gp1_in;
     end
     endfunction
    assign S_AXI_GP1_ARID_in = id_in_gp1(S_AXI_GP1_ARID);
    assign S_AXI_GP1_AWID_in = id_in_gp1(S_AXI_GP1_AWID);
    assign S_AXI_GP1_WID_in  = id_in_gp1(S_AXI_GP1_WID);
     function [5:0] id_out_gp1;
       input [(C_S_AXI_GP1_ID_WIDTH - 1) : 0] axi_id_gp1_out;
     begin
              id_out_gp1 =  axi_id_gp1_out;
     end
     endfunction
    assign S_AXI_GP1_BID     = id_out_gp1(S_AXI_GP1_BID_out);
    assign S_AXI_GP1_RID     = id_out_gp1(S_AXI_GP1_RID_out);
     function [5:0] id_in_hp0;
       input [(C_S_AXI_HP0_ID_WIDTH - 1) : 0] axi_id_hp0_in;
     begin
              id_in_hp0 =  axi_id_hp0_in;
     end
     endfunction
    assign S_AXI_HP0_ARID_in = id_in_hp0(S_AXI_HP0_ARID);
    assign S_AXI_HP0_AWID_in = id_in_hp0(S_AXI_HP0_AWID);
    assign S_AXI_HP0_WID_in  = id_in_hp0(S_AXI_HP0_WID);
     function [5:0] id_out_hp0;
       input [(C_S_AXI_HP0_ID_WIDTH - 1) : 0] axi_id_hp0_out;
     begin
              id_out_hp0 =  axi_id_hp0_out;
     end
     endfunction
    assign S_AXI_HP0_BID     = id_out_hp0(S_AXI_HP0_BID_out);
    assign S_AXI_HP0_RID     = id_out_hp0(S_AXI_HP0_RID_out);
    assign S_AXI_HP0_WDATA_in        = (C_S_AXI_HP0_DATA_WIDTH == 64) ? S_AXI_HP0_WDATA : {32'b0,S_AXI_HP0_WDATA};
    assign S_AXI_HP0_WSTRB_in        = (C_S_AXI_HP0_DATA_WIDTH == 64) ? S_AXI_HP0_WSTRB : {4'b0,S_AXI_HP0_WSTRB};
    assign S_AXI_HP0_RDATA           = (C_S_AXI_HP0_DATA_WIDTH == 64) ? S_AXI_HP0_RDATA_out : S_AXI_HP0_RDATA_out[31:0];
     function [5:0] id_in_hp1;
       input [(C_S_AXI_HP1_ID_WIDTH - 1) : 0] axi_id_hp1_in;
     begin
              id_in_hp1 =  axi_id_hp1_in;
     end
     endfunction
    assign S_AXI_HP1_ARID_in = id_in_hp1(S_AXI_HP1_ARID);
    assign S_AXI_HP1_AWID_in = id_in_hp1(S_AXI_HP1_AWID);
    assign S_AXI_HP1_WID_in  = id_in_hp1(S_AXI_HP1_WID);
     function [5:0] id_out_hp1;
       input [(C_S_AXI_HP1_ID_WIDTH - 1) : 0] axi_id_hp1_out;
     begin
              id_out_hp1 =  axi_id_hp1_out;
     end
     endfunction
    assign S_AXI_HP1_BID     = id_out_hp1(S_AXI_HP1_BID_out);
    assign S_AXI_HP1_RID     = id_out_hp1(S_AXI_HP1_RID_out);
    assign S_AXI_HP1_WDATA_in        = (C_S_AXI_HP1_DATA_WIDTH == 64) ? S_AXI_HP1_WDATA : {32'b0,S_AXI_HP1_WDATA};
    assign S_AXI_HP1_WSTRB_in        = (C_S_AXI_HP1_DATA_WIDTH == 64) ? S_AXI_HP1_WSTRB : {4'b0,S_AXI_HP1_WSTRB};
    assign S_AXI_HP1_RDATA           = (C_S_AXI_HP1_DATA_WIDTH == 64) ? S_AXI_HP1_RDATA_out : S_AXI_HP1_RDATA_out[31:0];
     function [5:0] id_in_hp2;
       input [(C_S_AXI_HP2_ID_WIDTH - 1) : 0] axi_id_hp2_in;
     begin
              id_in_hp2 =  axi_id_hp2_in;
     end
     endfunction
    assign S_AXI_HP2_ARID_in = id_in_hp2(S_AXI_HP2_ARID);
    assign S_AXI_HP2_AWID_in = id_in_hp2(S_AXI_HP2_AWID);
    assign S_AXI_HP2_WID_in  = id_in_hp2(S_AXI_HP2_WID);
     function [5:0] id_out_hp2;
       input [(C_S_AXI_HP2_ID_WIDTH - 1) : 0] axi_id_hp2_out;
     begin
              id_out_hp2 =  axi_id_hp2_out;
     end
     endfunction
    assign S_AXI_HP2_BID     = id_out_hp2(S_AXI_HP2_BID_out);
    assign S_AXI_HP2_RID     = id_out_hp2(S_AXI_HP2_RID_out);
    assign S_AXI_HP2_WDATA_in        = (C_S_AXI_HP2_DATA_WIDTH == 64) ? S_AXI_HP2_WDATA : {32'b0,S_AXI_HP2_WDATA};
    assign S_AXI_HP2_WSTRB_in        = (C_S_AXI_HP2_DATA_WIDTH == 64) ? S_AXI_HP2_WSTRB : {4'b0,S_AXI_HP2_WSTRB};
    assign S_AXI_HP2_RDATA           = (C_S_AXI_HP2_DATA_WIDTH == 64) ? S_AXI_HP2_RDATA_out : S_AXI_HP2_RDATA_out[31:0];
     function [5:0] id_in_hp3;
       input [(C_S_AXI_HP3_ID_WIDTH - 1) : 0] axi_id_hp3_in;
     begin
              id_in_hp3 =  axi_id_hp3_in;
     end
     endfunction
    assign S_AXI_HP3_ARID_in = id_in_hp3(S_AXI_HP3_ARID);
    assign S_AXI_HP3_AWID_in = id_in_hp3(S_AXI_HP3_AWID);
    assign S_AXI_HP3_WID_in  = id_in_hp3(S_AXI_HP3_WID);
     function [5:0] id_out_hp3;
       input [(C_S_AXI_HP3_ID_WIDTH - 1) : 0] axi_id_hp3_out;
     begin
              id_out_hp3 =  axi_id_hp3_out;
     end
     endfunction
    assign S_AXI_HP3_BID     = id_out_hp3(S_AXI_HP3_BID_out);
    assign S_AXI_HP3_RID     = id_out_hp3(S_AXI_HP3_RID_out);
    assign S_AXI_HP3_WDATA_in        = (C_S_AXI_HP3_DATA_WIDTH == 64) ? S_AXI_HP3_WDATA : {32'b0,S_AXI_HP3_WDATA};
    assign S_AXI_HP3_WSTRB_in        = (C_S_AXI_HP3_DATA_WIDTH == 64) ? S_AXI_HP3_WSTRB : {4'b0,S_AXI_HP3_WSTRB};
    assign S_AXI_HP3_RDATA           = (C_S_AXI_HP3_DATA_WIDTH == 64) ? S_AXI_HP3_RDATA_out : S_AXI_HP3_RDATA_out[31:0];
     function [2:0] id_in_acp;
       input [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] axi_id_acp_in;
     begin
              id_in_acp =  axi_id_acp_in;
     end
     endfunction
    assign S_AXI_ACP_ARID_in = id_in_acp(SAXIACPARID_W);
    assign S_AXI_ACP_AWID_in = id_in_acp(SAXIACPAWID_W);
    assign S_AXI_ACP_WID_in  = id_in_acp(SAXIACPWID_W);
     function [2:0] id_out_acp;
       input [(C_S_AXI_ACP_ID_WIDTH - 1) : 0] axi_id_acp_out;
     begin
              id_out_acp =  axi_id_acp_out;
     end
     endfunction
    assign SAXIACPBID_W     = id_out_acp(S_AXI_ACP_BID_out);
    assign SAXIACPRID_W     = id_out_acp(S_AXI_ACP_RID_out);
assign        I2C0_SDA_T  = ~ I2C0_SDA_T_n;
assign        I2C0_SCL_T  = ~ I2C0_SCL_T_n;
assign        I2C1_SDA_T  = ~ I2C1_SDA_T_n;
assign        I2C1_SCL_T  = ~ I2C1_SCL_T_n;
assign        SPI0_SCLK_T = ~ SPI0_SCLK_T_n;
assign        SPI0_MOSI_T = ~ SPI0_MOSI_T_n;
assign        SPI0_MISO_T = ~ SPI0_MISO_T_n;
assign        SPI0_SS_T   = ~ SPI0_SS_T_n;
assign        SPI1_SCLK_T = ~ SPI1_SCLK_T_n;
assign        SPI1_MOSI_T = ~ SPI1_MOSI_T_n;
assign        SPI1_MISO_T = ~ SPI1_MISO_T_n;
assign        SPI1_SS_T   = ~ SPI1_SS_T_n;
assign        ENET0_MDIO_T = ~ ENET0_MDIO_T_n;
assign        ENET1_MDIO_T = ~ ENET1_MDIO_T_n;
assign        GPIO_T = ~ GPIO_T_n;
  function [63:0] gpio_width_adjust_in;
    input [(C_EMIO_GPIO_WIDTH - 1) : 0] gpio_in;
  begin
           gpio_width_adjust_in =  gpio_in;
  end
  endfunction
 assign gpio_in63_0 = gpio_width_adjust_in(GPIO_I);
  function [63:0] gpio_width_adjust_out;
    input [(C_EMIO_GPIO_WIDTH - 1) : 0] gpio_o;
  begin
           gpio_width_adjust_out =  gpio_o;
  end
  endfunction
 assign GPIO_O[(C_EMIO_GPIO_WIDTH - 1) : 0]   = gpio_width_adjust_out(gpio_out);
 assign GPIO_T_n[(C_EMIO_GPIO_WIDTH - 1) : 0] = gpio_width_adjust_out(gpio_out_t_n);
assign        PJTAG_TD_T = ~ PJTAG_TD_T_n;
assign        SDIO0_CMD_T       =   (C_PS7_SI_REV == "1.0") ? (SDIO0_CMD_T_n) : (~ SDIO0_CMD_T_n);
assign        SDIO0_DATA_T[3:0] =   (C_PS7_SI_REV == "1.0") ? (SDIO0_DATA_T_n[3:0]) : (~ SDIO0_DATA_T_n[3:0]);
assign        SDIO1_CMD_T       =  (C_PS7_SI_REV == "1.0") ? (SDIO1_CMD_T_n) : (~ SDIO1_CMD_T_n);
assign        SDIO1_DATA_T[3:0] =  (C_PS7_SI_REV == "1.0") ? (SDIO1_DATA_T_n[3:0]) : (~ SDIO1_DATA_T_n[3:0]);
generate
   if (C_FCLK_CLK0_BUF == "TRUE" | C_FCLK_CLK0_BUF == "true") begin : buffer_fclk_clk_0
     BUFG FCLK_CLK_0_BUFG (.I(FCLK_CLK_unbuffered[0]), .O(FCLK_CLK_buffered[0]));
   end
   if (C_FCLK_CLK1_BUF == "TRUE" | C_FCLK_CLK1_BUF == "true") begin : buffer_fclk_clk_1
     BUFG FCLK_CLK_1_BUFG (.I(FCLK_CLK_unbuffered[1]), .O(FCLK_CLK_buffered[1]));
   end
   if (C_FCLK_CLK2_BUF == "TRUE" | C_FCLK_CLK2_BUF == "true") begin : buffer_fclk_clk_2
     BUFG FCLK_CLK_2_BUFG (.I(FCLK_CLK_unbuffered[2]), .O(FCLK_CLK_buffered[2]));
   end
   if (C_FCLK_CLK3_BUF == "TRUE" | C_FCLK_CLK3_BUF == "true") begin : buffer_fclk_clk_3
     BUFG FCLK_CLK_3_BUFG (.I(FCLK_CLK_unbuffered[3]), .O(FCLK_CLK_buffered[3]));
   end
endgenerate
assign FCLK_CLK0 = (C_FCLK_CLK0_BUF == "TRUE" | C_FCLK_CLK0_BUF == "true") ? FCLK_CLK_buffered[0] : FCLK_CLK_unbuffered[0];
assign FCLK_CLK1 = (C_FCLK_CLK1_BUF == "TRUE" | C_FCLK_CLK1_BUF == "true") ? FCLK_CLK_buffered[1] : FCLK_CLK_unbuffered[1];
assign FCLK_CLK2 = (C_FCLK_CLK2_BUF == "TRUE" | C_FCLK_CLK2_BUF == "true") ? FCLK_CLK_buffered[2] : FCLK_CLK_unbuffered[2];
assign FCLK_CLK3 = (C_FCLK_CLK3_BUF == "TRUE" | C_FCLK_CLK3_BUF == "true") ? FCLK_CLK_buffered[3] : FCLK_CLK_unbuffered[3];
BIBUF DDR_CAS_n_BIBUF (.PAD(DDR_CAS_n), .IO(buffered_DDR_CAS_n));
BIBUF DDR_CKE_BIBUF (.PAD(DDR_CKE), .IO(buffered_DDR_CKE));
BIBUF DDR_Clk_n_BIBUF (.PAD(DDR_Clk_n), .IO(buffered_DDR_Clk_n));
BIBUF DDR_Clk_BIBUF (.PAD(DDR_Clk), .IO(buffered_DDR_Clk));
BIBUF DDR_CS_n_BIBUF (.PAD(DDR_CS_n), .IO(buffered_DDR_CS_n));
BIBUF DDR_DRSTB_BIBUF (.PAD(DDR_DRSTB), .IO(buffered_DDR_DRSTB));
BIBUF DDR_ODT_BIBUF (.PAD(DDR_ODT), .IO(buffered_DDR_ODT));
BIBUF DDR_RAS_n_BIBUF (.PAD(DDR_RAS_n), .IO(buffered_DDR_RAS_n));
BIBUF DDR_WEB_BIBUF (.PAD(DDR_WEB), .IO(buffered_DDR_WEB));
BIBUF DDR_VRN_BIBUF (.PAD(DDR_VRN), .IO(buffered_DDR_VRN));
BIBUF DDR_VRP_BIBUF (.PAD(DDR_VRP), .IO(buffered_DDR_VRP));
BIBUF PS_SRSTB_BIBUF (.PAD(PS_SRSTB), .IO(buffered_PS_SRSTB));
BIBUF PS_CLK_BIBUF (.PAD(PS_CLK), .IO(buffered_PS_CLK));
BIBUF PS_PORB_BIBUF (.PAD(PS_PORB), .IO(buffered_PS_PORB));
genvar i;
generate
        for (i=0; i < C_MIO_PRIMITIVE; i=i+1) begin
                BIBUF MIO_BIBUF (.PAD(MIO[i]), .IO(buffered_MIO[i]));
        end
endgenerate
generate
        for (i=0; i < 3; i=i+1) begin
                BIBUF DDR_BankAddr_BIBUF (.PAD(DDR_BankAddr[i]), .IO(buffered_DDR_BankAddr[i]));
        end
endgenerate
generate
        for (i=0; i < 15; i=i+1) begin
                BIBUF DDR_Addr_BIBUF (.PAD(DDR_Addr[i]), .IO(buffered_DDR_Addr[i]));
        end
endgenerate
generate
        for (i=0; i < C_DM_WIDTH; i=i+1) begin
                BIBUF DDR_DM_BIBUF (.PAD(DDR_DM[i]), .IO(buffered_DDR_DM[i]));
        end
endgenerate
generate
        for (i=0; i < C_DQ_WIDTH; i=i+1) begin
                BIBUF DDR_DQ_BIBUF (.PAD(DDR_DQ[i]), .IO(buffered_DDR_DQ[i]));
        end
endgenerate
generate
        for (i=0; i < C_DQS_WIDTH; i=i+1) begin
                BIBUF DDR_DQS_n_BIBUF (.PAD(DDR_DQS_n[i]), .IO(buffered_DDR_DQS_n[i]));
        end
endgenerate
generate
        for (i=0; i < C_DQS_WIDTH; i=i+1) begin
                BIBUF DDR_DQS_BIBUF (.PAD(DDR_DQS[i]), .IO(buffered_DDR_DQS[i]));
        end
endgenerate
generate
if (C_PACKAGE_NAME == "clg225" ) begin
        wire [21:0] dummy;
        PS7 PS7_i (
          .DMA0DATYPE                   (DMA0_DATYPE ),
          .DMA0DAVALID                   (DMA0_DAVALID),
          .DMA0DRREADY                   (DMA0_DRREADY),
          .DMA0RSTN                   (DMA0_RSTN   ),
          .DMA1DATYPE                   (DMA1_DATYPE ),
          .DMA1DAVALID                   (DMA1_DAVALID),
          .DMA1DRREADY                   (DMA1_DRREADY),
          .DMA1RSTN                   (DMA1_RSTN   ),
          .DMA2DATYPE                   (DMA2_DATYPE ),
          .DMA2DAVALID                   (DMA2_DAVALID),
          .DMA2DRREADY                   (DMA2_DRREADY),
          .DMA2RSTN                   (DMA2_RSTN   ),
          .DMA3DATYPE                   (DMA3_DATYPE ),
          .DMA3DAVALID                   (DMA3_DAVALID),
          .DMA3DRREADY                   (DMA3_DRREADY),
          .DMA3RSTN                   (DMA3_RSTN   ),
          .EMIOCAN0PHYTX           (CAN0_PHY_TX ),
          .EMIOCAN1PHYTX           (CAN1_PHY_TX ),
          .EMIOENET0GMIITXD           (ENET0_GMII_TXD_i ),
          .EMIOENET0GMIITXEN           (ENET0_GMII_TX_EN_i),
          .EMIOENET0GMIITXER           (ENET0_GMII_TX_ER_i),
          .EMIOENET0MDIOMDC           (ENET0_MDIO_MDC),
          .EMIOENET0MDIOO           (ENET0_MDIO_O  ),
          .EMIOENET0MDIOTN           (ENET0_MDIO_T_n  ),
          .EMIOENET0PTPDELAYREQRX  (ENET0_PTP_DELAY_REQ_RX),
          .EMIOENET0PTPDELAYREQTX  (ENET0_PTP_DELAY_REQ_TX),
          .EMIOENET0PTPPDELAYREQRX (ENET0_PTP_PDELAY_REQ_RX),
          .EMIOENET0PTPPDELAYREQTX (ENET0_PTP_PDELAY_REQ_TX),
          .EMIOENET0PTPPDELAYRESPRX(ENET0_PTP_PDELAY_RESP_RX),
          .EMIOENET0PTPPDELAYRESPTX(ENET0_PTP_PDELAY_RESP_TX),
          .EMIOENET0PTPSYNCFRAMERX (ENET0_PTP_SYNC_FRAME_RX),
          .EMIOENET0PTPSYNCFRAMETX (ENET0_PTP_SYNC_FRAME_TX),
          .EMIOENET0SOFRX          (ENET0_SOF_RX),
          .EMIOENET0SOFTX          (ENET0_SOF_TX),
          .EMIOENET1GMIITXD           (ENET1_GMII_TXD_i),
          .EMIOENET1GMIITXEN           (ENET1_GMII_TX_EN_i),
          .EMIOENET1GMIITXER           (ENET1_GMII_TX_ER_i),
          .EMIOENET1MDIOMDC           (ENET1_MDIO_MDC),
          .EMIOENET1MDIOO           (ENET1_MDIO_O  ),
          .EMIOENET1MDIOTN           (ENET1_MDIO_T_n),
          .EMIOENET1PTPDELAYREQRX  (ENET1_PTP_DELAY_REQ_RX),
          .EMIOENET1PTPDELAYREQTX  (ENET1_PTP_DELAY_REQ_TX),
          .EMIOENET1PTPPDELAYREQRX (ENET1_PTP_PDELAY_REQ_RX),
          .EMIOENET1PTPPDELAYREQTX (ENET1_PTP_PDELAY_REQ_TX),
          .EMIOENET1PTPPDELAYRESPRX(ENET1_PTP_PDELAY_RESP_RX),
          .EMIOENET1PTPPDELAYRESPTX(ENET1_PTP_PDELAY_RESP_TX),
          .EMIOENET1PTPSYNCFRAMERX (ENET1_PTP_SYNC_FRAME_RX),
          .EMIOENET1PTPSYNCFRAMETX (ENET1_PTP_SYNC_FRAME_TX),
          .EMIOENET1SOFRX          (ENET1_SOF_RX),
          .EMIOENET1SOFTX          (ENET1_SOF_TX),
          .EMIOGPIOO                   (gpio_out),
          .EMIOGPIOTN                   (gpio_out_t_n),
          .EMIOI2C0SCLO            (I2C0_SCL_O),
          .EMIOI2C0SCLTN           (I2C0_SCL_T_n),
          .EMIOI2C0SDAO                   (I2C0_SDA_O),
          .EMIOI2C0SDATN           (I2C0_SDA_T_n),
          .EMIOI2C1SCLO                   (I2C1_SCL_O),
          .EMIOI2C1SCLTN           (I2C1_SCL_T_n),
          .EMIOI2C1SDAO                   (I2C1_SDA_O),
          .EMIOI2C1SDATN           (I2C1_SDA_T_n),
          .EMIOPJTAGTDO             (PJTAG_TD_O),
          .EMIOPJTAGTDTN           (PJTAG_TD_T_n),
          .EMIOSDIO0BUSPOW         (SDIO0_BUSPOW),
          .EMIOSDIO0CLK                   (SDIO0_CLK   ),
          .EMIOSDIO0CMDO           (SDIO0_CMD_O ),
          .EMIOSDIO0CMDTN           (SDIO0_CMD_T_n ),
          .EMIOSDIO0DATAO           (SDIO0_DATA_O),
          .EMIOSDIO0DATATN           (SDIO0_DATA_T_n),
          .EMIOSDIO0LED            (SDIO0_LED),
          .EMIOSDIO1BUSPOW         (SDIO1_BUSPOW),
          .EMIOSDIO1CLK            (SDIO1_CLK   ),
          .EMIOSDIO1CMDO           (SDIO1_CMD_O ),
          .EMIOSDIO1CMDTN          (SDIO1_CMD_T_n ),
          .EMIOSDIO1DATAO          (SDIO1_DATA_O),
          .EMIOSDIO1DATATN         (SDIO1_DATA_T_n),
          .EMIOSDIO1LED            (SDIO1_LED),
          .EMIOSPI0MO                   (SPI0_MOSI_O),
          .EMIOSPI0MOTN                   (SPI0_MOSI_T_n),
          .EMIOSPI0SCLKO           (SPI0_SCLK_O),
          .EMIOSPI0SCLKTN           (SPI0_SCLK_T_n),
          .EMIOSPI0SO                   (SPI0_MISO_O),
          .EMIOSPI0STN                   (SPI0_MISO_T_n),
          .EMIOSPI0SSON                   ({SPI0_SS2_O,SPI0_SS1_O,SPI0_SS_O}),
          .EMIOSPI0SSNTN           (SPI0_SS_T_n),
          .EMIOSPI1MO                   (SPI1_MOSI_O),
          .EMIOSPI1MOTN                   (SPI1_MOSI_T_n),
          .EMIOSPI1SCLKO           (SPI1_SCLK_O),
          .EMIOSPI1SCLKTN           (SPI1_SCLK_T_n),
          .EMIOSPI1SO                   (SPI1_MISO_O),
          .EMIOSPI1STN                   (SPI1_MISO_T_n),
          .EMIOSPI1SSON                   ({SPI1_SS2_O,SPI1_SS1_O,SPI1_SS_O}),
          .EMIOSPI1SSNTN           (SPI1_SS_T_n),
          .EMIOTRACECTL                   (TRACE_CTL_i),
          .EMIOTRACEDATA           (TRACE_DATA_i),
          .EMIOTTC0WAVEO           ({TTC0_WAVE2_OUT,TTC0_WAVE1_OUT,TTC0_WAVE0_OUT}),
          .EMIOTTC1WAVEO           ({TTC1_WAVE2_OUT,TTC1_WAVE1_OUT,TTC1_WAVE0_OUT}),
          .EMIOUART0DTRN           (UART0_DTRN),
          .EMIOUART0RTSN           (UART0_RTSN),
          .EMIOUART0TX                   (UART0_TX  ),
          .EMIOUART1DTRN           (UART1_DTRN),
          .EMIOUART1RTSN           (UART1_RTSN),
          .EMIOUART1TX                   (UART1_TX  ),
          .EMIOUSB0PORTINDCTL      (USB0_PORT_INDCTL),
          .EMIOUSB0VBUSPWRSELECT   (USB0_VBUS_PWRSELECT),
          .EMIOUSB1PORTINDCTL      (USB1_PORT_INDCTL),
          .EMIOUSB1VBUSPWRSELECT   (USB1_VBUS_PWRSELECT),
          .EMIOWDTRSTO               (WDT_RST_OUT),
          .EVENTEVENTO             (EVENT_EVENTO),
          .EVENTSTANDBYWFE         (EVENT_STANDBYWFE),
          .EVENTSTANDBYWFI         (EVENT_STANDBYWFI),
          .FCLKCLK                   (FCLK_CLK_unbuffered),
          .FCLKRESETN                   ({FCLK_RESET3_N,FCLK_RESET2_N,FCLK_RESET1_N,FCLK_RESET0_N}),
          .EMIOSDIO0BUSVOLT        (SDIO0_BUSVOLT),
          .EMIOSDIO1BUSVOLT        (SDIO1_BUSVOLT),
          .FTMTF2PTRIGACK           ({FTMT_F2P_TRIGACK_3,FTMT_F2P_TRIGACK_2,FTMT_F2P_TRIGACK_1,FTMT_F2P_TRIGACK_0}),
          .FTMTP2FDEBUG                   (FTMT_P2F_DEBUG  ),
          .FTMTP2FTRIG                   ({FTMT_P2F_TRIG_3,FTMT_P2F_TRIG_2,FTMT_P2F_TRIG_1,FTMT_P2F_TRIG_0}),
          .IRQP2F                   ({IRQ_P2F_DMAC_ABORT, IRQ_P2F_DMAC7, IRQ_P2F_DMAC6, IRQ_P2F_DMAC5, IRQ_P2F_DMAC4, IRQ_P2F_DMAC3, IRQ_P2F_DMAC2, IRQ_P2F_DMAC1, IRQ_P2F_DMAC0, IRQ_P2F_SMC, IRQ_P2F_QSPI, IRQ_P2F_CTI, IRQ_P2F_GPIO, IRQ_P2F_USB0, IRQ_P2F_ENET0, IRQ_P2F_ENET_WAKE0, IRQ_P2F_SDIO0, IRQ_P2F_I2C0, IRQ_P2F_SPI0, IRQ_P2F_UART0, IRQ_P2F_CAN0, IRQ_P2F_USB1, IRQ_P2F_ENET1, IRQ_P2F_ENET_WAKE1, IRQ_P2F_SDIO1, IRQ_P2F_I2C1, IRQ_P2F_SPI1, IRQ_P2F_UART1, IRQ_P2F_CAN1}),
          .MAXIGP0ARADDR           (M_AXI_GP0_ARADDR),
          .MAXIGP0ARBURST           (M_AXI_GP0_ARBURST),
          .MAXIGP0ARCACHE           (M_AXI_GP0_ARCACHE),
          .MAXIGP0ARESETN           (M_AXI_GP0_ARESETN),
          .MAXIGP0ARID                   (M_AXI_GP0_ARID_FULL   ),
          .MAXIGP0ARLEN                   (M_AXI_GP0_ARLEN  ),
          .MAXIGP0ARLOCK           (M_AXI_GP0_ARLOCK ),
          .MAXIGP0ARPROT           (M_AXI_GP0_ARPROT ),
          .MAXIGP0ARQOS                   (M_AXI_GP0_ARQOS  ),
          .MAXIGP0ARSIZE           (M_AXI_GP0_ARSIZE_i ),
          .MAXIGP0ARVALID           (M_AXI_GP0_ARVALID),
          .MAXIGP0AWADDR           (M_AXI_GP0_AWADDR ),
          .MAXIGP0AWBURST           (M_AXI_GP0_AWBURST),
          .MAXIGP0AWCACHE           (M_AXI_GP0_AWCACHE),
          .MAXIGP0AWID                   (M_AXI_GP0_AWID_FULL   ),
          .MAXIGP0AWLEN                   (M_AXI_GP0_AWLEN  ),
          .MAXIGP0AWLOCK           (M_AXI_GP0_AWLOCK ),
          .MAXIGP0AWPROT           (M_AXI_GP0_AWPROT ),
          .MAXIGP0AWQOS                   (M_AXI_GP0_AWQOS  ),
          .MAXIGP0AWSIZE           (M_AXI_GP0_AWSIZE_i ),
          .MAXIGP0AWVALID           (M_AXI_GP0_AWVALID),
          .MAXIGP0BREADY           (M_AXI_GP0_BREADY ),
          .MAXIGP0RREADY           (M_AXI_GP0_RREADY ),
          .MAXIGP0WDATA                   (M_AXI_GP0_WDATA  ),
          .MAXIGP0WID                   (M_AXI_GP0_WID_FULL    ),
          .MAXIGP0WLAST                   (M_AXI_GP0_WLAST  ),
          .MAXIGP0WSTRB                   (M_AXI_GP0_WSTRB  ),
          .MAXIGP0WVALID           (M_AXI_GP0_WVALID ),
          .MAXIGP1ARADDR           (M_AXI_GP1_ARADDR ),
          .MAXIGP1ARBURST           (M_AXI_GP1_ARBURST),
          .MAXIGP1ARCACHE           (M_AXI_GP1_ARCACHE),
          .MAXIGP1ARESETN           (M_AXI_GP1_ARESETN),
          .MAXIGP1ARID                   (M_AXI_GP1_ARID_FULL   ),
          .MAXIGP1ARLEN                   (M_AXI_GP1_ARLEN  ),
          .MAXIGP1ARLOCK           (M_AXI_GP1_ARLOCK ),
          .MAXIGP1ARPROT           (M_AXI_GP1_ARPROT ),
          .MAXIGP1ARQOS                   (M_AXI_GP1_ARQOS  ),
          .MAXIGP1ARSIZE           (M_AXI_GP1_ARSIZE_i ),
          .MAXIGP1ARVALID           (M_AXI_GP1_ARVALID),
          .MAXIGP1AWADDR           (M_AXI_GP1_AWADDR ),
          .MAXIGP1AWBURST           (M_AXI_GP1_AWBURST),
          .MAXIGP1AWCACHE           (M_AXI_GP1_AWCACHE),
          .MAXIGP1AWID                   (M_AXI_GP1_AWID_FULL   ),
          .MAXIGP1AWLEN                   (M_AXI_GP1_AWLEN  ),
          .MAXIGP1AWLOCK           (M_AXI_GP1_AWLOCK ),
          .MAXIGP1AWPROT           (M_AXI_GP1_AWPROT ),
          .MAXIGP1AWQOS                   (M_AXI_GP1_AWQOS  ),
          .MAXIGP1AWSIZE           (M_AXI_GP1_AWSIZE_i ),
          .MAXIGP1AWVALID           (M_AXI_GP1_AWVALID),
          .MAXIGP1BREADY           (M_AXI_GP1_BREADY ),
          .MAXIGP1RREADY           (M_AXI_GP1_RREADY ),
          .MAXIGP1WDATA                   (M_AXI_GP1_WDATA  ),
          .MAXIGP1WID                   (M_AXI_GP1_WID_FULL    ),
          .MAXIGP1WLAST                   (M_AXI_GP1_WLAST  ),
          .MAXIGP1WSTRB                   (M_AXI_GP1_WSTRB  ),
          .MAXIGP1WVALID           (M_AXI_GP1_WVALID ),
          .SAXIACPARESETN           (S_AXI_ACP_ARESETN),
          .SAXIACPARREADY           (SAXIACPARREADY_W),
          .SAXIACPAWREADY           (SAXIACPAWREADY_W),
          .SAXIACPBID                   (S_AXI_ACP_BID_out    ),
          .SAXIACPBRESP                   (SAXIACPBRESP_W  ),
          .SAXIACPBVALID           (SAXIACPBVALID_W ),
          .SAXIACPRDATA                   (SAXIACPRDATA_W  ),
          .SAXIACPRID                   (S_AXI_ACP_RID_out),
          .SAXIACPRLAST                   (SAXIACPRLAST_W  ),
          .SAXIACPRRESP                   (SAXIACPRRESP_W  ),
          .SAXIACPRVALID           (SAXIACPRVALID_W ),
          .SAXIACPWREADY           (SAXIACPWREADY_W ),
          .SAXIGP0ARESETN           (S_AXI_GP0_ARESETN),
          .SAXIGP0ARREADY           (S_AXI_GP0_ARREADY),
          .SAXIGP0AWREADY           (S_AXI_GP0_AWREADY),
          .SAXIGP0BID                   (S_AXI_GP0_BID_out),
          .SAXIGP0BRESP                   (S_AXI_GP0_BRESP  ),
          .SAXIGP0BVALID           (S_AXI_GP0_BVALID ),
          .SAXIGP0RDATA                   (S_AXI_GP0_RDATA  ),
          .SAXIGP0RID                   (S_AXI_GP0_RID_out ),
          .SAXIGP0RLAST                   (S_AXI_GP0_RLAST  ),
          .SAXIGP0RRESP                   (S_AXI_GP0_RRESP  ),
          .SAXIGP0RVALID           (S_AXI_GP0_RVALID ),
          .SAXIGP0WREADY           (S_AXI_GP0_WREADY ),
          .SAXIGP1ARESETN           (S_AXI_GP1_ARESETN),
          .SAXIGP1ARREADY           (S_AXI_GP1_ARREADY),
          .SAXIGP1AWREADY           (S_AXI_GP1_AWREADY),
          .SAXIGP1BID                   (S_AXI_GP1_BID_out    ),
          .SAXIGP1BRESP                   (S_AXI_GP1_BRESP  ),
          .SAXIGP1BVALID           (S_AXI_GP1_BVALID ),
          .SAXIGP1RDATA                   (S_AXI_GP1_RDATA  ),
          .SAXIGP1RID                   (S_AXI_GP1_RID_out    ),
          .SAXIGP1RLAST                   (S_AXI_GP1_RLAST  ),
          .SAXIGP1RRESP                   (S_AXI_GP1_RRESP  ),
          .SAXIGP1RVALID           (S_AXI_GP1_RVALID ),
          .SAXIGP1WREADY           (S_AXI_GP1_WREADY ),
          .SAXIHP0ARESETN           (S_AXI_HP0_ARESETN),
          .SAXIHP0ARREADY           (S_AXI_HP0_ARREADY),
          .SAXIHP0AWREADY           (S_AXI_HP0_AWREADY),
          .SAXIHP0BID                   (S_AXI_HP0_BID_out    ),
          .SAXIHP0BRESP                   (S_AXI_HP0_BRESP  ),
          .SAXIHP0BVALID           (S_AXI_HP0_BVALID ),
          .SAXIHP0RACOUNT          (S_AXI_HP0_RACOUNT),
          .SAXIHP0RCOUNT           (S_AXI_HP0_RCOUNT),
          .SAXIHP0RDATA                   (S_AXI_HP0_RDATA_out),
          .SAXIHP0RID                   (S_AXI_HP0_RID_out ),
          .SAXIHP0RLAST                   (S_AXI_HP0_RLAST),
          .SAXIHP0RRESP                   (S_AXI_HP0_RRESP),
          .SAXIHP0RVALID           (S_AXI_HP0_RVALID),
          .SAXIHP0WCOUNT           (S_AXI_HP0_WCOUNT),
          .SAXIHP0WACOUNT          (S_AXI_HP0_WACOUNT),
          .SAXIHP0WREADY           (S_AXI_HP0_WREADY),
          .SAXIHP1ARESETN           (S_AXI_HP1_ARESETN),
          .SAXIHP1ARREADY           (S_AXI_HP1_ARREADY),
          .SAXIHP1AWREADY           (S_AXI_HP1_AWREADY),
          .SAXIHP1BID                   (S_AXI_HP1_BID_out    ),
          .SAXIHP1BRESP                   (S_AXI_HP1_BRESP  ),
          .SAXIHP1BVALID           (S_AXI_HP1_BVALID ),
          .SAXIHP1RACOUNT           (S_AXI_HP1_RACOUNT ),
          .SAXIHP1RCOUNT           (S_AXI_HP1_RCOUNT ),
          .SAXIHP1RDATA                   (S_AXI_HP1_RDATA_out),
          .SAXIHP1RID                   (S_AXI_HP1_RID_out    ),
          .SAXIHP1RLAST                   (S_AXI_HP1_RLAST  ),
          .SAXIHP1RRESP                   (S_AXI_HP1_RRESP  ),
          .SAXIHP1RVALID           (S_AXI_HP1_RVALID),
          .SAXIHP1WACOUNT           (S_AXI_HP1_WACOUNT),
          .SAXIHP1WCOUNT           (S_AXI_HP1_WCOUNT),
          .SAXIHP1WREADY           (S_AXI_HP1_WREADY),
          .SAXIHP2ARESETN           (S_AXI_HP2_ARESETN),
          .SAXIHP2ARREADY           (S_AXI_HP2_ARREADY),
          .SAXIHP2AWREADY           (S_AXI_HP2_AWREADY),
          .SAXIHP2BID                   (S_AXI_HP2_BID_out ),
          .SAXIHP2BRESP                   (S_AXI_HP2_BRESP),
          .SAXIHP2BVALID           (S_AXI_HP2_BVALID),
          .SAXIHP2RACOUNT           (S_AXI_HP2_RACOUNT),
          .SAXIHP2RCOUNT           (S_AXI_HP2_RCOUNT),
          .SAXIHP2RDATA                   (S_AXI_HP2_RDATA_out),
          .SAXIHP2RID                   (S_AXI_HP2_RID_out ),
          .SAXIHP2RLAST                   (S_AXI_HP2_RLAST),
          .SAXIHP2RRESP                   (S_AXI_HP2_RRESP),
          .SAXIHP2RVALID           (S_AXI_HP2_RVALID),
          .SAXIHP2WACOUNT           (S_AXI_HP2_WACOUNT),
          .SAXIHP2WCOUNT           (S_AXI_HP2_WCOUNT),
          .SAXIHP2WREADY           (S_AXI_HP2_WREADY),
          .SAXIHP3ARESETN           (S_AXI_HP3_ARESETN),
          .SAXIHP3ARREADY           (S_AXI_HP3_ARREADY),
          .SAXIHP3AWREADY           (S_AXI_HP3_AWREADY),
          .SAXIHP3BID                   (S_AXI_HP3_BID_out),
          .SAXIHP3BRESP                   (S_AXI_HP3_BRESP),
          .SAXIHP3BVALID           (S_AXI_HP3_BVALID),
          .SAXIHP3RACOUNT           (S_AXI_HP3_RACOUNT),
          .SAXIHP3RCOUNT           (S_AXI_HP3_RCOUNT),
          .SAXIHP3RDATA                   (S_AXI_HP3_RDATA_out),
          .SAXIHP3RID                   (S_AXI_HP3_RID_out),
          .SAXIHP3RLAST                   (S_AXI_HP3_RLAST),
          .SAXIHP3RRESP                   (S_AXI_HP3_RRESP),
          .SAXIHP3RVALID           (S_AXI_HP3_RVALID),
          .SAXIHP3WCOUNT           (S_AXI_HP3_WCOUNT),
          .SAXIHP3WACOUNT           (S_AXI_HP3_WACOUNT),
          .SAXIHP3WREADY           (S_AXI_HP3_WREADY),
          .DDRARB                  (DDR_ARB),
          .DMA0ACLK                   (DMA0_ACLK   ),
          .DMA0DAREADY                   (DMA0_DAREADY),
          .DMA0DRLAST                   (DMA0_DRLAST ),
          .DMA0DRTYPE              (DMA0_DRTYPE),
          .DMA0DRVALID                   (DMA0_DRVALID),
          .DMA1ACLK                   (DMA1_ACLK   ),
          .DMA1DAREADY                   (DMA1_DAREADY),
          .DMA1DRLAST                   (DMA1_DRLAST ),
          .DMA1DRTYPE              (DMA1_DRTYPE),
          .DMA1DRVALID                   (DMA1_DRVALID),
          .DMA2ACLK                   (DMA2_ACLK   ),
          .DMA2DAREADY                   (DMA2_DAREADY),
          .DMA2DRLAST                   (DMA2_DRLAST ),
          .DMA2DRTYPE              (DMA2_DRTYPE),
          .DMA2DRVALID                   (DMA2_DRVALID),
          .DMA3ACLK                   (DMA3_ACLK   ),
          .DMA3DAREADY                   (DMA3_DAREADY),
          .DMA3DRLAST                   (DMA3_DRLAST ),
          .DMA3DRTYPE              (DMA3_DRTYPE),
          .DMA3DRVALID                   (DMA3_DRVALID),
          .EMIOCAN0PHYRX           (CAN0_PHY_RX),
          .EMIOCAN1PHYRX           (CAN1_PHY_RX),
          .EMIOENET0EXTINTIN       (ENET0_EXT_INTIN),
          .EMIOENET0GMIICOL        (ENET0_GMII_COL_i),
          .EMIOENET0GMIICRS        (ENET0_GMII_CRS_i),
          .EMIOENET0GMIIRXCLK      (ENET0_GMII_RX_CLK),
          .EMIOENET0GMIIRXD        (ENET0_GMII_RXD_i),
          .EMIOENET0GMIIRXDV       (ENET0_GMII_RX_DV_i),
          .EMIOENET0GMIIRXER       (ENET0_GMII_RX_ER_i),
          .EMIOENET0GMIITXCLK      (ENET0_GMII_TX_CLK),
          .EMIOENET0MDIOI          (ENET0_MDIO_I),
          .EMIOENET1EXTINTIN       (ENET1_EXT_INTIN),
          .EMIOENET1GMIICOL        (ENET1_GMII_COL_i),
          .EMIOENET1GMIICRS        (ENET1_GMII_CRS_i),
          .EMIOENET1GMIIRXCLK      (ENET1_GMII_RX_CLK),
          .EMIOENET1GMIIRXD        (ENET1_GMII_RXD_i),
          .EMIOENET1GMIIRXDV       (ENET1_GMII_RX_DV_i),
          .EMIOENET1GMIIRXER       (ENET1_GMII_RX_ER_i),
          .EMIOENET1GMIITXCLK      (ENET1_GMII_TX_CLK),
          .EMIOENET1MDIOI          (ENET1_MDIO_I),
          .EMIOGPIOI                   (gpio_in63_0  ),
          .EMIOI2C0SCLI                   (I2C0_SCL_I),
          .EMIOI2C0SDAI                   (I2C0_SDA_I),
          .EMIOI2C1SCLI                   (I2C1_SCL_I),
          .EMIOI2C1SDAI                   (I2C1_SDA_I),
          .EMIOPJTAGTCK                   (PJTAG_TCK),
          .EMIOPJTAGTDI                   (PJTAG_TD_I),
          .EMIOPJTAGTMS                   (PJTAG_TMS),
          .EMIOSDIO0CDN            (SDIO0_CDN),
          .EMIOSDIO0CLKFB           (SDIO0_CLK_FB  ),
          .EMIOSDIO0CMDI           (SDIO0_CMD_I   ),
          .EMIOSDIO0DATAI           (SDIO0_DATA_I  ),
          .EMIOSDIO0WP             (SDIO0_WP),
          .EMIOSDIO1CDN            (SDIO1_CDN),
          .EMIOSDIO1CLKFB           (SDIO1_CLK_FB  ),
          .EMIOSDIO1CMDI           (SDIO1_CMD_I   ),
          .EMIOSDIO1DATAI           (SDIO1_DATA_I  ),
          .EMIOSDIO1WP             (SDIO1_WP),
          .EMIOSPI0MI                   (SPI0_MISO_I),
          .EMIOSPI0SCLKI           (SPI0_SCLK_I),
          .EMIOSPI0SI                   (SPI0_MOSI_I),
          .EMIOSPI0SSIN            (SPI0_SS_I),
          .EMIOSPI1MI                   (SPI1_MISO_I),
          .EMIOSPI1SCLKI           (SPI1_SCLK_I),
          .EMIOSPI1SI                   (SPI1_MOSI_I),
          .EMIOSPI1SSIN                   (SPI1_SS_I),
          .EMIOSRAMINTIN           (SRAM_INTIN),
          .EMIOTRACECLK                   (TRACE_CLK),
          .EMIOTTC0CLKI                   ({TTC0_CLK2_IN, TTC0_CLK1_IN, TTC0_CLK0_IN}),
          .EMIOTTC1CLKI                   ({TTC1_CLK2_IN, TTC1_CLK1_IN, TTC1_CLK0_IN}),
          .EMIOUART0CTSN           (UART0_CTSN),
          .EMIOUART0DCDN           (UART0_DCDN),
          .EMIOUART0DSRN           (UART0_DSRN),
          .EMIOUART0RIN                   (UART0_RIN ),
          .EMIOUART0RX                   (UART0_RX  ),
          .EMIOUART1CTSN           (UART1_CTSN),
          .EMIOUART1DCDN           (UART1_DCDN),
          .EMIOUART1DSRN           (UART1_DSRN),
          .EMIOUART1RIN                   (UART1_RIN ),
          .EMIOUART1RX                   (UART1_RX  ),
          .EMIOUSB0VBUSPWRFAULT    (USB0_VBUS_PWRFAULT),
          .EMIOUSB1VBUSPWRFAULT    (USB1_VBUS_PWRFAULT),
          .EMIOWDTCLKI                   (WDT_CLK_IN),
          .EVENTEVENTI             (EVENT_EVENTI),
          .FCLKCLKTRIGN                   (fclk_clktrig_gnd),
          .FPGAIDLEN                   (FPGA_IDLE_N),
          .FTMDTRACEINATID           (FTMD_TRACEIN_ATID_i),
          .FTMDTRACEINCLOCK           (FTMD_TRACEIN_CLK),
          .FTMDTRACEINDATA           (FTMD_TRACEIN_DATA_i),
          .FTMDTRACEINVALID           (FTMD_TRACEIN_VALID_i),
          .FTMTF2PDEBUG                   (FTMT_F2P_DEBUG  ),
          .FTMTF2PTRIG                   ({FTMT_F2P_TRIG_3,FTMT_F2P_TRIG_2,FTMT_F2P_TRIG_1,FTMT_F2P_TRIG_0}),
          .FTMTP2FTRIGACK           ({FTMT_P2F_TRIGACK_3,FTMT_P2F_TRIGACK_2,FTMT_P2F_TRIGACK_1,FTMT_P2F_TRIGACK_0}),
          .IRQF2P                   (irq_f2p_i),
          .MAXIGP0ACLK                   (M_AXI_GP0_ACLK),
          .MAXIGP0ARREADY           (M_AXI_GP0_ARREADY),
          .MAXIGP0AWREADY           (M_AXI_GP0_AWREADY),
          .MAXIGP0BID                   (M_AXI_GP0_BID_FULL    ),
          .MAXIGP0BRESP                   (M_AXI_GP0_BRESP  ),
          .MAXIGP0BVALID           (M_AXI_GP0_BVALID ),
          .MAXIGP0RDATA                   (M_AXI_GP0_RDATA  ),
          .MAXIGP0RID                   (M_AXI_GP0_RID_FULL    ),
          .MAXIGP0RLAST                   (M_AXI_GP0_RLAST  ),
          .MAXIGP0RRESP                   (M_AXI_GP0_RRESP  ),
          .MAXIGP0RVALID           (M_AXI_GP0_RVALID ),
          .MAXIGP0WREADY           (M_AXI_GP0_WREADY ),
          .MAXIGP1ACLK                   (M_AXI_GP1_ACLK   ),
          .MAXIGP1ARREADY           (M_AXI_GP1_ARREADY),
          .MAXIGP1AWREADY           (M_AXI_GP1_AWREADY),
          .MAXIGP1BID                   (M_AXI_GP1_BID_FULL ),
          .MAXIGP1BRESP                   (M_AXI_GP1_BRESP  ),
          .MAXIGP1BVALID           (M_AXI_GP1_BVALID ),
          .MAXIGP1RDATA                   (M_AXI_GP1_RDATA  ),
          .MAXIGP1RID                   (M_AXI_GP1_RID_FULL    ),
          .MAXIGP1RLAST                   (M_AXI_GP1_RLAST  ),
          .MAXIGP1RRESP                   (M_AXI_GP1_RRESP  ),
          .MAXIGP1RVALID           (M_AXI_GP1_RVALID ),
          .MAXIGP1WREADY           (M_AXI_GP1_WREADY ),
          .SAXIACPACLK                   (S_AXI_ACP_ACLK   ),
          .SAXIACPARADDR           (SAXIACPARADDR_W ),
          .SAXIACPARBURST           (SAXIACPARBURST_W),
          .SAXIACPARCACHE           (SAXIACPARCACHE_W),
          .SAXIACPARID                   (S_AXI_ACP_ARID_in   ),
          .SAXIACPARLEN                   (SAXIACPARLEN_W  ),
          .SAXIACPARLOCK           (SAXIACPARLOCK_W ),
          .SAXIACPARPROT           (SAXIACPARPROT_W ),
          .SAXIACPARQOS                   (S_AXI_ACP_ARQOS  ),
          .SAXIACPARSIZE           (SAXIACPARSIZE_W[1:0] ),
          .SAXIACPARUSER           (SAXIACPARUSER_W ),
          .SAXIACPARVALID           (SAXIACPARVALID_W),
          .SAXIACPAWADDR           (SAXIACPAWADDR_W ),
          .SAXIACPAWBURST           (SAXIACPAWBURST_W),
          .SAXIACPAWCACHE           (SAXIACPAWCACHE_W),
          .SAXIACPAWID                   (S_AXI_ACP_AWID_in   ),
          .SAXIACPAWLEN                   (SAXIACPAWLEN_W  ),
          .SAXIACPAWLOCK           (SAXIACPAWLOCK_W ),
          .SAXIACPAWPROT           (SAXIACPAWPROT_W ),
          .SAXIACPAWQOS                   (S_AXI_ACP_AWQOS  ),
          .SAXIACPAWSIZE           (SAXIACPAWSIZE_W[1:0] ),
          .SAXIACPAWUSER           (SAXIACPAWUSER_W ),
          .SAXIACPAWVALID           (SAXIACPAWVALID_W),
          .SAXIACPBREADY           (SAXIACPBREADY_W ),
          .SAXIACPRREADY           (SAXIACPRREADY_W ),
          .SAXIACPWDATA                   (SAXIACPWDATA_W  ),
          .SAXIACPWID                   (S_AXI_ACP_WID_in    ),
          .SAXIACPWLAST                   (SAXIACPWLAST_W  ),
          .SAXIACPWSTRB                   (SAXIACPWSTRB_W  ),
          .SAXIACPWVALID           (SAXIACPWVALID_W ),
          .SAXIGP0ACLK             (S_AXI_GP0_ACLK   ),
          .SAXIGP0ARADDR           (S_AXI_GP0_ARADDR ),
          .SAXIGP0ARBURST          (S_AXI_GP0_ARBURST),
          .SAXIGP0ARCACHE          (S_AXI_GP0_ARCACHE),
          .SAXIGP0ARID             (S_AXI_GP0_ARID_in   ),
          .SAXIGP0ARLEN            (S_AXI_GP0_ARLEN  ),
          .SAXIGP0ARLOCK           (S_AXI_GP0_ARLOCK ),
          .SAXIGP0ARPROT           (S_AXI_GP0_ARPROT ),
          .SAXIGP0ARQOS            (S_AXI_GP0_ARQOS  ),
          .SAXIGP0ARSIZE           (S_AXI_GP0_ARSIZE[1:0] ),
          .SAXIGP0ARVALID          (S_AXI_GP0_ARVALID),
          .SAXIGP0AWADDR           (S_AXI_GP0_AWADDR ),
          .SAXIGP0AWBURST          (S_AXI_GP0_AWBURST),
          .SAXIGP0AWCACHE          (S_AXI_GP0_AWCACHE),
          .SAXIGP0AWID             (S_AXI_GP0_AWID_in   ),
          .SAXIGP0AWLEN            (S_AXI_GP0_AWLEN  ),
          .SAXIGP0AWLOCK           (S_AXI_GP0_AWLOCK ),
          .SAXIGP0AWPROT           (S_AXI_GP0_AWPROT ),
          .SAXIGP0AWQOS            (S_AXI_GP0_AWQOS  ),
          .SAXIGP0AWSIZE           (S_AXI_GP0_AWSIZE[1:0] ),
          .SAXIGP0AWVALID          (S_AXI_GP0_AWVALID),
          .SAXIGP0BREADY           (S_AXI_GP0_BREADY ),
          .SAXIGP0RREADY           (S_AXI_GP0_RREADY ),
          .SAXIGP0WDATA            (S_AXI_GP0_WDATA  ),
          .SAXIGP0WID              (S_AXI_GP0_WID_in ),
          .SAXIGP0WLAST            (S_AXI_GP0_WLAST  ),
          .SAXIGP0WSTRB            (S_AXI_GP0_WSTRB  ),
          .SAXIGP0WVALID           (S_AXI_GP0_WVALID ),
          .SAXIGP1ACLK                   (S_AXI_GP1_ACLK   ),
          .SAXIGP1ARADDR           (S_AXI_GP1_ARADDR ),
          .SAXIGP1ARBURST           (S_AXI_GP1_ARBURST),
          .SAXIGP1ARCACHE           (S_AXI_GP1_ARCACHE),
          .SAXIGP1ARID                   (S_AXI_GP1_ARID_in   ),
          .SAXIGP1ARLEN                   (S_AXI_GP1_ARLEN  ),
          .SAXIGP1ARLOCK           (S_AXI_GP1_ARLOCK ),
          .SAXIGP1ARPROT           (S_AXI_GP1_ARPROT ),
          .SAXIGP1ARQOS                   (S_AXI_GP1_ARQOS  ),
          .SAXIGP1ARSIZE           (S_AXI_GP1_ARSIZE[1:0] ),
          .SAXIGP1ARVALID           (S_AXI_GP1_ARVALID),
          .SAXIGP1AWADDR           (S_AXI_GP1_AWADDR ),
          .SAXIGP1AWBURST           (S_AXI_GP1_AWBURST),
          .SAXIGP1AWCACHE           (S_AXI_GP1_AWCACHE),
          .SAXIGP1AWID                   (S_AXI_GP1_AWID_in   ),
          .SAXIGP1AWLEN                   (S_AXI_GP1_AWLEN  ),
          .SAXIGP1AWLOCK           (S_AXI_GP1_AWLOCK ),
          .SAXIGP1AWPROT           (S_AXI_GP1_AWPROT ),
          .SAXIGP1AWQOS                   (S_AXI_GP1_AWQOS  ),
          .SAXIGP1AWSIZE           (S_AXI_GP1_AWSIZE[1:0] ),
          .SAXIGP1AWVALID           (S_AXI_GP1_AWVALID),
          .SAXIGP1BREADY           (S_AXI_GP1_BREADY ),
          .SAXIGP1RREADY           (S_AXI_GP1_RREADY ),
          .SAXIGP1WDATA                   (S_AXI_GP1_WDATA  ),
          .SAXIGP1WID                   (S_AXI_GP1_WID_in    ),
          .SAXIGP1WLAST                   (S_AXI_GP1_WLAST  ),
          .SAXIGP1WSTRB                   (S_AXI_GP1_WSTRB  ),
          .SAXIGP1WVALID           (S_AXI_GP1_WVALID ),
          .SAXIHP0ACLK             (S_AXI_HP0_ACLK   ),
          .SAXIHP0ARADDR           (S_AXI_HP0_ARADDR),
          .SAXIHP0ARBURST          (S_AXI_HP0_ARBURST),
          .SAXIHP0ARCACHE          (S_AXI_HP0_ARCACHE),
          .SAXIHP0ARID             (S_AXI_HP0_ARID_in),
          .SAXIHP0ARLEN            (S_AXI_HP0_ARLEN),
          .SAXIHP0ARLOCK           (S_AXI_HP0_ARLOCK),
          .SAXIHP0ARPROT           (S_AXI_HP0_ARPROT),
          .SAXIHP0ARQOS            (S_AXI_HP0_ARQOS),
          .SAXIHP0ARSIZE           (S_AXI_HP0_ARSIZE[1:0]),
          .SAXIHP0ARVALID          (S_AXI_HP0_ARVALID),
          .SAXIHP0AWADDR           (S_AXI_HP0_AWADDR),
          .SAXIHP0AWBURST          (S_AXI_HP0_AWBURST),
          .SAXIHP0AWCACHE          (S_AXI_HP0_AWCACHE),
          .SAXIHP0AWID             (S_AXI_HP0_AWID_in),
          .SAXIHP0AWLEN            (S_AXI_HP0_AWLEN),
          .SAXIHP0AWLOCK           (S_AXI_HP0_AWLOCK),
          .SAXIHP0AWPROT           (S_AXI_HP0_AWPROT),
          .SAXIHP0AWQOS            (S_AXI_HP0_AWQOS),
          .SAXIHP0AWSIZE           (S_AXI_HP0_AWSIZE[1:0]),
          .SAXIHP0AWVALID          (S_AXI_HP0_AWVALID),
          .SAXIHP0BREADY           (S_AXI_HP0_BREADY),
          .SAXIHP0RDISSUECAP1EN    (S_AXI_HP0_RDISSUECAP1_EN),
          .SAXIHP0RREADY           (S_AXI_HP0_RREADY),
          .SAXIHP0WDATA            (S_AXI_HP0_WDATA_in),
          .SAXIHP0WID              (S_AXI_HP0_WID_in),
          .SAXIHP0WLAST            (S_AXI_HP0_WLAST),
          .SAXIHP0WRISSUECAP1EN    (S_AXI_HP0_WRISSUECAP1_EN),
          .SAXIHP0WSTRB            (S_AXI_HP0_WSTRB_in),
          .SAXIHP0WVALID           (S_AXI_HP0_WVALID),
          .SAXIHP1ACLK             (S_AXI_HP1_ACLK),
          .SAXIHP1ARADDR           (S_AXI_HP1_ARADDR),
          .SAXIHP1ARBURST          (S_AXI_HP1_ARBURST),
          .SAXIHP1ARCACHE          (S_AXI_HP1_ARCACHE),
          .SAXIHP1ARID             (S_AXI_HP1_ARID_in),
          .SAXIHP1ARLEN            (S_AXI_HP1_ARLEN),
          .SAXIHP1ARLOCK           (S_AXI_HP1_ARLOCK),
          .SAXIHP1ARPROT           (S_AXI_HP1_ARPROT),
          .SAXIHP1ARQOS            (S_AXI_HP1_ARQOS),
          .SAXIHP1ARSIZE           (S_AXI_HP1_ARSIZE[1:0]),
          .SAXIHP1ARVALID          (S_AXI_HP1_ARVALID),
          .SAXIHP1AWADDR           (S_AXI_HP1_AWADDR),
          .SAXIHP1AWBURST          (S_AXI_HP1_AWBURST),
          .SAXIHP1AWCACHE          (S_AXI_HP1_AWCACHE),
          .SAXIHP1AWID             (S_AXI_HP1_AWID_in),
          .SAXIHP1AWLEN            (S_AXI_HP1_AWLEN),
          .SAXIHP1AWLOCK           (S_AXI_HP1_AWLOCK),
          .SAXIHP1AWPROT           (S_AXI_HP1_AWPROT),
          .SAXIHP1AWQOS            (S_AXI_HP1_AWQOS),
          .SAXIHP1AWSIZE           (S_AXI_HP1_AWSIZE[1:0]),
          .SAXIHP1AWVALID          (S_AXI_HP1_AWVALID),
          .SAXIHP1BREADY           (S_AXI_HP1_BREADY),
          .SAXIHP1RDISSUECAP1EN    (S_AXI_HP1_RDISSUECAP1_EN),
          .SAXIHP1RREADY           (S_AXI_HP1_RREADY),
          .SAXIHP1WDATA            (S_AXI_HP1_WDATA_in),
          .SAXIHP1WID              (S_AXI_HP1_WID_in),
          .SAXIHP1WLAST            (S_AXI_HP1_WLAST),
          .SAXIHP1WRISSUECAP1EN    (S_AXI_HP1_WRISSUECAP1_EN),
          .SAXIHP1WSTRB            (S_AXI_HP1_WSTRB_in),
          .SAXIHP1WVALID           (S_AXI_HP1_WVALID),
          .SAXIHP2ACLK             (S_AXI_HP2_ACLK),
          .SAXIHP2ARADDR           (S_AXI_HP2_ARADDR),
          .SAXIHP2ARBURST          (S_AXI_HP2_ARBURST),
          .SAXIHP2ARCACHE          (S_AXI_HP2_ARCACHE),
          .SAXIHP2ARID             (S_AXI_HP2_ARID_in),
          .SAXIHP2ARLEN            (S_AXI_HP2_ARLEN),
          .SAXIHP2ARLOCK           (S_AXI_HP2_ARLOCK),
          .SAXIHP2ARPROT           (S_AXI_HP2_ARPROT),
          .SAXIHP2ARQOS            (S_AXI_HP2_ARQOS),
          .SAXIHP2ARSIZE           (S_AXI_HP2_ARSIZE[1:0]),
          .SAXIHP2ARVALID          (S_AXI_HP2_ARVALID),
          .SAXIHP2AWADDR           (S_AXI_HP2_AWADDR),
          .SAXIHP2AWBURST          (S_AXI_HP2_AWBURST),
          .SAXIHP2AWCACHE          (S_AXI_HP2_AWCACHE),
          .SAXIHP2AWID             (S_AXI_HP2_AWID_in),
          .SAXIHP2AWLEN            (S_AXI_HP2_AWLEN),
          .SAXIHP2AWLOCK           (S_AXI_HP2_AWLOCK),
          .SAXIHP2AWPROT           (S_AXI_HP2_AWPROT),
          .SAXIHP2AWQOS            (S_AXI_HP2_AWQOS),
          .SAXIHP2AWSIZE           (S_AXI_HP2_AWSIZE[1:0]),
          .SAXIHP2AWVALID          (S_AXI_HP2_AWVALID),
          .SAXIHP2BREADY           (S_AXI_HP2_BREADY),
          .SAXIHP2RDISSUECAP1EN    (S_AXI_HP2_RDISSUECAP1_EN),
          .SAXIHP2RREADY           (S_AXI_HP2_RREADY),
          .SAXIHP2WDATA            (S_AXI_HP2_WDATA_in),
          .SAXIHP2WID              (S_AXI_HP2_WID_in),
          .SAXIHP2WLAST            (S_AXI_HP2_WLAST),
          .SAXIHP2WRISSUECAP1EN    (S_AXI_HP2_WRISSUECAP1_EN),
          .SAXIHP2WSTRB            (S_AXI_HP2_WSTRB_in),
          .SAXIHP2WVALID           (S_AXI_HP2_WVALID),
          .SAXIHP3ACLK             (S_AXI_HP3_ACLK),
          .SAXIHP3ARADDR           (S_AXI_HP3_ARADDR ),
          .SAXIHP3ARBURST          (S_AXI_HP3_ARBURST),
          .SAXIHP3ARCACHE          (S_AXI_HP3_ARCACHE),
          .SAXIHP3ARID             (S_AXI_HP3_ARID_in   ),
          .SAXIHP3ARLEN            (S_AXI_HP3_ARLEN),
          .SAXIHP3ARLOCK           (S_AXI_HP3_ARLOCK),
          .SAXIHP3ARPROT           (S_AXI_HP3_ARPROT),
          .SAXIHP3ARQOS            (S_AXI_HP3_ARQOS),
          .SAXIHP3ARSIZE           (S_AXI_HP3_ARSIZE[1:0]),
          .SAXIHP3ARVALID          (S_AXI_HP3_ARVALID),
          .SAXIHP3AWADDR           (S_AXI_HP3_AWADDR),
          .SAXIHP3AWBURST          (S_AXI_HP3_AWBURST),
          .SAXIHP3AWCACHE          (S_AXI_HP3_AWCACHE),
          .SAXIHP3AWID             (S_AXI_HP3_AWID_in),
          .SAXIHP3AWLEN            (S_AXI_HP3_AWLEN),
          .SAXIHP3AWLOCK           (S_AXI_HP3_AWLOCK),
          .SAXIHP3AWPROT           (S_AXI_HP3_AWPROT),
          .SAXIHP3AWQOS            (S_AXI_HP3_AWQOS),
          .SAXIHP3AWSIZE           (S_AXI_HP3_AWSIZE[1:0]),
          .SAXIHP3AWVALID          (S_AXI_HP3_AWVALID),
          .SAXIHP3BREADY           (S_AXI_HP3_BREADY),
          .SAXIHP3RDISSUECAP1EN    (S_AXI_HP3_RDISSUECAP1_EN),
          .SAXIHP3RREADY           (S_AXI_HP3_RREADY),
          .SAXIHP3WDATA            (S_AXI_HP3_WDATA_in),
          .SAXIHP3WID              (S_AXI_HP3_WID_in),
          .SAXIHP3WLAST            (S_AXI_HP3_WLAST),
          .SAXIHP3WRISSUECAP1EN    (S_AXI_HP3_WRISSUECAP1_EN),
          .SAXIHP3WSTRB            (S_AXI_HP3_WSTRB_in),
          .SAXIHP3WVALID           (S_AXI_HP3_WVALID),
          .DDRA                           (buffered_DDR_Addr),
          .DDRBA                   (buffered_DDR_BankAddr),
          .DDRCASB                   (buffered_DDR_CAS_n),
          .DDRCKE                   (buffered_DDR_CKE),
          .DDRCKN                   (buffered_DDR_Clk_n),
          .DDRCKP                   (buffered_DDR_Clk),
          .DDRCSB                   (buffered_DDR_CS_n),
          .DDRDM                   (buffered_DDR_DM),
          .DDRDQ                   (buffered_DDR_DQ),
          .DDRDQSN                   (buffered_DDR_DQS_n),
          .DDRDQSP                   (buffered_DDR_DQS),
          .DDRDRSTB                (buffered_DDR_DRSTB),
          .DDRODT                   (buffered_DDR_ODT),
          .DDRRASB                   (buffered_DDR_RAS_n),
          .DDRVRN          (buffered_DDR_VRN),
          .DDRVRP          (buffered_DDR_VRP),
          .DDRWEB          (buffered_DDR_WEB),
          .MIO                           ({buffered_MIO[31:30],dummy[21:20],buffered_MIO[29:28],dummy[19:12],buffered_MIO[27:16],dummy[11:0],buffered_MIO[15:0]}),
          .PSCLK                   (buffered_PS_CLK),
          .PSPORB                   (buffered_PS_PORB),
          .PSSRSTB                   (buffered_PS_SRSTB)
);
 end
 else begin
        PS7 PS7_i (
          .DMA0DATYPE                   (DMA0_DATYPE ),
          .DMA0DAVALID                   (DMA0_DAVALID),
          .DMA0DRREADY                   (DMA0_DRREADY),
          .DMA0RSTN                   (DMA0_RSTN   ),
          .DMA1DATYPE                   (DMA1_DATYPE ),
          .DMA1DAVALID                   (DMA1_DAVALID),
          .DMA1DRREADY                   (DMA1_DRREADY),
          .DMA1RSTN                   (DMA1_RSTN   ),
          .DMA2DATYPE                   (DMA2_DATYPE ),
          .DMA2DAVALID                   (DMA2_DAVALID),
          .DMA2DRREADY                   (DMA2_DRREADY),
          .DMA2RSTN                   (DMA2_RSTN   ),
          .DMA3DATYPE                   (DMA3_DATYPE ),
          .DMA3DAVALID                   (DMA3_DAVALID),
          .DMA3DRREADY                   (DMA3_DRREADY),
          .DMA3RSTN                   (DMA3_RSTN   ),
          .EMIOCAN0PHYTX           (CAN0_PHY_TX ),
          .EMIOCAN1PHYTX           (CAN1_PHY_TX ),
          .EMIOENET0GMIITXD           (ENET0_GMII_TXD_i ),
          .EMIOENET0GMIITXEN           (ENET0_GMII_TX_EN_i),
          .EMIOENET0GMIITXER           (ENET0_GMII_TX_ER_i),
          .EMIOENET0MDIOMDC           (ENET0_MDIO_MDC),
          .EMIOENET0MDIOO           (ENET0_MDIO_O  ),
          .EMIOENET0MDIOTN           (ENET0_MDIO_T_n  ),
          .EMIOENET0PTPDELAYREQRX  (ENET0_PTP_DELAY_REQ_RX),
          .EMIOENET0PTPDELAYREQTX  (ENET0_PTP_DELAY_REQ_TX),
          .EMIOENET0PTPPDELAYREQRX (ENET0_PTP_PDELAY_REQ_RX),
          .EMIOENET0PTPPDELAYREQTX (ENET0_PTP_PDELAY_REQ_TX),
          .EMIOENET0PTPPDELAYRESPRX(ENET0_PTP_PDELAY_RESP_RX),
          .EMIOENET0PTPPDELAYRESPTX(ENET0_PTP_PDELAY_RESP_TX),
          .EMIOENET0PTPSYNCFRAMERX (ENET0_PTP_SYNC_FRAME_RX),
          .EMIOENET0PTPSYNCFRAMETX (ENET0_PTP_SYNC_FRAME_TX),
          .EMIOENET0SOFRX          (ENET0_SOF_RX),
          .EMIOENET0SOFTX          (ENET0_SOF_TX),
          .EMIOENET1GMIITXD           (ENET1_GMII_TXD_i),
          .EMIOENET1GMIITXEN           (ENET1_GMII_TX_EN_i),
          .EMIOENET1GMIITXER           (ENET1_GMII_TX_ER_i),
          .EMIOENET1MDIOMDC           (ENET1_MDIO_MDC),
          .EMIOENET1MDIOO           (ENET1_MDIO_O  ),
          .EMIOENET1MDIOTN           (ENET1_MDIO_T_n),
          .EMIOENET1PTPDELAYREQRX  (ENET1_PTP_DELAY_REQ_RX),
          .EMIOENET1PTPDELAYREQTX  (ENET1_PTP_DELAY_REQ_TX),
          .EMIOENET1PTPPDELAYREQRX (ENET1_PTP_PDELAY_REQ_RX),
          .EMIOENET1PTPPDELAYREQTX (ENET1_PTP_PDELAY_REQ_TX),
          .EMIOENET1PTPPDELAYRESPRX(ENET1_PTP_PDELAY_RESP_RX),
          .EMIOENET1PTPPDELAYRESPTX(ENET1_PTP_PDELAY_RESP_TX),
          .EMIOENET1PTPSYNCFRAMERX (ENET1_PTP_SYNC_FRAME_RX),
          .EMIOENET1PTPSYNCFRAMETX (ENET1_PTP_SYNC_FRAME_TX),
          .EMIOENET1SOFRX          (ENET1_SOF_RX),
          .EMIOENET1SOFTX          (ENET1_SOF_TX),
          .EMIOGPIOO                   (gpio_out),
          .EMIOGPIOTN                   (gpio_out_t_n),
          .EMIOI2C0SCLO            (I2C0_SCL_O),
          .EMIOI2C0SCLTN           (I2C0_SCL_T_n),
          .EMIOI2C0SDAO                   (I2C0_SDA_O),
          .EMIOI2C0SDATN           (I2C0_SDA_T_n),
          .EMIOI2C1SCLO                   (I2C1_SCL_O),
          .EMIOI2C1SCLTN           (I2C1_SCL_T_n),
          .EMIOI2C1SDAO                   (I2C1_SDA_O),
          .EMIOI2C1SDATN           (I2C1_SDA_T_n),
          .EMIOPJTAGTDO             (PJTAG_TD_O),
          .EMIOPJTAGTDTN           (PJTAG_TD_T_n),
          .EMIOSDIO0BUSPOW         (SDIO0_BUSPOW),
          .EMIOSDIO0CLK                   (SDIO0_CLK   ),
          .EMIOSDIO0CMDO           (SDIO0_CMD_O ),
          .EMIOSDIO0CMDTN           (SDIO0_CMD_T_n ),
          .EMIOSDIO0DATAO           (SDIO0_DATA_O),
          .EMIOSDIO0DATATN           (SDIO0_DATA_T_n),
          .EMIOSDIO0LED            (SDIO0_LED),
          .EMIOSDIO1BUSPOW         (SDIO1_BUSPOW),
          .EMIOSDIO1CLK            (SDIO1_CLK   ),
          .EMIOSDIO1CMDO           (SDIO1_CMD_O ),
          .EMIOSDIO1CMDTN          (SDIO1_CMD_T_n ),
          .EMIOSDIO1DATAO          (SDIO1_DATA_O),
          .EMIOSDIO1DATATN         (SDIO1_DATA_T_n),
          .EMIOSDIO1LED            (SDIO1_LED),
          .EMIOSPI0MO                   (SPI0_MOSI_O),
          .EMIOSPI0MOTN                   (SPI0_MOSI_T_n),
          .EMIOSPI0SCLKO           (SPI0_SCLK_O),
          .EMIOSPI0SCLKTN           (SPI0_SCLK_T_n),
          .EMIOSPI0SO                   (SPI0_MISO_O),
          .EMIOSPI0STN                   (SPI0_MISO_T_n),
          .EMIOSPI0SSON                   ({SPI0_SS2_O,SPI0_SS1_O,SPI0_SS_O}),
          .EMIOSPI0SSNTN           (SPI0_SS_T_n),
          .EMIOSPI1MO                   (SPI1_MOSI_O),
          .EMIOSPI1MOTN                   (SPI1_MOSI_T_n),
          .EMIOSPI1SCLKO           (SPI1_SCLK_O),
          .EMIOSPI1SCLKTN           (SPI1_SCLK_T_n),
          .EMIOSPI1SO                   (SPI1_MISO_O),
          .EMIOSPI1STN                   (SPI1_MISO_T_n),
          .EMIOSPI1SSON                   ({SPI1_SS2_O,SPI1_SS1_O,SPI1_SS_O}),
          .EMIOSPI1SSNTN           (SPI1_SS_T_n),
          .EMIOTRACECTL                   (TRACE_CTL_i),
          .EMIOTRACEDATA           (TRACE_DATA_i),
          .EMIOTTC0WAVEO           ({TTC0_WAVE2_OUT,TTC0_WAVE1_OUT,TTC0_WAVE0_OUT}),
          .EMIOTTC1WAVEO           ({TTC1_WAVE2_OUT,TTC1_WAVE1_OUT,TTC1_WAVE0_OUT}),
          .EMIOUART0DTRN           (UART0_DTRN),
          .EMIOUART0RTSN           (UART0_RTSN),
          .EMIOUART0TX                   (UART0_TX  ),
          .EMIOUART1DTRN           (UART1_DTRN),
          .EMIOUART1RTSN           (UART1_RTSN),
          .EMIOUART1TX                   (UART1_TX  ),
          .EMIOUSB0PORTINDCTL      (USB0_PORT_INDCTL),
          .EMIOUSB0VBUSPWRSELECT   (USB0_VBUS_PWRSELECT),
          .EMIOUSB1PORTINDCTL      (USB1_PORT_INDCTL),
          .EMIOUSB1VBUSPWRSELECT   (USB1_VBUS_PWRSELECT),
          .EMIOWDTRSTO               (WDT_RST_OUT),
          .EVENTEVENTO             (EVENT_EVENTO),
          .EVENTSTANDBYWFE         (EVENT_STANDBYWFE),
          .EVENTSTANDBYWFI         (EVENT_STANDBYWFI),
          .FCLKCLK                   (FCLK_CLK_unbuffered),
          .FCLKRESETN                   ({FCLK_RESET3_N,FCLK_RESET2_N,FCLK_RESET1_N,FCLK_RESET0_N}),
          .EMIOSDIO0BUSVOLT        (SDIO0_BUSVOLT),
          .EMIOSDIO1BUSVOLT        (SDIO1_BUSVOLT),
          .FTMTF2PTRIGACK           ({FTMT_F2P_TRIGACK_3,FTMT_F2P_TRIGACK_2,FTMT_F2P_TRIGACK_1,FTMT_F2P_TRIGACK_0}),
          .FTMTP2FDEBUG                   (FTMT_P2F_DEBUG  ),
          .FTMTP2FTRIG                   ({FTMT_P2F_TRIG_3,FTMT_P2F_TRIG_2,FTMT_P2F_TRIG_1,FTMT_P2F_TRIG_0}),
          .IRQP2F                   ({IRQ_P2F_DMAC_ABORT, IRQ_P2F_DMAC7, IRQ_P2F_DMAC6, IRQ_P2F_DMAC5, IRQ_P2F_DMAC4, IRQ_P2F_DMAC3, IRQ_P2F_DMAC2, IRQ_P2F_DMAC1, IRQ_P2F_DMAC0, IRQ_P2F_SMC, IRQ_P2F_QSPI, IRQ_P2F_CTI, IRQ_P2F_GPIO, IRQ_P2F_USB0, IRQ_P2F_ENET0, IRQ_P2F_ENET_WAKE0, IRQ_P2F_SDIO0, IRQ_P2F_I2C0, IRQ_P2F_SPI0, IRQ_P2F_UART0, IRQ_P2F_CAN0, IRQ_P2F_USB1, IRQ_P2F_ENET1, IRQ_P2F_ENET_WAKE1, IRQ_P2F_SDIO1, IRQ_P2F_I2C1, IRQ_P2F_SPI1, IRQ_P2F_UART1, IRQ_P2F_CAN1}),
          .MAXIGP0ARADDR           (M_AXI_GP0_ARADDR),
          .MAXIGP0ARBURST           (M_AXI_GP0_ARBURST),
          .MAXIGP0ARCACHE           (M_AXI_GP0_ARCACHE),
          .MAXIGP0ARESETN           (M_AXI_GP0_ARESETN),
          .MAXIGP0ARID                   (M_AXI_GP0_ARID_FULL   ),
          .MAXIGP0ARLEN                   (M_AXI_GP0_ARLEN  ),
          .MAXIGP0ARLOCK           (M_AXI_GP0_ARLOCK ),
          .MAXIGP0ARPROT           (M_AXI_GP0_ARPROT ),
          .MAXIGP0ARQOS                   (M_AXI_GP0_ARQOS  ),
          .MAXIGP0ARSIZE           (M_AXI_GP0_ARSIZE_i ),
          .MAXIGP0ARVALID           (M_AXI_GP0_ARVALID),
          .MAXIGP0AWADDR           (M_AXI_GP0_AWADDR ),
          .MAXIGP0AWBURST           (M_AXI_GP0_AWBURST),
          .MAXIGP0AWCACHE           (M_AXI_GP0_AWCACHE),
          .MAXIGP0AWID                   (M_AXI_GP0_AWID_FULL   ),
          .MAXIGP0AWLEN                   (M_AXI_GP0_AWLEN  ),
          .MAXIGP0AWLOCK           (M_AXI_GP0_AWLOCK ),
          .MAXIGP0AWPROT           (M_AXI_GP0_AWPROT ),
          .MAXIGP0AWQOS                   (M_AXI_GP0_AWQOS  ),
          .MAXIGP0AWSIZE           (M_AXI_GP0_AWSIZE_i ),
          .MAXIGP0AWVALID           (M_AXI_GP0_AWVALID),
          .MAXIGP0BREADY           (M_AXI_GP0_BREADY ),
          .MAXIGP0RREADY           (M_AXI_GP0_RREADY ),
          .MAXIGP0WDATA                   (M_AXI_GP0_WDATA  ),
          .MAXIGP0WID                   (M_AXI_GP0_WID_FULL    ),
          .MAXIGP0WLAST                   (M_AXI_GP0_WLAST  ),
          .MAXIGP0WSTRB                   (M_AXI_GP0_WSTRB  ),
          .MAXIGP0WVALID           (M_AXI_GP0_WVALID ),
          .MAXIGP1ARADDR           (M_AXI_GP1_ARADDR ),
          .MAXIGP1ARBURST           (M_AXI_GP1_ARBURST),
          .MAXIGP1ARCACHE           (M_AXI_GP1_ARCACHE),
          .MAXIGP1ARESETN           (M_AXI_GP1_ARESETN),
          .MAXIGP1ARID                   (M_AXI_GP1_ARID_FULL   ),
          .MAXIGP1ARLEN                   (M_AXI_GP1_ARLEN  ),
          .MAXIGP1ARLOCK           (M_AXI_GP1_ARLOCK ),
          .MAXIGP1ARPROT           (M_AXI_GP1_ARPROT ),
          .MAXIGP1ARQOS                   (M_AXI_GP1_ARQOS  ),
          .MAXIGP1ARSIZE           (M_AXI_GP1_ARSIZE_i ),
          .MAXIGP1ARVALID           (M_AXI_GP1_ARVALID),
          .MAXIGP1AWADDR           (M_AXI_GP1_AWADDR ),
          .MAXIGP1AWBURST           (M_AXI_GP1_AWBURST),
          .MAXIGP1AWCACHE           (M_AXI_GP1_AWCACHE),
          .MAXIGP1AWID                   (M_AXI_GP1_AWID_FULL   ),
          .MAXIGP1AWLEN                   (M_AXI_GP1_AWLEN  ),
          .MAXIGP1AWLOCK           (M_AXI_GP1_AWLOCK ),
          .MAXIGP1AWPROT           (M_AXI_GP1_AWPROT ),
          .MAXIGP1AWQOS                   (M_AXI_GP1_AWQOS  ),
          .MAXIGP1AWSIZE           (M_AXI_GP1_AWSIZE_i ),
          .MAXIGP1AWVALID           (M_AXI_GP1_AWVALID),
          .MAXIGP1BREADY           (M_AXI_GP1_BREADY ),
          .MAXIGP1RREADY           (M_AXI_GP1_RREADY ),
          .MAXIGP1WDATA                   (M_AXI_GP1_WDATA  ),
          .MAXIGP1WID                   (M_AXI_GP1_WID_FULL    ),
          .MAXIGP1WLAST                   (M_AXI_GP1_WLAST  ),
          .MAXIGP1WSTRB                   (M_AXI_GP1_WSTRB  ),
          .MAXIGP1WVALID           (M_AXI_GP1_WVALID ),
          .SAXIACPARESETN           (S_AXI_ACP_ARESETN),
          .SAXIACPARREADY           (SAXIACPARREADY_W),
          .SAXIACPAWREADY           (SAXIACPAWREADY_W),
          .SAXIACPBID                   (S_AXI_ACP_BID_out    ),
          .SAXIACPBRESP                   (SAXIACPBRESP_W  ),
          .SAXIACPBVALID           (SAXIACPBVALID_W ),
          .SAXIACPRDATA                   (SAXIACPRDATA_W  ),
          .SAXIACPRID                   (S_AXI_ACP_RID_out),
          .SAXIACPRLAST                   (SAXIACPRLAST_W  ),
          .SAXIACPRRESP                   (SAXIACPRRESP_W  ),
          .SAXIACPRVALID           (SAXIACPRVALID_W ),
          .SAXIACPWREADY           (SAXIACPWREADY_W ),
          .SAXIGP0ARESETN           (S_AXI_GP0_ARESETN),
          .SAXIGP0ARREADY           (S_AXI_GP0_ARREADY),
          .SAXIGP0AWREADY           (S_AXI_GP0_AWREADY),
          .SAXIGP0BID                   (S_AXI_GP0_BID_out),
          .SAXIGP0BRESP                   (S_AXI_GP0_BRESP  ),
          .SAXIGP0BVALID           (S_AXI_GP0_BVALID ),
          .SAXIGP0RDATA                   (S_AXI_GP0_RDATA  ),
          .SAXIGP0RID                   (S_AXI_GP0_RID_out ),
          .SAXIGP0RLAST                   (S_AXI_GP0_RLAST  ),
          .SAXIGP0RRESP                   (S_AXI_GP0_RRESP  ),
          .SAXIGP0RVALID           (S_AXI_GP0_RVALID ),
          .SAXIGP0WREADY           (S_AXI_GP0_WREADY ),
          .SAXIGP1ARESETN           (S_AXI_GP1_ARESETN),
          .SAXIGP1ARREADY           (S_AXI_GP1_ARREADY),
          .SAXIGP1AWREADY           (S_AXI_GP1_AWREADY),
          .SAXIGP1BID                   (S_AXI_GP1_BID_out    ),
          .SAXIGP1BRESP                   (S_AXI_GP1_BRESP  ),
          .SAXIGP1BVALID           (S_AXI_GP1_BVALID ),
          .SAXIGP1RDATA                   (S_AXI_GP1_RDATA  ),
          .SAXIGP1RID                   (S_AXI_GP1_RID_out    ),
          .SAXIGP1RLAST                   (S_AXI_GP1_RLAST  ),
          .SAXIGP1RRESP                   (S_AXI_GP1_RRESP  ),
          .SAXIGP1RVALID           (S_AXI_GP1_RVALID ),
          .SAXIGP1WREADY           (S_AXI_GP1_WREADY ),
          .SAXIHP0ARESETN           (S_AXI_HP0_ARESETN),
          .SAXIHP0ARREADY           (S_AXI_HP0_ARREADY),
          .SAXIHP0AWREADY           (S_AXI_HP0_AWREADY),
          .SAXIHP0BID                   (S_AXI_HP0_BID_out    ),
          .SAXIHP0BRESP                   (S_AXI_HP0_BRESP  ),
          .SAXIHP0BVALID           (S_AXI_HP0_BVALID ),
          .SAXIHP0RACOUNT          (S_AXI_HP0_RACOUNT),
          .SAXIHP0RCOUNT           (S_AXI_HP0_RCOUNT),
          .SAXIHP0RDATA                   (S_AXI_HP0_RDATA_out),
          .SAXIHP0RID                   (S_AXI_HP0_RID_out ),
          .SAXIHP0RLAST                   (S_AXI_HP0_RLAST),
          .SAXIHP0RRESP                   (S_AXI_HP0_RRESP),
          .SAXIHP0RVALID           (S_AXI_HP0_RVALID),
          .SAXIHP0WCOUNT           (S_AXI_HP0_WCOUNT),
          .SAXIHP0WACOUNT          (S_AXI_HP0_WACOUNT),
          .SAXIHP0WREADY           (S_AXI_HP0_WREADY),
          .SAXIHP1ARESETN           (S_AXI_HP1_ARESETN),
          .SAXIHP1ARREADY           (S_AXI_HP1_ARREADY),
          .SAXIHP1AWREADY           (S_AXI_HP1_AWREADY),
          .SAXIHP1BID                   (S_AXI_HP1_BID_out    ),
          .SAXIHP1BRESP                   (S_AXI_HP1_BRESP  ),
          .SAXIHP1BVALID           (S_AXI_HP1_BVALID ),
          .SAXIHP1RACOUNT           (S_AXI_HP1_RACOUNT ),
          .SAXIHP1RCOUNT           (S_AXI_HP1_RCOUNT ),
          .SAXIHP1RDATA                   (S_AXI_HP1_RDATA_out),
          .SAXIHP1RID                   (S_AXI_HP1_RID_out    ),
          .SAXIHP1RLAST                   (S_AXI_HP1_RLAST  ),
          .SAXIHP1RRESP                   (S_AXI_HP1_RRESP  ),
          .SAXIHP1RVALID           (S_AXI_HP1_RVALID),
          .SAXIHP1WACOUNT           (S_AXI_HP1_WACOUNT),
          .SAXIHP1WCOUNT           (S_AXI_HP1_WCOUNT),
          .SAXIHP1WREADY           (S_AXI_HP1_WREADY),
          .SAXIHP2ARESETN           (S_AXI_HP2_ARESETN),
          .SAXIHP2ARREADY           (S_AXI_HP2_ARREADY),
          .SAXIHP2AWREADY           (S_AXI_HP2_AWREADY),
          .SAXIHP2BID                   (S_AXI_HP2_BID_out ),
          .SAXIHP2BRESP                   (S_AXI_HP2_BRESP),
          .SAXIHP2BVALID           (S_AXI_HP2_BVALID),
          .SAXIHP2RACOUNT           (S_AXI_HP2_RACOUNT),
          .SAXIHP2RCOUNT           (S_AXI_HP2_RCOUNT),
          .SAXIHP2RDATA                   (S_AXI_HP2_RDATA_out),
          .SAXIHP2RID                   (S_AXI_HP2_RID_out ),
          .SAXIHP2RLAST                   (S_AXI_HP2_RLAST),
          .SAXIHP2RRESP                   (S_AXI_HP2_RRESP),
          .SAXIHP2RVALID           (S_AXI_HP2_RVALID),
          .SAXIHP2WACOUNT           (S_AXI_HP2_WACOUNT),
          .SAXIHP2WCOUNT           (S_AXI_HP2_WCOUNT),
          .SAXIHP2WREADY           (S_AXI_HP2_WREADY),
          .SAXIHP3ARESETN           (S_AXI_HP3_ARESETN),
          .SAXIHP3ARREADY           (S_AXI_HP3_ARREADY),
          .SAXIHP3AWREADY           (S_AXI_HP3_AWREADY),
          .SAXIHP3BID                   (S_AXI_HP3_BID_out),
          .SAXIHP3BRESP                   (S_AXI_HP3_BRESP),
          .SAXIHP3BVALID           (S_AXI_HP3_BVALID),
          .SAXIHP3RACOUNT           (S_AXI_HP3_RACOUNT),
          .SAXIHP3RCOUNT           (S_AXI_HP3_RCOUNT),
          .SAXIHP3RDATA                   (S_AXI_HP3_RDATA_out),
          .SAXIHP3RID                   (S_AXI_HP3_RID_out),
          .SAXIHP3RLAST                   (S_AXI_HP3_RLAST),
          .SAXIHP3RRESP                   (S_AXI_HP3_RRESP),
          .SAXIHP3RVALID           (S_AXI_HP3_RVALID),
          .SAXIHP3WCOUNT           (S_AXI_HP3_WCOUNT),
          .SAXIHP3WACOUNT           (S_AXI_HP3_WACOUNT),
          .SAXIHP3WREADY           (S_AXI_HP3_WREADY),
          .DDRARB                  (DDR_ARB),
          .DMA0ACLK                   (DMA0_ACLK   ),
          .DMA0DAREADY                   (DMA0_DAREADY),
          .DMA0DRLAST                   (DMA0_DRLAST ),
          .DMA0DRTYPE              (DMA0_DRTYPE),
          .DMA0DRVALID                   (DMA0_DRVALID),
          .DMA1ACLK                   (DMA1_ACLK   ),
          .DMA1DAREADY                   (DMA1_DAREADY),
          .DMA1DRLAST                   (DMA1_DRLAST ),
          .DMA1DRTYPE              (DMA1_DRTYPE),
          .DMA1DRVALID                   (DMA1_DRVALID),
          .DMA2ACLK                   (DMA2_ACLK   ),
          .DMA2DAREADY                   (DMA2_DAREADY),
          .DMA2DRLAST                   (DMA2_DRLAST ),
          .DMA2DRTYPE              (DMA2_DRTYPE),
          .DMA2DRVALID                   (DMA2_DRVALID),
          .DMA3ACLK                   (DMA3_ACLK   ),
          .DMA3DAREADY                   (DMA3_DAREADY),
          .DMA3DRLAST                   (DMA3_DRLAST ),
          .DMA3DRTYPE              (DMA3_DRTYPE),
          .DMA3DRVALID                   (DMA3_DRVALID),
          .EMIOCAN0PHYRX           (CAN0_PHY_RX),
          .EMIOCAN1PHYRX           (CAN1_PHY_RX),
          .EMIOENET0EXTINTIN       (ENET0_EXT_INTIN),
          .EMIOENET0GMIICOL        (ENET0_GMII_COL_i),
          .EMIOENET0GMIICRS        (ENET0_GMII_CRS_i),
          .EMIOENET0GMIIRXCLK      (ENET0_GMII_RX_CLK),
          .EMIOENET0GMIIRXD        (ENET0_GMII_RXD_i),
          .EMIOENET0GMIIRXDV       (ENET0_GMII_RX_DV_i),
          .EMIOENET0GMIIRXER       (ENET0_GMII_RX_ER_i),
          .EMIOENET0GMIITXCLK      (ENET0_GMII_TX_CLK),
          .EMIOENET0MDIOI          (ENET0_MDIO_I),
          .EMIOENET1EXTINTIN       (ENET1_EXT_INTIN),
          .EMIOENET1GMIICOL        (ENET1_GMII_COL_i),
          .EMIOENET1GMIICRS        (ENET1_GMII_CRS_i),
          .EMIOENET1GMIIRXCLK      (ENET1_GMII_RX_CLK),
          .EMIOENET1GMIIRXD        (ENET1_GMII_RXD_i),
          .EMIOENET1GMIIRXDV       (ENET1_GMII_RX_DV_i),
          .EMIOENET1GMIIRXER       (ENET1_GMII_RX_ER_i),
          .EMIOENET1GMIITXCLK      (ENET1_GMII_TX_CLK),
          .EMIOENET1MDIOI          (ENET1_MDIO_I),
          .EMIOGPIOI                   (gpio_in63_0  ),
          .EMIOI2C0SCLI                   (I2C0_SCL_I),
          .EMIOI2C0SDAI                   (I2C0_SDA_I),
          .EMIOI2C1SCLI                   (I2C1_SCL_I),
          .EMIOI2C1SDAI                   (I2C1_SDA_I),
          .EMIOPJTAGTCK                   (PJTAG_TCK),
          .EMIOPJTAGTDI                   (PJTAG_TD_I),
          .EMIOPJTAGTMS                   (PJTAG_TMS),
          .EMIOSDIO0CDN            (SDIO0_CDN),
          .EMIOSDIO0CLKFB           (SDIO0_CLK_FB  ),
          .EMIOSDIO0CMDI           (SDIO0_CMD_I   ),
          .EMIOSDIO0DATAI           (SDIO0_DATA_I  ),
          .EMIOSDIO0WP             (SDIO0_WP),
          .EMIOSDIO1CDN            (SDIO1_CDN),
          .EMIOSDIO1CLKFB           (SDIO1_CLK_FB  ),
          .EMIOSDIO1CMDI           (SDIO1_CMD_I   ),
          .EMIOSDIO1DATAI           (SDIO1_DATA_I  ),
          .EMIOSDIO1WP             (SDIO1_WP),
          .EMIOSPI0MI                   (SPI0_MISO_I),
          .EMIOSPI0SCLKI           (SPI0_SCLK_I),
          .EMIOSPI0SI                   (SPI0_MOSI_I),
          .EMIOSPI0SSIN            (SPI0_SS_I),
          .EMIOSPI1MI                   (SPI1_MISO_I),
          .EMIOSPI1SCLKI           (SPI1_SCLK_I),
          .EMIOSPI1SI                   (SPI1_MOSI_I),
          .EMIOSPI1SSIN                   (SPI1_SS_I),
          .EMIOSRAMINTIN           (SRAM_INTIN),
          .EMIOTRACECLK                   (TRACE_CLK),
          .EMIOTTC0CLKI                   ({TTC0_CLK2_IN, TTC0_CLK1_IN, TTC0_CLK0_IN}),
          .EMIOTTC1CLKI                   ({TTC1_CLK2_IN, TTC1_CLK1_IN, TTC1_CLK0_IN}),
          .EMIOUART0CTSN           (UART0_CTSN),
          .EMIOUART0DCDN           (UART0_DCDN),
          .EMIOUART0DSRN           (UART0_DSRN),
          .EMIOUART0RIN                   (UART0_RIN ),
          .EMIOUART0RX                   (UART0_RX  ),
          .EMIOUART1CTSN           (UART1_CTSN),
          .EMIOUART1DCDN           (UART1_DCDN),
          .EMIOUART1DSRN           (UART1_DSRN),
          .EMIOUART1RIN                   (UART1_RIN ),
          .EMIOUART1RX                   (UART1_RX  ),
          .EMIOUSB0VBUSPWRFAULT    (USB0_VBUS_PWRFAULT),
          .EMIOUSB1VBUSPWRFAULT    (USB1_VBUS_PWRFAULT),
          .EMIOWDTCLKI                   (WDT_CLK_IN),
          .EVENTEVENTI             (EVENT_EVENTI),
          .FCLKCLKTRIGN                   (fclk_clktrig_gnd),
          .FPGAIDLEN                   (FPGA_IDLE_N),
          .FTMDTRACEINATID           (FTMD_TRACEIN_ATID_i),
          .FTMDTRACEINCLOCK           (FTMD_TRACEIN_CLK),
          .FTMDTRACEINDATA           (FTMD_TRACEIN_DATA_i),
          .FTMDTRACEINVALID           (FTMD_TRACEIN_VALID_i),
          .FTMTF2PDEBUG                   (FTMT_F2P_DEBUG  ),
          .FTMTF2PTRIG                   ({FTMT_F2P_TRIG_3,FTMT_F2P_TRIG_2,FTMT_F2P_TRIG_1,FTMT_F2P_TRIG_0}),
          .FTMTP2FTRIGACK           ({FTMT_P2F_TRIGACK_3,FTMT_P2F_TRIGACK_2,FTMT_P2F_TRIGACK_1,FTMT_P2F_TRIGACK_0}),
          .IRQF2P                   (irq_f2p_i),
          .MAXIGP0ACLK                   (M_AXI_GP0_ACLK),
          .MAXIGP0ARREADY           (M_AXI_GP0_ARREADY),
          .MAXIGP0AWREADY           (M_AXI_GP0_AWREADY),
          .MAXIGP0BID                   (M_AXI_GP0_BID_FULL    ),
          .MAXIGP0BRESP                   (M_AXI_GP0_BRESP  ),
          .MAXIGP0BVALID           (M_AXI_GP0_BVALID ),
          .MAXIGP0RDATA                   (M_AXI_GP0_RDATA  ),
          .MAXIGP0RID                   (M_AXI_GP0_RID_FULL    ),
          .MAXIGP0RLAST                   (M_AXI_GP0_RLAST  ),
          .MAXIGP0RRESP                   (M_AXI_GP0_RRESP  ),
          .MAXIGP0RVALID           (M_AXI_GP0_RVALID ),
          .MAXIGP0WREADY           (M_AXI_GP0_WREADY ),
          .MAXIGP1ACLK                   (M_AXI_GP1_ACLK   ),
          .MAXIGP1ARREADY           (M_AXI_GP1_ARREADY),
          .MAXIGP1AWREADY           (M_AXI_GP1_AWREADY),
          .MAXIGP1BID                   (M_AXI_GP1_BID_FULL ),
          .MAXIGP1BRESP                   (M_AXI_GP1_BRESP  ),
          .MAXIGP1BVALID           (M_AXI_GP1_BVALID ),
          .MAXIGP1RDATA                   (M_AXI_GP1_RDATA  ),
          .MAXIGP1RID                   (M_AXI_GP1_RID_FULL    ),
          .MAXIGP1RLAST                   (M_AXI_GP1_RLAST  ),
          .MAXIGP1RRESP                   (M_AXI_GP1_RRESP  ),
          .MAXIGP1RVALID           (M_AXI_GP1_RVALID ),
          .MAXIGP1WREADY           (M_AXI_GP1_WREADY ),
          .SAXIACPACLK                   (S_AXI_ACP_ACLK   ),
          .SAXIACPARADDR           (SAXIACPARADDR_W ),
          .SAXIACPARBURST           (SAXIACPARBURST_W),
          .SAXIACPARCACHE           (SAXIACPARCACHE_W),
          .SAXIACPARID                   (S_AXI_ACP_ARID_in   ),
          .SAXIACPARLEN                   (SAXIACPARLEN_W  ),
          .SAXIACPARLOCK           (SAXIACPARLOCK_W ),
          .SAXIACPARPROT           (SAXIACPARPROT_W ),
          .SAXIACPARQOS                   (S_AXI_ACP_ARQOS  ),
          .SAXIACPARSIZE           (SAXIACPARSIZE_W[1:0] ),
          .SAXIACPARUSER           (SAXIACPARUSER_W ),
          .SAXIACPARVALID           (SAXIACPARVALID_W),
          .SAXIACPAWADDR           (SAXIACPAWADDR_W ),
          .SAXIACPAWBURST           (SAXIACPAWBURST_W),
          .SAXIACPAWCACHE           (SAXIACPAWCACHE_W),
          .SAXIACPAWID                   (S_AXI_ACP_AWID_in   ),
          .SAXIACPAWLEN                   (SAXIACPAWLEN_W  ),
          .SAXIACPAWLOCK           (SAXIACPAWLOCK_W ),
          .SAXIACPAWPROT           (SAXIACPAWPROT_W ),
          .SAXIACPAWQOS                   (S_AXI_ACP_AWQOS  ),
          .SAXIACPAWSIZE           (SAXIACPAWSIZE_W[1:0] ),
          .SAXIACPAWUSER           (SAXIACPAWUSER_W ),
          .SAXIACPAWVALID           (SAXIACPAWVALID_W),
          .SAXIACPBREADY           (SAXIACPBREADY_W ),
          .SAXIACPRREADY           (SAXIACPRREADY_W ),
          .SAXIACPWDATA                   (SAXIACPWDATA_W  ),
          .SAXIACPWID                   (S_AXI_ACP_WID_in    ),
          .SAXIACPWLAST                   (SAXIACPWLAST_W  ),
          .SAXIACPWSTRB                   (SAXIACPWSTRB_W  ),
          .SAXIACPWVALID           (SAXIACPWVALID_W ),
          .SAXIGP0ACLK             (S_AXI_GP0_ACLK   ),
          .SAXIGP0ARADDR           (S_AXI_GP0_ARADDR ),
          .SAXIGP0ARBURST          (S_AXI_GP0_ARBURST),
          .SAXIGP0ARCACHE          (S_AXI_GP0_ARCACHE),
          .SAXIGP0ARID             (S_AXI_GP0_ARID_in   ),
          .SAXIGP0ARLEN            (S_AXI_GP0_ARLEN  ),
          .SAXIGP0ARLOCK           (S_AXI_GP0_ARLOCK ),
          .SAXIGP0ARPROT           (S_AXI_GP0_ARPROT ),
          .SAXIGP0ARQOS            (S_AXI_GP0_ARQOS  ),
          .SAXIGP0ARSIZE           (S_AXI_GP0_ARSIZE[1:0] ),
          .SAXIGP0ARVALID          (S_AXI_GP0_ARVALID),
          .SAXIGP0AWADDR           (S_AXI_GP0_AWADDR ),
          .SAXIGP0AWBURST          (S_AXI_GP0_AWBURST),
          .SAXIGP0AWCACHE          (S_AXI_GP0_AWCACHE),
          .SAXIGP0AWID             (S_AXI_GP0_AWID_in   ),
          .SAXIGP0AWLEN            (S_AXI_GP0_AWLEN  ),
          .SAXIGP0AWLOCK           (S_AXI_GP0_AWLOCK ),
          .SAXIGP0AWPROT           (S_AXI_GP0_AWPROT ),
          .SAXIGP0AWQOS            (S_AXI_GP0_AWQOS  ),
          .SAXIGP0AWSIZE           (S_AXI_GP0_AWSIZE[1:0] ),
          .SAXIGP0AWVALID          (S_AXI_GP0_AWVALID),
          .SAXIGP0BREADY           (S_AXI_GP0_BREADY ),
          .SAXIGP0RREADY           (S_AXI_GP0_RREADY ),
          .SAXIGP0WDATA            (S_AXI_GP0_WDATA  ),
          .SAXIGP0WID              (S_AXI_GP0_WID_in ),
          .SAXIGP0WLAST            (S_AXI_GP0_WLAST  ),
          .SAXIGP0WSTRB            (S_AXI_GP0_WSTRB  ),
          .SAXIGP0WVALID           (S_AXI_GP0_WVALID ),
          .SAXIGP1ACLK                   (S_AXI_GP1_ACLK   ),
          .SAXIGP1ARADDR           (S_AXI_GP1_ARADDR ),
          .SAXIGP1ARBURST           (S_AXI_GP1_ARBURST),
          .SAXIGP1ARCACHE           (S_AXI_GP1_ARCACHE),
          .SAXIGP1ARID                   (S_AXI_GP1_ARID_in   ),
          .SAXIGP1ARLEN                   (S_AXI_GP1_ARLEN  ),
          .SAXIGP1ARLOCK           (S_AXI_GP1_ARLOCK ),
          .SAXIGP1ARPROT           (S_AXI_GP1_ARPROT ),
          .SAXIGP1ARQOS                   (S_AXI_GP1_ARQOS  ),
          .SAXIGP1ARSIZE           (S_AXI_GP1_ARSIZE[1:0] ),
          .SAXIGP1ARVALID           (S_AXI_GP1_ARVALID),
          .SAXIGP1AWADDR           (S_AXI_GP1_AWADDR ),
          .SAXIGP1AWBURST           (S_AXI_GP1_AWBURST),
          .SAXIGP1AWCACHE           (S_AXI_GP1_AWCACHE),
          .SAXIGP1AWID                   (S_AXI_GP1_AWID_in   ),
          .SAXIGP1AWLEN                   (S_AXI_GP1_AWLEN  ),
          .SAXIGP1AWLOCK           (S_AXI_GP1_AWLOCK ),
          .SAXIGP1AWPROT           (S_AXI_GP1_AWPROT ),
          .SAXIGP1AWQOS                   (S_AXI_GP1_AWQOS  ),
          .SAXIGP1AWSIZE           (S_AXI_GP1_AWSIZE[1:0] ),
          .SAXIGP1AWVALID           (S_AXI_GP1_AWVALID),
          .SAXIGP1BREADY           (S_AXI_GP1_BREADY ),
          .SAXIGP1RREADY           (S_AXI_GP1_RREADY ),
          .SAXIGP1WDATA                   (S_AXI_GP1_WDATA  ),
          .SAXIGP1WID                   (S_AXI_GP1_WID_in    ),
          .SAXIGP1WLAST                   (S_AXI_GP1_WLAST  ),
          .SAXIGP1WSTRB                   (S_AXI_GP1_WSTRB  ),
          .SAXIGP1WVALID           (S_AXI_GP1_WVALID ),
          .SAXIHP0ACLK             (S_AXI_HP0_ACLK   ),
          .SAXIHP0ARADDR           (S_AXI_HP0_ARADDR),
          .SAXIHP0ARBURST          (S_AXI_HP0_ARBURST),
          .SAXIHP0ARCACHE          (S_AXI_HP0_ARCACHE),
          .SAXIHP0ARID             (S_AXI_HP0_ARID_in),
          .SAXIHP0ARLEN            (S_AXI_HP0_ARLEN),
          .SAXIHP0ARLOCK           (S_AXI_HP0_ARLOCK),
          .SAXIHP0ARPROT           (S_AXI_HP0_ARPROT),
          .SAXIHP0ARQOS            (S_AXI_HP0_ARQOS),
          .SAXIHP0ARSIZE           (S_AXI_HP0_ARSIZE[1:0]),
          .SAXIHP0ARVALID          (S_AXI_HP0_ARVALID),
          .SAXIHP0AWADDR           (S_AXI_HP0_AWADDR),
          .SAXIHP0AWBURST          (S_AXI_HP0_AWBURST),
          .SAXIHP0AWCACHE          (S_AXI_HP0_AWCACHE),
          .SAXIHP0AWID             (S_AXI_HP0_AWID_in),
          .SAXIHP0AWLEN            (S_AXI_HP0_AWLEN),
          .SAXIHP0AWLOCK           (S_AXI_HP0_AWLOCK),
          .SAXIHP0AWPROT           (S_AXI_HP0_AWPROT),
          .SAXIHP0AWQOS            (S_AXI_HP0_AWQOS),
          .SAXIHP0AWSIZE           (S_AXI_HP0_AWSIZE[1:0]),
          .SAXIHP0AWVALID          (S_AXI_HP0_AWVALID),
          .SAXIHP0BREADY           (S_AXI_HP0_BREADY),
          .SAXIHP0RDISSUECAP1EN    (S_AXI_HP0_RDISSUECAP1_EN),
          .SAXIHP0RREADY           (S_AXI_HP0_RREADY),
          .SAXIHP0WDATA            (S_AXI_HP0_WDATA_in),
          .SAXIHP0WID              (S_AXI_HP0_WID_in),
          .SAXIHP0WLAST            (S_AXI_HP0_WLAST),
          .SAXIHP0WRISSUECAP1EN    (S_AXI_HP0_WRISSUECAP1_EN),
          .SAXIHP0WSTRB            (S_AXI_HP0_WSTRB_in),
          .SAXIHP0WVALID           (S_AXI_HP0_WVALID),
          .SAXIHP1ACLK             (S_AXI_HP1_ACLK),
          .SAXIHP1ARADDR           (S_AXI_HP1_ARADDR),
          .SAXIHP1ARBURST          (S_AXI_HP1_ARBURST),
          .SAXIHP1ARCACHE          (S_AXI_HP1_ARCACHE),
          .SAXIHP1ARID             (S_AXI_HP1_ARID_in),
          .SAXIHP1ARLEN            (S_AXI_HP1_ARLEN),
          .SAXIHP1ARLOCK           (S_AXI_HP1_ARLOCK),
          .SAXIHP1ARPROT           (S_AXI_HP1_ARPROT),
          .SAXIHP1ARQOS            (S_AXI_HP1_ARQOS),
          .SAXIHP1ARSIZE           (S_AXI_HP1_ARSIZE[1:0]),
          .SAXIHP1ARVALID          (S_AXI_HP1_ARVALID),
          .SAXIHP1AWADDR           (S_AXI_HP1_AWADDR),
          .SAXIHP1AWBURST          (S_AXI_HP1_AWBURST),
          .SAXIHP1AWCACHE          (S_AXI_HP1_AWCACHE),
          .SAXIHP1AWID             (S_AXI_HP1_AWID_in),
          .SAXIHP1AWLEN            (S_AXI_HP1_AWLEN),
          .SAXIHP1AWLOCK           (S_AXI_HP1_AWLOCK),
          .SAXIHP1AWPROT           (S_AXI_HP1_AWPROT),
          .SAXIHP1AWQOS            (S_AXI_HP1_AWQOS),
          .SAXIHP1AWSIZE           (S_AXI_HP1_AWSIZE[1:0]),
          .SAXIHP1AWVALID          (S_AXI_HP1_AWVALID),
          .SAXIHP1BREADY           (S_AXI_HP1_BREADY),
          .SAXIHP1RDISSUECAP1EN    (S_AXI_HP1_RDISSUECAP1_EN),
          .SAXIHP1RREADY           (S_AXI_HP1_RREADY),
          .SAXIHP1WDATA            (S_AXI_HP1_WDATA_in),
          .SAXIHP1WID              (S_AXI_HP1_WID_in),
          .SAXIHP1WLAST            (S_AXI_HP1_WLAST),
          .SAXIHP1WRISSUECAP1EN    (S_AXI_HP1_WRISSUECAP1_EN),
          .SAXIHP1WSTRB            (S_AXI_HP1_WSTRB_in),
          .SAXIHP1WVALID           (S_AXI_HP1_WVALID),
          .SAXIHP2ACLK             (S_AXI_HP2_ACLK),
          .SAXIHP2ARADDR           (S_AXI_HP2_ARADDR),
          .SAXIHP2ARBURST          (S_AXI_HP2_ARBURST),
          .SAXIHP2ARCACHE          (S_AXI_HP2_ARCACHE),
          .SAXIHP2ARID             (S_AXI_HP2_ARID_in),
          .SAXIHP2ARLEN            (S_AXI_HP2_ARLEN),
          .SAXIHP2ARLOCK           (S_AXI_HP2_ARLOCK),
          .SAXIHP2ARPROT           (S_AXI_HP2_ARPROT),
          .SAXIHP2ARQOS            (S_AXI_HP2_ARQOS),
          .SAXIHP2ARSIZE           (S_AXI_HP2_ARSIZE[1:0]),
          .SAXIHP2ARVALID          (S_AXI_HP2_ARVALID),
          .SAXIHP2AWADDR           (S_AXI_HP2_AWADDR),
          .SAXIHP2AWBURST          (S_AXI_HP2_AWBURST),
          .SAXIHP2AWCACHE          (S_AXI_HP2_AWCACHE),
          .SAXIHP2AWID             (S_AXI_HP2_AWID_in),
          .SAXIHP2AWLEN            (S_AXI_HP2_AWLEN),
          .SAXIHP2AWLOCK           (S_AXI_HP2_AWLOCK),
          .SAXIHP2AWPROT           (S_AXI_HP2_AWPROT),
          .SAXIHP2AWQOS            (S_AXI_HP2_AWQOS),
          .SAXIHP2AWSIZE           (S_AXI_HP2_AWSIZE[1:0]),
          .SAXIHP2AWVALID          (S_AXI_HP2_AWVALID),
          .SAXIHP2BREADY           (S_AXI_HP2_BREADY),
          .SAXIHP2RDISSUECAP1EN    (S_AXI_HP2_RDISSUECAP1_EN),
          .SAXIHP2RREADY           (S_AXI_HP2_RREADY),
          .SAXIHP2WDATA            (S_AXI_HP2_WDATA_in),
          .SAXIHP2WID              (S_AXI_HP2_WID_in),
          .SAXIHP2WLAST            (S_AXI_HP2_WLAST),
          .SAXIHP2WRISSUECAP1EN    (S_AXI_HP2_WRISSUECAP1_EN),
          .SAXIHP2WSTRB            (S_AXI_HP2_WSTRB_in),
          .SAXIHP2WVALID           (S_AXI_HP2_WVALID),
          .SAXIHP3ACLK             (S_AXI_HP3_ACLK),
          .SAXIHP3ARADDR           (S_AXI_HP3_ARADDR ),
          .SAXIHP3ARBURST          (S_AXI_HP3_ARBURST),
          .SAXIHP3ARCACHE          (S_AXI_HP3_ARCACHE),
          .SAXIHP3ARID             (S_AXI_HP3_ARID_in   ),
          .SAXIHP3ARLEN            (S_AXI_HP3_ARLEN),
          .SAXIHP3ARLOCK           (S_AXI_HP3_ARLOCK),
          .SAXIHP3ARPROT           (S_AXI_HP3_ARPROT),
          .SAXIHP3ARQOS            (S_AXI_HP3_ARQOS),
          .SAXIHP3ARSIZE           (S_AXI_HP3_ARSIZE[1:0]),
          .SAXIHP3ARVALID          (S_AXI_HP3_ARVALID),
          .SAXIHP3AWADDR           (S_AXI_HP3_AWADDR),
          .SAXIHP3AWBURST          (S_AXI_HP3_AWBURST),
          .SAXIHP3AWCACHE          (S_AXI_HP3_AWCACHE),
          .SAXIHP3AWID             (S_AXI_HP3_AWID_in),
          .SAXIHP3AWLEN            (S_AXI_HP3_AWLEN),
          .SAXIHP3AWLOCK           (S_AXI_HP3_AWLOCK),
          .SAXIHP3AWPROT           (S_AXI_HP3_AWPROT),
          .SAXIHP3AWQOS            (S_AXI_HP3_AWQOS),
          .SAXIHP3AWSIZE           (S_AXI_HP3_AWSIZE[1:0]),
          .SAXIHP3AWVALID          (S_AXI_HP3_AWVALID),
          .SAXIHP3BREADY           (S_AXI_HP3_BREADY),
          .SAXIHP3RDISSUECAP1EN    (S_AXI_HP3_RDISSUECAP1_EN),
          .SAXIHP3RREADY           (S_AXI_HP3_RREADY),
          .SAXIHP3WDATA            (S_AXI_HP3_WDATA_in),
          .SAXIHP3WID              (S_AXI_HP3_WID_in),
          .SAXIHP3WLAST            (S_AXI_HP3_WLAST),
          .SAXIHP3WRISSUECAP1EN    (S_AXI_HP3_WRISSUECAP1_EN),
          .SAXIHP3WSTRB            (S_AXI_HP3_WSTRB_in),
          .SAXIHP3WVALID           (S_AXI_HP3_WVALID),
          .DDRA                           (buffered_DDR_Addr),
          .DDRBA                   (buffered_DDR_BankAddr),
          .DDRCASB                   (buffered_DDR_CAS_n),
          .DDRCKE                   (buffered_DDR_CKE),
          .DDRCKN                   (buffered_DDR_Clk_n),
          .DDRCKP                   (buffered_DDR_Clk),
          .DDRCSB                   (buffered_DDR_CS_n),
          .DDRDM                   (buffered_DDR_DM),
          .DDRDQ                   (buffered_DDR_DQ),
          .DDRDQSN                   (buffered_DDR_DQS_n),
          .DDRDQSP                   (buffered_DDR_DQS),
          .DDRDRSTB                (buffered_DDR_DRSTB),
          .DDRODT                   (buffered_DDR_ODT),
          .DDRRASB                   (buffered_DDR_RAS_n),
          .DDRVRN                  (buffered_DDR_VRN),
          .DDRVRP                  (buffered_DDR_VRP),
          .DDRWEB                  (buffered_DDR_WEB),
          .MIO                           (buffered_MIO),
          .PSCLK                   (buffered_PS_CLK),
          .PSPORB                   (buffered_PS_PORB),
          .PSSRSTB                   (buffered_PS_SRSTB)
        );
 end
 endgenerate
assign param_aruser = C_USE_DEFAULT_ACP_USER_VAL? C_S_AXI_ACP_ARUSER_VAL : S_AXI_ACP_ARUSER;
assign param_awuser = C_USE_DEFAULT_ACP_USER_VAL? C_S_AXI_ACP_AWUSER_VAL : S_AXI_ACP_AWUSER;
  assign  SAXIACPARADDR_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARADDR  : S_AXI_ACP_ARADDR;
  assign  SAXIACPARBURST_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARBURST : S_AXI_ACP_ARBURST;
  assign  SAXIACPARCACHE_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARCACHE : S_AXI_ACP_ARCACHE;
  assign  SAXIACPARLEN_W       = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARLEN   : S_AXI_ACP_ARLEN;
  assign  SAXIACPARLOCK_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARLOCK  : S_AXI_ACP_ARLOCK;
  assign  SAXIACPARPROT_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARPROT  : S_AXI_ACP_ARPROT;
  assign  SAXIACPARSIZE_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARSIZE  : S_AXI_ACP_ARSIZE;
  assign  SAXIACPARUSER_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARUSER  : param_aruser;
  assign  SAXIACPARVALID_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARVALID : S_AXI_ACP_ARVALID ;
  assign  SAXIACPAWADDR_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWADDR  : S_AXI_ACP_AWADDR;
  assign  SAXIACPAWBURST_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWBURST : S_AXI_ACP_AWBURST;
  assign  SAXIACPAWCACHE_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWCACHE : S_AXI_ACP_AWCACHE;
  assign  SAXIACPAWLEN_W       = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWLEN   : S_AXI_ACP_AWLEN;
  assign  SAXIACPAWLOCK_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWLOCK  : S_AXI_ACP_AWLOCK;
  assign  SAXIACPAWPROT_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWPROT  : S_AXI_ACP_AWPROT;
  assign  SAXIACPAWSIZE_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWSIZE  : S_AXI_ACP_AWSIZE;
  assign  SAXIACPAWUSER_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWUSER  : param_awuser;
  assign  SAXIACPAWVALID_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWVALID : S_AXI_ACP_AWVALID;
  assign  SAXIACPBREADY_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_BREADY  : S_AXI_ACP_BREADY;
  assign  SAXIACPRREADY_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_RREADY  : S_AXI_ACP_RREADY;
  assign  SAXIACPWDATA_W       = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_WDATA   : S_AXI_ACP_WDATA;
  assign  SAXIACPWLAST_W       = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_WLAST   : S_AXI_ACP_WLAST;
  assign  SAXIACPWSTRB_W       = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_WSTRB   : S_AXI_ACP_WSTRB;
  assign  SAXIACPWVALID_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_WVALID  : S_AXI_ACP_WVALID;
  assign  SAXIACPARID_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_ARID    : S_AXI_ACP_ARID;
  assign  SAXIACPAWID_W     = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_AWID    : S_AXI_ACP_AWID;
  assign  SAXIACPWID_W      = (C_INCLUDE_ACP_TRANS_CHECK == 1) ? S_AXI_ATC_WID     : S_AXI_ACP_WID;
    assign S_AXI_ACP_AWREADY          =   SAXIACPAWREADY_W;
    assign S_AXI_ACP_WREADY           =   SAXIACPWREADY_W;
    assign S_AXI_ACP_BID              =   SAXIACPBID_W;
    assign S_AXI_ACP_BRESP            =   SAXIACPBRESP_W;
    assign S_AXI_ACP_BVALID           =   SAXIACPBVALID_W;
    assign S_AXI_ACP_RDATA            =          SAXIACPRDATA_W;
    assign S_AXI_ACP_RID              =          SAXIACPRID_W;
    assign S_AXI_ACP_RLAST            =          SAXIACPRLAST_W;
    assign S_AXI_ACP_RRESP            =          SAXIACPRRESP_W;
    assign S_AXI_ACP_RVALID           =          SAXIACPRVALID_W;
    assign S_AXI_ACP_ARREADY          =          SAXIACPARREADY_W;
endmodule
