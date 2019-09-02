`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2019 12:56:29 PM
// Design Name: 
// Module Name: MAC_table_writer
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

module MAC_table_writer(
    input clk,
    input rst,
    input [PORT_NUMBER-1:0] port_clocks,
    input mac_info_interface [PORT_NUMBER-1:0] mac_info,
    output switch_table mac_table
    );

	reg [MAC_TABLE_SIZE-1:0] mac_compare [PORT_NUMBER-1:0];
    mac_info_interface [PORT_NUMBER-1:0] mac_info_synced;


   genvar gen_var;
   generate
      for (gen_var=0; gen_var < PORT_NUMBER; gen_var=gen_var+1)
      begin
		mac_info_clock_converter mac_info_clock_converter_per_port (
		  .s_axis_aresetn(!rst),  // input wire s_axis_aresetn
		  .m_axis_aresetn(!rst),  // input wire m_axis_aresetn
		  .s_axis_aclk(port_clocks[gen_var]),        // input wire s_axis_aclk
		  .s_axis_tvalid(mac_info[gen_var].mac_valid),    // input wire s_axis_tvalid
		  .s_axis_tready(),    // output wire s_axis_tready
		  .s_axis_tdata(mac_info[gen_var].mac_number_per_port),      // input wire [47 : 0] s_axis_tdata
		  .m_axis_aclk(clk),        // input wire m_axis_aclk
		  .m_axis_tvalid(mac_info_synced[gen_var].mac_valid),    // output wire m_axis_tvalid
		  .m_axis_tready(1'b1),    // input wire m_axis_tready
		  .m_axis_tdata(mac_info_synced[gen_var].mac_number_per_port)      // output wire [47 : 0] m_axis_tdata
		);
      end
   endgenerate
			
			
	always @(posedge clk) begin 
		for (int i = 0; i < PORT_NUMBER; i++) begin
			for (int j = 0; j < MAC_TABLE_SIZE; j++) begin
				if(rst) begin
					mac_compare[i][j] <= 1'b1;
				end
				else begin 
					if (mac_info_synced[i].mac_valid)
						mac_compare[i][j] <= (&(~(mac_info_synced[i].mac_number_per_port ^ mac_table.main_switch_table[i].mac_number_per_port[j]))) || (&mac_info_synced[i].mac_number_per_port);//1 if mac in the table or it is broadcast
				end
			end
		end
	end

	mac_info_interface [PORT_NUMBER-1:0] mac_info_d = 'b0;
	always_ff @(posedge clk) begin
		mac_info_d <= mac_info_synced;
	end


	always_ff @(posedge clk) begin
		for (int i = 0; i < PORT_NUMBER; i++) begin
			if(rst) begin
				mac_table.main_switch_table[i].mac_number_per_port <= {MAC_TABLE_SIZE{BROADCAST}};
				// //for debug
				// if(i==2 || i==3) begin
				// 	mac_table.main_switch_table[i].mac_number_per_port <= {48'h5A0101010101, {(MAC_TABLE_SIZE-1){BROADCAST}}};
				// end
			end
			else begin 
				if(mac_info_d[i].mac_valid) begin
					if(|mac_compare[i]) begin//MAC is already in table
						//NOP
					end
					else begin //need to add MAC in table, shift macs to the left side
						mac_table.main_switch_table[i].mac_number_per_port <= {mac_table.main_switch_table[i].mac_number_per_port[MAC_TABLE_SIZE-2:0], mac_info_d[i].mac_number_per_port};
					end
				end			
			end
		end
	end

endmodule
