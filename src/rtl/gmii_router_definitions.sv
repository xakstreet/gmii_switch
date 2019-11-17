`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 08:21:04 PM
// Design Name: 
// Module Name: gmii_router_definitions
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
package gmii_router_definitions;
	parameter MAC_TABLE_SIZE = 4;
	parameter PORT_NUMBER = 4;
	parameter BYTE = 8;
	parameter BROADCAST = 48'hFFFFFFFFFFFF;

	typedef struct packed {
		reg [6*BYTE-1:0] mac_number;
	} mac_val;

	typedef struct packed {
		mac_val [MAC_TABLE_SIZE-1:0] mac_number_per_port;
	} mac_val_per_port;

	typedef struct packed {
		reg [7:0] data;
		reg dv;
		reg err;
	} gmii_interface;

	typedef struct packed {
		gmii_interface gmii_flow;
		reg [PORT_NUMBER-1:0] port_index;
	} gmii_routed_interface;

	typedef struct packed {
		mac_val_per_port [PORT_NUMBER-1:0] main_switch_table ;
	} switch_table;
	///////////////////

	typedef struct packed {
		mac_val mac_number_per_port;
		reg mac_valid;
	} mac_info_interface;





endpackage