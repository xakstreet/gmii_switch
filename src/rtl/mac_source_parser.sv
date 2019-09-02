`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2019 02:33:53 PM
// Design Name: 
// Module Name: mac_source_parser
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

import gmii_router_definitions::*;

module mac_source_parser(
		input clk,
		output mac_info_interface info_MAC_out,
		input gmii_interface gmii_rxd_in,
		output gmii_interface gmii_rxd_out
    );

	localparam DELAY_DATA_VALUE = 7+1+6+6 +1;//+1 clock for start of packet detection

	gmii_interface [DELAY_DATA_VALUE-1:0] gmii_pipe;

	always_ff @(posedge clk) begin
		gmii_pipe[0] <= gmii_rxd_in;
      for (int i=1; i < DELAY_DATA_VALUE; i++)
      begin: piplining_gmii
         gmii_pipe[i] <= gmii_pipe[i-1];
      end		
	end

	wire [8*BYTE-1:0] detected_preamble;
	assign detected_preamble = {gmii_pipe[DELAY_DATA_VALUE-1-1].data, gmii_pipe[DELAY_DATA_VALUE-1-1 -1].data,
								gmii_pipe[DELAY_DATA_VALUE-1-1 -2].data, gmii_pipe[DELAY_DATA_VALUE-1-1 -3].data,
								gmii_pipe[DELAY_DATA_VALUE-1-1 -4].data, gmii_pipe[DELAY_DATA_VALUE-1-1 -5].data,
								gmii_pipe[DELAY_DATA_VALUE-1-1 -6].data, gmii_pipe[DELAY_DATA_VALUE-1-1 -7].data};


	wire [6*BYTE-1:0] detected_MAC_src;
	assign detected_MAC_src = {gmii_pipe[DELAY_DATA_VALUE-1-7-1 -7].data, gmii_pipe[DELAY_DATA_VALUE-1-7-1 -8].data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1 -9].data, gmii_pipe[DELAY_DATA_VALUE-1-7-1 -10].data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1 -11].data, gmii_pipe[DELAY_DATA_VALUE-1-7-1 -12].data};
	
	wire [6*BYTE-1:0] detected_MAC_src_pr_sh;//when preamble is shrinked
	assign detected_MAC_src_pr_sh = {gmii_pipe[DELAY_DATA_VALUE-1-7-1 -6].data, gmii_pipe[DELAY_DATA_VALUE-1-7-1 -7].data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1 -8].data, gmii_pipe[DELAY_DATA_VALUE-1-7-1 -9].data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1 -10].data, gmii_pipe[DELAY_DATA_VALUE-1-7-1 -11].data};


	always_ff @(posedge clk) begin//check port
		if(!gmii_pipe[DELAY_DATA_VALUE-1].dv && gmii_pipe[DELAY_DATA_VALUE-2].dv) begin//start of packet in pipe
			info_MAC_out.mac_valid <= 1'b1;
			if(detected_preamble[2*BYTE-1:BYTE] == 8'hD5)//start of frame byte
				info_MAC_out.mac_number_per_port <= detected_MAC_src_pr_sh;
			else
				info_MAC_out.mac_number_per_port <= detected_MAC_src;
		end
		else begin
			info_MAC_out.mac_valid <= 1'b0;
		end
	end

	always_ff @(posedge clk) begin 
		gmii_rxd_out <= gmii_pipe[DELAY_DATA_VALUE-1];
	end


endmodule
