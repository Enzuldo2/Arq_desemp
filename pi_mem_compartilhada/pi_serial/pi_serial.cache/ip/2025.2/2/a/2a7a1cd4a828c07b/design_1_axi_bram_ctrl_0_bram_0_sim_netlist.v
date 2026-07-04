// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Tue Jun 30 15:42:59 2026
// Host        : CP-DK-214509 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_axi_bram_ctrl_0_bram_0_sim_netlist.v
// Design      : design_1_axi_bram_ctrl_0_bram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_axi_bram_ctrl_0_bram_0,blk_mem_gen_v8_4_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_12,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_12 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 53408)
`pragma protect data_block
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
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
