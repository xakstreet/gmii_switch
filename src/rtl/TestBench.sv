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

//clock generation class
class clkParameters;
   int period = 8;
   rand int clk_pahse_delay [3:0];
   constraint phase_values { foreach (clk_pahse_delay[i]) {
                              clk_pahse_delay[i]<period && clk_pahse_delay[i]>=0;}}
endclass : clkParameters

//frame generation class and package
package frameTypePKG;
  typedef enum {BROADCAST_P=0, UNICAST_P=1} frameType;
endpackage
import frameTypePKG::*;
class frameParameters;
   typedef enum {BROADCAST_P=0, UNICAST_P=1} frameType;
   rand logic shrinked_preamble;
   rand int frame_length;
   rand frameType frame_type;
   constraint frame_length_constr {frame_length inside {[64:1500]};}
   constraint frameTypeConstr {
    frame_type dist {
      BROADCAST_P := 2,
      UNICAST_P := 8
    };
   }
endclass : frameParameters

//gmii interface
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

// //switch inner interfaces(generate acks on rxd lanes)
// interface gmii_interface_io_inner (input clk2, input clk3, gmii_interface_io.slave port2, gmii_interface_io.slave port3);
//   logic [47:0] port2_device_MAC = 48'h22AABBCCDDAA;
//   logic [47:0] port3_device_MAC = 48'h33AABBCCDDAA;

//   // modport  sendData(import send_frame);
//   // task send_frame(int data_size);
    
//   // endtask : send_frame
// endinterface: gmii_interface_io_inner



//switch inner interfaces(generate data on txd lanes)
interface gmii_interface_io_outer (input clk, gmii_interface_io.master port);
  frameParameters fT = new;
  modport  sendData(import send_rx_frame);
  task send_rx_frame(input logic [47:0] MAC_SRC_VAL, input logic [47:0] MAC_DST_VAL);
    $display("Shrinked = %d, Size = %d", fT.shrinked_preamble, fT.frame_length);
    port.rx_dv = 0;
    port.rx_err = 0;
    port.rxd = 8'h00;
    for(int i=0;i<12;i++)begin : send_interframe
      @(posedge clk);
      port.rx_dv = 0;
      port.rx_err = 0;
      port.rxd = 8'h55;
    end
    for(int i=0;i<(6+fT.shrinked_preamble);i++)begin : send_preamble
      @(posedge clk);
      port.rx_dv = 1;
      port.rx_err = 0;
      port.rxd = 8'h55;
    end
    @(posedge clk);//end of preamble
    port.rx_dv = 1;
    port.rx_err = 0;
    port.rxd = 8'hD5;
    for(int i=0;i<6;i++)begin : send_MAC_dst
      @(posedge clk);
      port.rx_dv = 1;
      port.rx_err = 0;
      if (fT.frame_type==BROADCAST_P) begin
        port.rxd = 8'hFF;
      end
      else begin 
        port.rxd = MAC_DST_VAL[i*8+:8];
      end
    end
    for(int i=0;i<6;i++)begin : send_MAC_src
      @(posedge clk);
      port.rx_dv = 1;
      port.rx_err = 0;
      port.rxd = MAC_SRC_VAL[i*8+:8];
    end
    for(int i=0;i<fT.frame_length;i++)begin : send_payload
      @(posedge clk);
      port.rx_dv = 1;
      port.rx_err = 0;
      port.rxd = $urandom();
    end
    @(posedge clk);//end of packet
    port.rx_dv = 0;
    port.rx_err = 0;
    port.rxd = 8'h55; 
  endtask : send_rx_frame
  



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
gmii_interface_io_outer gmii_flow_0(clk[0], gmii_interface_io_port0);
gmii_interface_io_outer gmii_flow_1(clk[1], gmii_interface_io_port1);

    
initial begin : sender_0
  @clk_start;//wait phase initialize
  gmii_flow_0.fT.randomize;
  gmii_flow_0.sendData.send_rx_frame(20,40);
end
initial begin : sender_1
  @clk_start;//wait phase initialize
  gmii_flow_1.fT.randomize;
  gmii_flow_1.fT.randomize;
  gmii_flow_1.sendData.send_rx_frame(20,40);
end


  gmii_switch_2x2 dut
       (
        .arp_table_clk(sys_clk),
        .clk_port0(clk[0]),
        .clk_port1(clk[1]),
        .clk_port2(clk[2]),
        .clk_port3(clk[3]),
        .rst(1'b0),

        .gmii_rxd_0   (),
        .gmii_rx_dv_0 (),
        .gmii_rx_err_0(),
        .gmii_txd_0   (),
        .gmii_tx_dv_0 (),
        .gmii_tx_err_0(),

        .gmii_rxd_1   (),
        .gmii_rx_dv_1 (),
        .gmii_rx_err_1(),
        .gmii_txd_1   (),
        .gmii_tx_dv_1 (),
        .gmii_tx_err_1(),

        .gmii_rxd_2   (),
        .gmii_rx_dv_2 (),
        .gmii_rx_err_2(),
        .gmii_txd_2   (),
        .gmii_tx_dv_2 (),
        .gmii_tx_err_2(),

        .gmii_rxd_3   (),
        .gmii_rx_dv_3 (),
        .gmii_rx_err_3(),
        .gmii_txd_3   (),
        .gmii_tx_dv_3 (),
        .gmii_tx_err_3()
        );    
        
    
endmodule : TestBench
