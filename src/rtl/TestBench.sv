`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 01:40:03 PM
// Design Name: 
// Module Name: TestBench
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

class clkParameters;
   int period = 8;
   rand int clk_pahse_delay [3:0];
   constraint phase_values { foreach (clk_pahse_delay[i]) {
                              clk_pahse_delay[i]<period && clk_pahse_delay[i]>=0;
                              }
                                }

endclass : clkParameters


interface gmii_interface_io ();
  logic [7:0] rxd;
  logic rx_dv;
  logic rx_err;
  logic [7:0] txd;
  logic tx_en;
  logic tx_err;
  modport master (input rxd, input rx_dv, input rx_err, output txd, output tx_en, output tx_err);
  modport slave  (output rxd, output rx_dv, output rx_err, input txd, input tx_en, input tx_err);
endinterface: gmii_interface_io

interface gmii_interface_io_inner (gmii_interface_io.slave port2, gmii_interface_io.slave port3);
  logic [47:0] port2_device_MAC = 48'h22AABBCCDDAA;
  logic [47:0] port3_device_MAC = 48'h33AABBCCDDAA;

  modport  sendData(import send_frame);
  task send_frame(int data_size);
  endtask : send_frame
endinterface: gmii_interface_io_inner

interface gmii_interface_io_outer (gmii_interface_io.master port0, gmii_interface_io.master port1);
  logic [47:0] port0_device_MAC = 48'h00AABBCCDDAA;
  logic [47:0] port1_device_MAC = 48'h11AABBCCDDAA;
  
  modport  sendData(import send_frame);
  task send_frame(int data_size);
  endtask : send_frame
endinterface: gmii_interface_io_outer


module TestBench(

    );


//clock generation
   logic sys_clk, clk[3:0];
   clkParameters clk_param = new();
   event sys_clk_start, clk_start;
   logic [3:0] clk_start_trg;
   initial begin
    assert (clk_param.randomize()) else $error("rand didn't work");
    $display("Phase delays:%p",clk_param.clk_pahse_delay);
    #10->clk_start;
   end

   initial begin
      sys_clk = 1'b0;
      @clk_start;//wait phase initialize
      forever begin
          sys_clk = #(clk_param.period/2) ~sys_clk;
      end
   end

   initial begin 
    clk_start_trg=0;
    @clk_start;//wait phase initialize
    fork
      for (int i = 0; i < 4; i++) begin
        clk_start_trg[i] = #(clk_param.clk_pahse_delay[i]) 1'b1;
      end
    join
   end

   genvar clk_inst;
   generate
       for (clk_inst=0; clk_inst < 4; clk_inst++)
       begin: clock_distrib
       always begin
          if (clk_start_trg[clk_inst]) begin
            clk[clk_inst] = 1'b0;
            #(clk_param.period/2) clk[clk_inst] = 1'b1;
            #(clk_param.period/2);
          end
          else
            #1 clk[clk_inst] = 1'b0;;
       end
       end
   endgenerate   

//dut instantiating   
gmii_interface_io gmii_interface_io_port0(); 
gmii_interface_io gmii_interface_io_port1(); 
gmii_interface_io gmii_interface_io_port2(); 
gmii_interface_io gmii_interface_io_port3(); 
gmii_interface_io_inner gmii_inner_flow(gmii_interface_io_port2, gmii_interface_io_port3);
gmii_interface_io_outer gmii_outer_flow(gmii_interface_io_port0, gmii_interface_io_port1);

    
  gmii_switch_2x2 dut
       (
        .arp_table_clk(sys_clk),
        .clk_port0(clk[0]),
        .clk_port1(clk[1]),
        .clk_port2(clk[2]),
        .clk_port3(clk[3]),
        .rst(1'b0),

        .gmii_rxd_0   (gmii_outer_flow.port0.rxd),
        .gmii_rx_dv_0 (gmii_outer_flow.port0.rx_dv),
        .gmii_rx_err_0(gmii_outer_flow.port0.rx_err),
        .gmii_txd_0   (gmii_outer_flow.port0.txd),
        .gmii_tx_dv_0 (gmii_outer_flow.port0.tx_en),
        .gmii_tx_err_0(gmii_outer_flow.port0.tx_err),

        .gmii_rxd_1   (gmii_outer_flow.port1.rxd),
        .gmii_rx_dv_1 (gmii_outer_flow.port1.rx_dv),
        .gmii_rx_err_1(gmii_outer_flow.port1.rx_err),
        .gmii_txd_1   (gmii_outer_flow.port1.txd),
        .gmii_tx_dv_1 (gmii_outer_flow.port1.tx_en),
        .gmii_tx_err_1(gmii_outer_flow.port1.rx_err),

        .gmii_rxd_2   (gmii_inner_flow.port2.rxd),
        .gmii_rx_dv_2 (gmii_inner_flow.port2.rx_dv),
        .gmii_rx_err_2(gmii_inner_flow.port2.rx_err),
        .gmii_txd_2   (gmii_inner_flow.port2.txd),
        .gmii_tx_dv_2 (gmii_inner_flow.port2.tx_en),
        .gmii_tx_err_2(gmii_inner_flow.port2.rx_err),

        .gmii_rxd_3   (gmii_inner_flow.port3.rxd),
        .gmii_rx_dv_3 (gmii_inner_flow.port3.rx_dv),
        .gmii_rx_err_3(gmii_inner_flow.port3.rx_err),
        .gmii_txd_3   (gmii_inner_flow.port3.txd),
        .gmii_tx_dv_3 (gmii_inner_flow.port3.tx_en),
        .gmii_tx_err_3(gmii_inner_flow.port3.rx_err)
        );    
    
endmodule : TestBench