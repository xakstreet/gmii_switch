`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 06:46:49 PM
// Design Name: 
// Module Name: gmii_router
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

module gmii_router #(parameter THIS_PORT_ROUTING = 0)(
		input clk,
		input rst,
		input switch_table src_MAC_table,
		input gmii_interface gmii_rxd_in,
		output gmii_interface [PORT_NUMBER-1:0] gmii_rxd_out
    );
	localparam DELAY_DATA_VALUE = 7+1+6 +1 + 1;//+1 clock for start of packet detection + 1 for direction detection

	(*keep = "true"*)gmii_routed_interface [DELAY_DATA_VALUE-1:0] gmii_pipe;

	switch_table src_MAC_table_sync;
	always_ff @(posedge clk)
		src_MAC_table_sync <= src_MAC_table;


	always_ff @(posedge clk) begin
		gmii_pipe[0].gmii_flow <= gmii_rxd_in;
      for (int i=1; i < DELAY_DATA_VALUE; i++)
      begin: piplining_gmii
         gmii_pipe[i].gmii_flow <= gmii_pipe[i-1].gmii_flow;
      end		
	end

	wire [8*BYTE-1:0] detected_preamble;
	assign detected_preamble = {gmii_pipe[DELAY_DATA_VALUE-1-1 -1].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-1 -2].gmii_flow.data,
								gmii_pipe[DELAY_DATA_VALUE-1-1 -3].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-1 -4].gmii_flow.data,
								gmii_pipe[DELAY_DATA_VALUE-1-1 -5].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-1 -6].gmii_flow.data,
								gmii_pipe[DELAY_DATA_VALUE-1-1 -7].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-1 -8].gmii_flow.data};

	wire [6*BYTE-1:0] detected_MAC_dest;
	assign detected_MAC_dest = {gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -1].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -2].gmii_flow.data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -3].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -4].gmii_flow.data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -5].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -6].gmii_flow.data};

	wire [6*BYTE-1:0] detected_MAC_dest_pr_sh;
	assign detected_MAC_dest_pr_sh = {gmii_pipe[DELAY_DATA_VALUE-1-7-1-1].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -1].gmii_flow.data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -2].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -3].gmii_flow.data,
								gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -4].gmii_flow.data, gmii_pipe[DELAY_DATA_VALUE-1-7-1-1 -5].gmii_flow.data};



	reg [MAC_TABLE_SIZE-1:0] mac_compare [PORT_NUMBER-1:0];
	reg broadcast_detector=0;


	always @(posedge clk) begin 
		for (int i = 0; i < PORT_NUMBER; i++) begin
			for (int j = 0; j < MAC_TABLE_SIZE; j++) begin
				if(rst) begin
					mac_compare[i][j] <= 1'b1;
				end
				else begin 
					if (!gmii_pipe[DELAY_DATA_VALUE-1-1].gmii_flow.dv && gmii_pipe[DELAY_DATA_VALUE-2-1].gmii_flow.dv)begin//start of packet in pipe
						if(detected_preamble[2*BYTE-1:BYTE] == 8'hD5)begin//start of frame byte
							mac_compare[i][j] <= (&(~(detected_MAC_dest_pr_sh ^ src_MAC_table_sync.main_switch_table[i].mac_number_per_port[j]))) || (&detected_MAC_dest_pr_sh);//1 if mac in the table or it is broadcast
							if(&detected_MAC_dest_pr_sh) 
								broadcast_detector <= 1'b1;
							else
								broadcast_detector <= 1'b0;
						end
						else begin 
							mac_compare[i][j] <= (&(~(detected_MAC_dest ^ src_MAC_table_sync.main_switch_table[i].mac_number_per_port[j]))) || (&detected_MAC_dest);//1 if mac in the table or it is broadcast
							if(&detected_MAC_dest) 
								broadcast_detector <= 1'b1;
							else
								broadcast_detector <= 1'b0;
						end
					end
				end
			end
		end
	end

	always_ff @(posedge clk) begin
		for (int i = 0; i < PORT_NUMBER; i++) begin
			if(rst) begin
				for (int k = 0; k < DELAY_DATA_VALUE; k++) begin
					gmii_pipe[k].port_index <= '0;
					gmii_pipe[k].port_index[THIS_PORT_ROUTING] <= 1'b1;
				end
			end
			else begin 
				if(!gmii_pipe[DELAY_DATA_VALUE-1].gmii_flow.dv && gmii_pipe[DELAY_DATA_VALUE-2].gmii_flow.dv) begin
					for (int k = 0; k < DELAY_DATA_VALUE; k++) begin
						gmii_pipe[k].port_index[i] <= |mac_compare[i];
					end
				end			
				else begin
					gmii_pipe[0].port_index <= gmii_pipe[1].port_index;//continuing with previous direction
				end
			end
		end
	end


	always_ff @(posedge clk) begin
		if(broadcast_detector) begin//broadcast
			for (int i = 0; i < PORT_NUMBER; i++) begin
				if(i!=THIS_PORT_ROUTING) begin
					gmii_rxd_out[i] <= gmii_pipe[DELAY_DATA_VALUE-1].gmii_flow;
				end
				else begin
					gmii_rxd_out[i] <= '0;
				end
			end
		end
		else begin
			for (int i = 0; i < PORT_NUMBER; i++) begin
				if(i!=THIS_PORT_ROUTING) begin
					if(gmii_pipe[DELAY_DATA_VALUE-1].port_index[i]) begin
						gmii_rxd_out[i] <= gmii_pipe[DELAY_DATA_VALUE-1].gmii_flow;
					end
					else begin
						gmii_rxd_out[i] <= '0;
					end
				end
				else begin 
					gmii_rxd_out[i] <= '0;
				end
			end
		end
	end


endmodule
