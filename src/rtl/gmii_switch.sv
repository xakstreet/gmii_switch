`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: xakstreet
// 
// Create Date: 04/25/2019 02:44:58 PM
// Design Name: 
// Module Name: gmii_switch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------
//                  Demonstration				                       |
//                                                                     |
//                                                                     |
//                  --------------------------                         |
//                  |     gmii_switch_2x2    |                         |
//                  |                        |                         |
//                  |                        |                         |
//  Inner ports     |                        |      Outer_ports        |
//                  |                        |                         |
//gmii_rx_port_2<-------                  <--------gmii_rx_port_0      |
//gmii_tx_port_2------->                  -------->gmii_tx_port_0      |
//                  |                        |                         |
//                  |                        |                         |
//                  |                        |                         |
//                  |                        |                         |
//                  |                        |                         |
//                  |                        |                         |
//gmii_rx_port_3<------                  <--------gmii_rx_port_1       |
//gmii_tx_port_3------>                  -------->gmii_tx_port_1       |
//                  |                        |                         |
//                  |                        |                         |
//                  --------------------------                         |
//                                                                     |
//                                                                     |
//                                                                     |
//                                                                     |
//                                                                     |
//                                                                     |
//----------------------------------------------------------------------


import gmii_router_definitions::*;

module gmii_switch_2x2(
    input arp_table_clk,
    input clk_port0,
    input clk_port1,
    input clk_port2,
    input clk_port3,

  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
  (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *)
    input rst,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_0 RXD" *)
    input [7:0] gmii_rxd_0,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_0 RX_DV" *)
    input gmii_rx_dv_0,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_0 RX_ER" *)
    input gmii_rx_err_0,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_0 TXD" *)
    output [7:0] gmii_txd_0,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_0 TX_EN" *)
    output gmii_tx_dv_0,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_0 TX_ER" *)
    output gmii_tx_err_0,

  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_1 RXD" *)
    input [7:0] gmii_rxd_1,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_1 RX_DV" *)
    input gmii_rx_dv_1,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_1 RX_ER" *)
    input gmii_rx_err_1,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_1 TXD" *)
    output [7:0] gmii_txd_1,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_1 TX_EN" *)
    output gmii_tx_dv_1,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_1 TX_ER" *)
    output gmii_tx_err_1,

  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_2 RXD" *)
    output [7:0] gmii_rxd_2,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_2 RX_DV" *)
    output gmii_rx_dv_2,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_2 RX_ER" *)
    output gmii_rx_err_2,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_2 TXD" *)
    input [7:0] gmii_txd_2,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_2 TX_EN" *)
    input gmii_tx_dv_2,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_2 TX_ER" *)
    input gmii_tx_err_2,

  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_3 RXD" *)
    output [7:0] gmii_rxd_3,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_3 RX_DV" *)
    output gmii_rx_dv_3,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_3 RX_ER" *)
    output gmii_rx_err_3,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_3 TXD" *)
    input [7:0] gmii_txd_3,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_3 TX_EN" *)
    input gmii_tx_dv_3,
  (* X_INTERFACE_INFO = "xilinx.com:interface:gmii:1.0 gmii_port_3 TX_ER" *)
    input gmii_tx_err_3

    );

//data interface
(*keep = "true"*)gmii_interface [PORT_NUMBER-1:0] gmii_rxd_all;
assign gmii_rxd_all[0].data = gmii_rxd_0;
assign gmii_rxd_all[0].dv = gmii_rx_dv_0;
assign gmii_rxd_all[0].err = gmii_rx_err_0;
assign gmii_rxd_all[1].data = gmii_rxd_1;
assign gmii_rxd_all[1].dv = gmii_rx_dv_1;
assign gmii_rxd_all[1].err = gmii_rx_err_1;
assign gmii_rxd_all[2].data = gmii_txd_2;
assign gmii_rxd_all[2].dv = gmii_tx_dv_2;
assign gmii_rxd_all[2].err = gmii_tx_err_2;
assign gmii_rxd_all[3].data = gmii_txd_3;
assign gmii_rxd_all[3].dv = gmii_tx_dv_3;
assign gmii_rxd_all[3].err = gmii_tx_err_3;

wire [PORT_NUMBER-1:0] gmii_clocks = {clk_port3, clk_port2, clk_port1, clk_port0};

//mac info interface
(*keep = "true"*)mac_info_interface [PORT_NUMBER-1:0] mac_info;

initial begin
	for (int i = 0; i < PORT_NUMBER; i++) begin
		mac_info[i] = 'b0;		
	end
end
//main table
(*keep = "true"*)switch_table top_switch_table;

MAC_table_writer MAC_table_writer_inst(
    .clk(arp_table_clk),
    .rst(rst),
    .port_clocks(gmii_clocks),
    .mac_info(mac_info),
    .mac_table_out(top_switch_table)
    );

(*keep = "true"*)gmii_interface [PORT_NUMBER-1:0] gmii_rxd_all_after_router_port [PORT_NUMBER-1:0];
(*keep = "true"*)gmii_interface [PORT_NUMBER-1:0] gmii_rxd_all_after_MAC_src_parsing;

   genvar gi;
   generate
      for (gi=0; gi < PORT_NUMBER; gi=gi+1)
      begin: rx_port_deriv
		mac_source_parser mac_source_parser_inst(
				.clk(gmii_clocks[gi]),
				.info_MAC_out(mac_info[gi]),
				.gmii_rxd_in(gmii_rxd_all[gi]),
				.gmii_rxd_out(gmii_rxd_all_after_MAC_src_parsing[gi])
		    );
		gmii_router #(.THIS_PORT_ROUTING(gi)) gmii_router_inst
			(
				.clk(gmii_clocks[gi]),
				.rst(rst),
				.src_MAC_table(top_switch_table),
				.gmii_rxd_in(gmii_rxd_all_after_MAC_src_parsing[gi]),
				.gmii_rxd_out(gmii_rxd_all_after_router_port[gi])
		    );
      end
   endgenerate

gmii_interface gmii_tx_port_0;
assign gmii_txd_0 = gmii_tx_port_0.data;
assign gmii_tx_dv_0 = gmii_tx_port_0.dv;
assign gmii_tx_err_0 = gmii_tx_port_0.err;
gmii_data_combiner gmii_data_combiner_port0(
		.clk(gmii_clocks[0]),
		.rst(rst),
		.gmii_clocks({gmii_clocks[3], gmii_clocks[2], gmii_clocks[1]}),
		.gmii_input_interfaces({gmii_rxd_all_after_router_port[3][0], gmii_rxd_all_after_router_port[2][0], gmii_rxd_all_after_router_port[1][0]}),
		.gmii_output_interface(gmii_tx_port_0)
    );

gmii_interface gmii_tx_port_1;
assign gmii_txd_1 = gmii_tx_port_1.data;
assign gmii_tx_dv_1 = gmii_tx_port_1.dv;
assign gmii_tx_err_1 = gmii_tx_port_1.err;
gmii_data_combiner gmii_data_combiner_port1(
		.clk(gmii_clocks[1]),
		.rst(rst),
		.gmii_clocks({gmii_clocks[3], gmii_clocks[2], gmii_clocks[0]}),
		.gmii_input_interfaces({gmii_rxd_all_after_router_port[3][1], gmii_rxd_all_after_router_port[2][1], gmii_rxd_all_after_router_port[0][1]}),
		.gmii_output_interface(gmii_tx_port_1)
    );

gmii_interface gmii_rx_port_2;
assign gmii_rxd_2 = gmii_rx_port_2.data;
assign gmii_rx_dv_2 = gmii_rx_port_2.dv;
assign gmii_rx_err_2 = gmii_rx_port_2.err;
gmii_data_combiner gmii_data_combiner_port2(
		.clk(gmii_clocks[2]),
		.rst(rst),
		.gmii_clocks({gmii_clocks[3], gmii_clocks[1], gmii_clocks[0]}),
		.gmii_input_interfaces({gmii_rxd_all_after_router_port[3][2], gmii_rxd_all_after_router_port[1][2], gmii_rxd_all_after_router_port[0][2]}),
		.gmii_output_interface(gmii_rx_port_2)
    );

gmii_interface gmii_rx_port_3;
assign gmii_rxd_3 = gmii_rx_port_3.data;
assign gmii_rx_dv_3 = gmii_rx_port_3.dv;
assign gmii_rx_err_3 = gmii_rx_port_3.err;
gmii_data_combiner gmii_data_combiner_port3(
		.clk(gmii_clocks[3]),
		.rst(rst),
		.gmii_clocks({gmii_clocks[2], gmii_clocks[1], gmii_clocks[0]}),
		.gmii_input_interfaces({gmii_rxd_all_after_router_port[2][3], gmii_rxd_all_after_router_port[1][3], gmii_rxd_all_after_router_port[0][3]}),
		.gmii_output_interface(gmii_rx_port_3)
    );

endmodule
