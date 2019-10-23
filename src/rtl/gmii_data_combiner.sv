`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2019 09:04:58 PM
// Design Name: 
// Module Name: gmii_data_combiner
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

module gmii_data_combiner(
		input clk,
		input rst,
		input [PORT_NUMBER-1-1:0] gmii_clocks,
		input gmii_interface [PORT_NUMBER-1-1:0] gmii_input_interfaces,
		output gmii_interface gmii_output_interface
    );

	gmii_interface [PORT_NUMBER-1-1:0] gmii_input_interfaces_d;
	gmii_interface [PORT_NUMBER-1-1:0] gmii_input_interfaces_dd;
	gmii_interface [PORT_NUMBER-1-1:0] gmii_input_interfaces_ddd;

	localparam MINIMUM_INTERFRAME_GAP = 12;

   genvar i;

   generate
	for (i = 0; i < PORT_NUMBER-1; i++) begin
		always @(posedge gmii_clocks[i])begin 
			gmii_input_interfaces_d[i] <= gmii_input_interfaces[i];
			gmii_input_interfaces_dd[i] <= gmii_input_interfaces_d[i];
			gmii_input_interfaces_ddd[i] <= gmii_input_interfaces_dd[i];
		end
	end
   endgenerate	

	reg [PORT_NUMBER-1-1:0] end_of_packet = '0;


	typedef struct packed {
		gmii_interface data;
		reg dv;
		reg ready;
		reg last;
	} axi_fifo_interface;

	axi_fifo_interface [PORT_NUMBER-1-1:0] buffered_frame;
   generate
	for (i = 0; i < PORT_NUMBER-1; i++) begin
		always @(posedge gmii_clocks[i])begin 
			if(~gmii_input_interfaces_d[i].dv & gmii_input_interfaces_dd[i].dv) begin//end of frame
				end_of_packet[i] <= 1'b1;
			end
			else begin 
				end_of_packet[i] <= 1'b0;
			end
		end
	end


	for (i=0; i < PORT_NUMBER-1; i=i+1)
	begin: generate_input_buffers
	 data_combiner_fifo input_buffer_fifo (
	  .m_aclk(clk),                // input wire m_aclk
	  .s_aclk(gmii_clocks[i]),                // input wire s_aclk
	  .s_aresetn(~rst),          // input wire s_aresetn
	  .s_axis_tvalid(gmii_input_interfaces_dd[i].dv || gmii_input_interfaces_ddd[i].dv),  // input wire s_axis_tvalid //write 1 byte at the end of the frame
	  .s_axis_tready(),  // output wire s_axis_tready
	  .s_axis_tdata(gmii_input_interfaces_dd[i]),    // input wire [15 : 0] s_axis_tdata
	  .s_axis_tlast(end_of_packet[i]),    // input wire s_axis_tlast
	  .m_axis_tvalid(buffered_frame[i].dv),  // output wire m_axis_tvalid
	  .m_axis_tready(buffered_frame[i].ready),  // input wire m_axis_tready
	  .m_axis_tdata(buffered_frame[i].data),    // output wire [15 : 0] m_axis_tdata
	  .m_axis_tlast(buffered_frame[i].last)    // output wire m_axis_tlast
	);
	end
   endgenerate	


   reg [7:0] idle_gap_counter = 0;
   (*keep = "true"*)enum logic [1:0] {IDLE = 2'b00,
                     READ_0_FIFO = 2'b01,
                     READ_1_FIFO = 2'b10,
                     READ_2_FIFO = 2'b11} switch_state;

   always @(posedge clk)begin
      if (rst) begin
         switch_state <= IDLE;
         gmii_output_interface <= '0;
         buffered_frame[0].ready <= 1'b0;
         buffered_frame[1].ready <= 1'b0;
         buffered_frame[2].ready <= 1'b0;
         idle_gap_counter <= '0;
      end
      else
         case (switch_state)
            IDLE : begin
		       buffered_frame[0].ready <= 1'b0;
		       buffered_frame[1].ready <= 1'b0;
		       buffered_frame[2].ready <= 1'b0;
               if (idle_gap_counter<MINIMUM_INTERFRAME_GAP-1)begin
                  switch_state <= IDLE;
                  idle_gap_counter <= idle_gap_counter + 1;
               end
               else begin 
               	if (buffered_frame[0].dv==1'b1)begin
                  switch_state <= READ_0_FIFO;
		          buffered_frame[0].ready <= 1'b1;
		          buffered_frame[1].ready <= 1'b0;
		          buffered_frame[2].ready <= 1'b0;
                end
               	else if (buffered_frame[1].dv==1'b1)begin
                  switch_state <= READ_1_FIFO;
		          buffered_frame[0].ready <= 1'b0;
		          buffered_frame[1].ready <= 1'b1;
		          buffered_frame[2].ready <= 1'b0;
                end
               	else if (buffered_frame[2].dv==1'b1)begin
                  switch_state <= READ_2_FIFO;
		          buffered_frame[0].ready <= 1'b0;
		          buffered_frame[1].ready <= 1'b0;
		          buffered_frame[2].ready <= 1'b1;
                end
              	else begin
              	  switch_state <= IDLE;
              	end
               end
               gmii_output_interface <= '0;
            end
            READ_0_FIFO : begin
              idle_gap_counter <= '0;
	          buffered_frame[0].ready <= 1'b1;
	          buffered_frame[1].ready <= 1'b0;
	          buffered_frame[2].ready <= 1'b0;
	          gmii_output_interface <= buffered_frame[0].data;
	          if(buffered_frame[0].last) begin
	            buffered_frame[0].ready <= 1'b0;
              	switch_state <= IDLE;
	          end
            end
            READ_1_FIFO : begin
              idle_gap_counter <= '0;
	          buffered_frame[0].ready <= 1'b0;
	          buffered_frame[1].ready <= 1'b1;
	          buffered_frame[2].ready <= 1'b0;
	          gmii_output_interface <= buffered_frame[1].data;
	          if(buffered_frame[1].last) begin
	            buffered_frame[1].ready <= 1'b0;
              	switch_state <= IDLE;
	          end
            end
            READ_2_FIFO : begin
              idle_gap_counter <= '0;
	          buffered_frame[0].ready <= 1'b0;
	          buffered_frame[1].ready <= 1'b0;
	          buffered_frame[2].ready <= 1'b1;
	          gmii_output_interface <= buffered_frame[2].data;
	          if(buffered_frame[2].last) begin
	            buffered_frame[2].ready <= 1'b0;
              	switch_state <= IDLE;
	          end
            end
         endcase
   end



endmodule
