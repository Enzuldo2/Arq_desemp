// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Tue Jun 30 15:42:59 2026
// Host        : CP-DK-214509 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/820759/pi_serial/pi_serial.gen/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_0_bram_0/design_1_axi_bram_ctrl_0_bram_0_sim_netlist.v
// Design      : design_1_axi_bram_ctrl_0_bram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_axi_bram_ctrl_0_bram_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module design_1_axi_bram_ctrl_0_bram_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    rsta_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  output rsta_busy;

  wire [31:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire rsta;
  wire rsta_busy;
  wire [3:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.3746 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  design_1_axi_bram_ctrl_0_bram_0_blk_mem_gen_v8_4_12 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web({1'b0,1'b0,1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YqH9kwIC39+qbZg4PSfFsXuB9k9wnuxNryS/CfnEri6Ci9fSC6fsrQ/T/hnt3u/yolbJ8DJa1Qu6
Qnm24A9jLbA+fu3Nsmm6/rM6a4vU6OfVl/gTFd/CiWDutv6Dhn6Lim4uUNPahoOR/A2Yc4Zo2tdI
kMLO9gn9WlH2l3O2oXs=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XJYO2VHd/cnMxQd3i7/2qRhl57dl+doEKuhAunQyv3vpGRG/jlNxj8PqrgLoF0HMdqE3qJUVE/oq
kBSapqjVjLDMOrNGQ+Tc6VGsKMZH8FE/TXHQJ/IM5Iuiu2eozEwwVUomF+7cfqn+9OsVsqCONQ1M
g0oRlangiqasJDhhMfnlGGqwAwmgWRGQA6dmhTuua1s8zdvIv540zY6p5au8cAKVhqyyKK7wbxEE
SGuFqX+NYoyRV+rfWCcWM+hJEmnWS8LNAKkd13YE2+17sPYzUdZ23DmTxXK6KlAxKFW27CBySUfg
qdNXp2DSs2KAQYih27pBNMuHfGbM/ATFPWFvxg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lYoEi/e8HsDTz6N11EDe/B/iitERmeYndlCklmCluwgb0N4W80JUGVlkd7NlRZHRNhxaNBJPkcjC
n61nO0tb17NwsMwjbY5TF8JWRYTNw1JXCFacvQYrdKv4/7QNQEtwVGiCLxFhOA8aHlWMZIrc2fri
VRMVWaEBcPwCGorlVIM=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QEw9fEsWFbdX0OQLvYs/gl+zyEOW3ak9TdQVaq+0AXXOT3LIqF7wDxJ6ZBnlf9mNbdsUVH5tAz1o
H8u7ihJl1L3THEvugW+TS8hkvVbEA9rKO2vV15KAj4Lla7UdFT/xDfe79RFarlLI7yGrubjgdoRi
QWy//UKsffG7IWNwmoSuppWiWB4ZHJtkunNyIkm70JPGyZF62VxJg1MTT+5LUbZG5vZjjuHZud9w
xJaKv1tFP/x8RVqLU5gPOqGqTW7/nKO2S+450Vo4D9vAmBVVcXpaL1EbSmCvQ+qJmcQKtf9qYFRV
Zko08hbpHjPxstqvTDro01jRzB8592m4xU2TWA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TC7q853CWBPPJgbRfgDV1lmjUwSAtliljShAyNFg8sfRfwDzchthzoSPH1UCHV++E2JXacEKq1lB
UWsNP92U4Xh0/Gu+6esOI0pJb8I+TRTxyBN1I4cRQEfQHcwfhbSdeH3yX9OV3opLEqYmT37hWU+J
zCawYnxVESI0FtRzEXve9gdEWlrKKckrT/hp4mvxxOjvOkOSQBvy0elgUOqh6mEOZl+JnUbsR+Wm
CoZLE1eefMZy3FnVmyDNPv3JPXi88aLXMyimal0MYFkTiS4XJiGT3eAIMIbksehXY+eYi/KFpZWQ
GHpX+lG3UmiWWLwyPakFwKEHbrBc70AlJ2eV9g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j9nmCKgjPWNChPbpSW6EWLrMA6oCG2JGPoum8px09v0PEAh0DRXZi0J8HPzXUsZgOEMcKpA7X54u
YFcDDCLAQ+urha/eSPbQYHQh4yGCursxAQ1C6LEyNQ2wJ0eLlO2bJeAl/gof06zqsYVM2lLJVNv5
wao1k2bmgPdfpfY3c9vPD0fSMuZPS41EoRS0cQhO5GTZnKdjxm6tEUL3GnTjB8ynSCIbCJUsMtAX
4FRHNa52gudx5B5fagR+lXgFhE7e++rWTJELr7SYB+r5Es8qZLTpCH8TrQxEkV0rY/+e4sAjNE2D
gHw8GD7VcUtc15B8y1BbVmh29qc8Nd3V2i/miA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UkCD6I/Vye4qNoNoa3hIexBXG3xyKUJPAHAjIo7UcNVCDXpMQiYEtPDqExZMfiPlJn2nswCYIfIJ
FYWqMCloKSQyyI/7yZ2EtbyWEklb/P5IyZyvGi6hhFUo/JFTb12b4bK0gZPr+bCDdlVQKTx5GVHz
wptdUJO2omSj8axVMPbLRRtVzlJIZ29dTJ2ATXVXAcBxPnFfHRAMnYYKLeeLExX61vQvpqrkLQHm
XG7hpVzJi56gYKAzxa2BLq072OCVpVS70bfWlhlSTVcSlCrUf+EcarEk4FD8+Ih2NCvrqremG6yn
TtcBn8Xr8M/6zhOYvLi6AD6eArDMKA8n+Ccv8A==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
A5y5QVZU8yjPexRVPioSiAGohCHD5DX5FVobuMyhcgQRExLUhPvnnS8HOtxTj/2IapEcz68gFMGG
Hpi+m725u85/om/Vze9pGIW9Mn328Kz2FIg3W5EvGstfGwY+48LiAGAmTR269JS4lJGVYWYOz7Xk
S8cEsFd2m7j8iyKtARJzD90+UdXq/cIIh725jC9i8nbgxB364zddvm1Z/DF3JRw1qFp6GGcuRai1
KNcJ1j8c9wtIgktpsteU3e5+bxHEw8NT3gWXUFYjm00NDq97Jals8Jjktmum2nQxoF7ivPacfEey
gnSF6jRMkTsZObzc30hAhs0CEtc33hZLhPLHSn8pQ0WyvKJLHdd5s2yckgTZtqxC1Sbwe7WEgNXe
ZMX3pIkz+aoXsAL7GBLyVBMVQcyMoF0w8QGAaTe8sqatABwPqXidYRqNROTf62IYcMpV89XYgaTv
EwIn/oni9KOFd2BFVxRZbFGGC4IjvigsTBUijI+Dk6kVnDh240clGcc4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Omtp+lCaqUx7Z4qdFj2zrN8LpCkit2eX4hlMtig+ielGm/x4FSZkpjoFmiqdKFPi2eg0pg09MSai
XyGH68UzAR7Xrj8f1jlIoUmMKp4GcxfdqfTeuu7kWGOJEP6cvgTjSJFj2gawDv7f4yZcltnK2x0L
e4GW/rBTmGvZtKWb2ahjINLxPuh3dDaSaWdb+zVgbtyrI5FrjxBkq+aOxSjyNsqnCx1L0uWbxnkl
88NbXN3dTaECXHNm/fsleayM5hKis7kTv9BFajJMGy+BhQlmIYpE+F5zchnTTFUFJZCz1sX9Fc8e
HcY7irB8mR3ajdzjUZLBQEMktp096Nheq3U75A==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hpeBLwN9x2ZFDwroYLlUe5GjjDepHik2l0c2s3/6S7JPCRkzQSyt2V1Ad/JewAs/QNp5SXSbYYB4
rQl0My1LDMF3xw43r0g2IbcyHVpPhGp0W5msuQdF67afnsRv90iJYWLMI3QkYGCTWAzl4HrLxFSg
3z8XZRK670IcxznOrlvgHmIKsvubZrBkuc1EynrVb9Nw16QnIx2rc4WgcEXeFf+4i1RoYLDd3gXK
NFCNMdtaRYUThunFP6Z4ViZ5UnDmKq+IMhd31jTaqIlWOBDxPI1+v5RJYxIyTbn4rxlKR2fNbl5/
z4OUjBTd+1GH3I2OXlqmAOvIhpe2Z2HH7nZu/A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Mt2RhTSUwEIEWeNARbyL+EdfS1UF6nPaL/fKl/7oO2gina93egwCWDLl1fbBtkfaPco0cu4MJ9K3
OraAsyHRlY+MNShmJ1LzAIA1LjZx4y55lu9dlQqSUXR7AW7wVbkg1864mK+hM/1XygU0jvebKNW9
B7xSER+asLO6pxi0mt7uC2PHxLPAYEszFhmnap82TtbDGdQ2qtyekY+ngs+N2fAdsblxVwJruiMl
e6XJ127M8N1mYwhWU2HtRpBOSnnKoHgD9fG51XK/rhk8DxT66QnX9uLPB+H25eDupBJGi1Y5o6x8
hOwZiSUVlBLh7brfzevh7+eRn+7es6wBas0+3w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 53552)
`pragma protect data_block
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
bBxPpihamLOLzZVAWbS3biCk39QBCn2/KJwE24c=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
