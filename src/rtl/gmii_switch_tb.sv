`timescale 1 ps/1 ps

module frame_typ;
   reg [7:0] data  [0:73];
   reg       valid [0:73];
   reg       error [0:73];

`define FRAME_TYP [8*74+74+74:1]

   reg `FRAME_TYP bits;

   function `FRAME_TYP tobits;
      input dummy;
      begin
      bits = {data[ 0],  data[ 1],  data[ 2],  data[ 3],  data[ 4],
              data[ 5],  data[ 6],  data[ 7],  data[ 8],  data[ 9],
              data[10],  data[11],  data[12],  data[13],  data[14],
              data[15],  data[16],  data[17],  data[18],  data[19],
              data[20],  data[21],  data[22],  data[23],  data[24],
              data[25],  data[26],  data[27],  data[28],  data[29],
              data[30],  data[31],  data[32],  data[33],  data[34],
              data[35],  data[36],  data[37],  data[38],  data[39],
              data[40],  data[41],  data[42],  data[43],  data[44],
              data[45],  data[46],  data[47],  data[48],  data[49],
              data[50],  data[51],  data[52],  data[53],  data[54],
              data[55],  data[56],  data[57],  data[58],  data[59],
              data[60],  data[61],  data[62],  data[63],  data[64],
              data[65],  data[66],  data[67],  data[68],  data[69],
              data[70],  data[71],  data[72],  data[73],

              valid[ 0], valid[ 1], valid[ 2], valid[ 3], valid[ 4],
              valid[ 5], valid[ 6], valid[ 7], valid[ 8], valid[ 9],
              valid[10], valid[11], valid[12], valid[13], valid[14],
              valid[15], valid[16], valid[17], valid[18], valid[19],
              valid[20], valid[21], valid[22], valid[23], valid[24],
              valid[25], valid[26], valid[27], valid[28], valid[29],
              valid[30], valid[31], valid[32], valid[33], valid[34],
              valid[35], valid[36], valid[37], valid[38], valid[39],
              valid[40], valid[41], valid[42], valid[43], valid[44],
              valid[45], valid[46], valid[47], valid[48], valid[49],
              valid[50], valid[51], valid[52], valid[53], valid[54],
              valid[55], valid[56], valid[57], valid[58], valid[59],
              valid[60], valid[61], valid[62], valid[63], valid[64],
              valid[65], valid[66], valid[67], valid[68], valid[69],
              valid[70], valid[71], valid[72], valid[73],

              error[ 0], error[ 1], error[ 2], error[ 3], error[ 4],
              error[ 5], error[ 6], error[ 7], error[ 8], error[ 9],
              error[10], error[11], error[12], error[13], error[14],
              error[15], error[16], error[17], error[18], error[19],
              error[20], error[21], error[22], error[23], error[24],
              error[25], error[26], error[27], error[28], error[29],
              error[30], error[31], error[32], error[33], error[34],
              error[35], error[36], error[37], error[38], error[39],
              error[40], error[41], error[42], error[43], error[44],
              error[45], error[46], error[47], error[48], error[49],
              error[50], error[51], error[52], error[53], error[54],
              error[55], error[56], error[57], error[58], error[59],
              error[60], error[61], error[62], error[63], error[64],
              error[65], error[66], error[67], error[68], error[69],
              error[70], error[71], error[72], error[73]};
      tobits = bits;
      end
   endfunction // tobits

   task frombits;
      input `FRAME_TYP frame;
      begin
      bits = frame;
             {data[ 0],  data[ 1],  data[ 2],  data[ 3],  data[ 4],
              data[ 5],  data[ 6],  data[ 7],  data[ 8],  data[ 9],
              data[10],  data[11],  data[12],  data[13],  data[14],
              data[15],  data[16],  data[17],  data[18],  data[19],
              data[20],  data[21],  data[22],  data[23],  data[24],
              data[25],  data[26],  data[27],  data[28],  data[29],
              data[30],  data[31],  data[32],  data[33],  data[34],
              data[35],  data[36],  data[37],  data[38],  data[39],
              data[40],  data[41],  data[42],  data[43],  data[44],
              data[45],  data[46],  data[47],  data[48],  data[49],
              data[50],  data[51],  data[52],  data[53],  data[54],
              data[55],  data[56],  data[57],  data[58],  data[59],
              data[60],  data[61],  data[62],  data[63],  data[64],
              data[65],  data[66],  data[67],  data[68],  data[69],
              data[70],  data[71],  data[72],  data[73],

              valid[ 0], valid[ 1], valid[ 2], valid[ 3], valid[ 4],
              valid[ 5], valid[ 6], valid[ 7], valid[ 8], valid[ 9],
              valid[10], valid[11], valid[12], valid[13], valid[14],
              valid[15], valid[16], valid[17], valid[18], valid[19],
              valid[20], valid[21], valid[22], valid[23], valid[24],
              valid[25], valid[26], valid[27], valid[28], valid[29],
              valid[30], valid[31], valid[32], valid[33], valid[34],
              valid[35], valid[36], valid[37], valid[38], valid[39],
              valid[40], valid[41], valid[42], valid[43], valid[44],
              valid[45], valid[46], valid[47], valid[48], valid[49],
              valid[50], valid[51], valid[52], valid[53], valid[54],
              valid[55], valid[56], valid[57], valid[58], valid[59],
              valid[60], valid[61], valid[62], valid[63], valid[64],
              valid[65], valid[66], valid[67], valid[68], valid[69],
              valid[70], valid[71], valid[72], valid[73],

              error[ 0], error[ 1], error[ 2], error[ 3], error[ 4],
              error[ 5], error[ 6], error[ 7], error[ 8], error[ 9],
              error[10], error[11], error[12], error[13], error[14],
              error[15], error[16], error[17], error[18], error[19],
              error[20], error[21], error[22], error[23], error[24],
              error[25], error[26], error[27], error[28], error[29],
              error[30], error[31], error[32], error[33], error[34],
              error[35], error[36], error[37], error[38], error[39],
              error[40], error[41], error[42], error[43], error[44],
              error[45], error[46], error[47], error[48], error[49],
              error[50], error[51], error[52], error[53], error[54],
              error[55], error[56], error[57], error[58], error[59],
              error[60], error[61], error[62], error[63], error[64],
              error[65], error[66], error[67], error[68], error[69],
              error[70], error[71], error[72], error[73]} = bits;
      end
   endtask // frombits

endmodule // frame_typ

// This module is the demonstration testbench
module demo_tb;


  //----------------------------------------------------------------------------
  // testbench signals
  //----------------------------------------------------------------------------
`define FRAME_TYP [8*74+74+74:1]


   frame_typ frame0();
   frame_typ frame1();
   frame_typ frame2();
   frame_typ frame3();

   frame_typ tx_stimulus_working_frame();
   frame_typ tx_monitor_working_frame();
   frame_typ rx_stimulus_working_frame();
   frame_typ rx_monitor_working_frame();

  initial
begin
  // Frame 0...
  frame0.data[0]  = 8'h55;  frame0.valid[0]  = 1'b1;  frame0.error[0]  = 1'b0; // Preamble
  frame0.data[1]  = 8'h55;  frame0.valid[1]  = 1'b1;  frame0.error[1]  = 1'b0;
  frame0.data[2]  = 8'h55;  frame0.valid[2]  = 1'b1;  frame0.error[2]  = 1'b0;
  frame0.data[3]  = 8'h55;  frame0.valid[3]  = 1'b1;  frame0.error[3]  = 1'b0;
  frame0.data[4]  = 8'h55;  frame0.valid[4]  = 1'b1;  frame0.error[4]  = 1'b0;
  frame0.data[5]  = 8'h55;  frame0.valid[5]  = 1'b1;  frame0.error[5]  = 1'b0;
  frame0.data[6]  = 8'h55;  frame0.valid[6]  = 1'b1;  frame0.error[6]  = 1'b0;
  frame0.data[7]  = 8'hd5;  frame0.valid[7]  = 1'b1;  frame0.error[7]  = 1'b0; // SFD
  frame0.data[8]  = 8'hFF;  frame0.valid[8]  = 1'b1;  frame0.error[8]  = 1'b0; // Destination Address (DA)
  frame0.data[9]  = 8'hFF;  frame0.valid[9]  = 1'b1;  frame0.error[9]  = 1'b0;
  frame0.data[10] = 8'hFF;  frame0.valid[10] = 1'b1;  frame0.error[10] = 1'b0;
  frame0.data[11] = 8'hFF;  frame0.valid[11] = 1'b1;  frame0.error[11] = 1'b0;
  frame0.data[12] = 8'hFF;  frame0.valid[12] = 1'b1;  frame0.error[12] = 1'b0;
  frame0.data[13] = 8'hFF;  frame0.valid[13] = 1'b1;  frame0.error[13] = 1'b0;
  frame0.data[14] = 8'h5a;  frame0.valid[14] = 1'b1;  frame0.error[14] = 1'b0; // Source Address  (5A)
  frame0.data[15] = 8'h02;  frame0.valid[15] = 1'b1;  frame0.error[15] = 1'b0;
  frame0.data[16] = 8'h03;  frame0.valid[16] = 1'b1;  frame0.error[16] = 1'b0;
  frame0.data[17] = 8'h04;  frame0.valid[17] = 1'b1;  frame0.error[17] = 1'b0;
  frame0.data[18] = 8'h05;  frame0.valid[18] = 1'b1;  frame0.error[18] = 1'b0;
  frame0.data[19] = 8'h06;  frame0.valid[19] = 1'b1;  frame0.error[19] = 1'b0;
  frame0.data[20] = 8'h00;  frame0.valid[20] = 1'b1;  frame0.error[20] = 1'b0;
  frame0.data[21] = 8'h2e;  frame0.valid[21] = 1'b1;  frame0.error[21] = 1'b0; // Length/Type = Length = 46
  frame0.data[22] = 8'h01;  frame0.valid[22] = 1'b1;  frame0.error[22] = 1'b0;
  frame0.data[23] = 8'h02;  frame0.valid[23] = 1'b1;  frame0.error[23] = 1'b0; // Data
  frame0.data[24] = 8'h03;  frame0.valid[24] = 1'b1;  frame0.error[24] = 1'b0;
  frame0.data[25] = 8'h04;  frame0.valid[25] = 1'b1;  frame0.error[25] = 1'b0;
  frame0.data[26] = 8'h05;  frame0.valid[26] = 1'b1;  frame0.error[26] = 1'b0;
  frame0.data[27] = 8'h06;  frame0.valid[27] = 1'b1;  frame0.error[27] = 1'b0;
  frame0.data[28] = 8'h07;  frame0.valid[28] = 1'b1;  frame0.error[28] = 1'b0;
  frame0.data[29] = 8'h08;  frame0.valid[29] = 1'b1;  frame0.error[29] = 1'b0;
  frame0.data[30] = 8'h09;  frame0.valid[30] = 1'b1;  frame0.error[30] = 1'b0;
  frame0.data[31] = 8'h0a;  frame0.valid[31] = 1'b1;  frame0.error[31] = 1'b0;
  frame0.data[32] = 8'h0b;  frame0.valid[32] = 1'b1;  frame0.error[32] = 1'b0;
  frame0.data[33] = 8'h0c;  frame0.valid[33] = 1'b1;  frame0.error[33] = 1'b0;
  frame0.data[34] = 8'h0d;  frame0.valid[34] = 1'b1;  frame0.error[34] = 1'b0;
  frame0.data[35] = 8'h0e;  frame0.valid[35] = 1'b1;  frame0.error[35] = 1'b0;
  frame0.data[36] = 8'h0f;  frame0.valid[36] = 1'b1;  frame0.error[36] = 1'b0;
  frame0.data[37] = 8'h10;  frame0.valid[37] = 1'b1;  frame0.error[37] = 1'b0;
  frame0.data[38] = 8'h11;  frame0.valid[38] = 1'b1;  frame0.error[38] = 1'b0;
  frame0.data[39] = 8'h12;  frame0.valid[39] = 1'b1;  frame0.error[39] = 1'b0;
  frame0.data[40] = 8'h13;  frame0.valid[40] = 1'b1;  frame0.error[40] = 1'b0;
  frame0.data[41] = 8'h14;  frame0.valid[41] = 1'b1;  frame0.error[41] = 1'b0;
  frame0.data[42] = 8'h15;  frame0.valid[42] = 1'b1;  frame0.error[42] = 1'b0;
  frame0.data[43] = 8'h16;  frame0.valid[43] = 1'b1;  frame0.error[43] = 1'b0;
  frame0.data[44] = 8'h17;  frame0.valid[44] = 1'b1;  frame0.error[44] = 1'b0;
  frame0.data[45] = 8'h18;  frame0.valid[45] = 1'b1;  frame0.error[45] = 1'b0;
  frame0.data[46] = 8'h19;  frame0.valid[46] = 1'b1;  frame0.error[46] = 1'b0;
  frame0.data[47] = 8'h1a;  frame0.valid[47] = 1'b1;  frame0.error[47] = 1'b0;
  frame0.data[48] = 8'h1b;  frame0.valid[48] = 1'b1;  frame0.error[48] = 1'b0;
  frame0.data[49] = 8'h1c;  frame0.valid[49] = 1'b1;  frame0.error[49] = 1'b0;
  frame0.data[50] = 8'h1d;  frame0.valid[50] = 1'b1;  frame0.error[50] = 1'b0;
  frame0.data[51] = 8'h1e;  frame0.valid[51] = 1'b1;  frame0.error[51] = 1'b0;
  frame0.data[52] = 8'h1f;  frame0.valid[52] = 1'b1;  frame0.error[52] = 1'b0;
  frame0.data[53] = 8'h20;  frame0.valid[53] = 1'b1;  frame0.error[53] = 1'b0;
  frame0.data[54] = 8'h21;  frame0.valid[54] = 1'b1;  frame0.error[54] = 1'b0;
  frame0.data[55] = 8'h22;  frame0.valid[55] = 1'b1;  frame0.error[55] = 1'b0;
  frame0.data[56] = 8'h23;  frame0.valid[56] = 1'b1;  frame0.error[56] = 1'b0;
  frame0.data[57] = 8'h24;  frame0.valid[57] = 1'b1;  frame0.error[57] = 1'b0;
  frame0.data[58] = 8'h25;  frame0.valid[58] = 1'b1;  frame0.error[58] = 1'b0;
  frame0.data[59] = 8'h26;  frame0.valid[59] = 1'b1;  frame0.error[59] = 1'b0;
  frame0.data[60] = 8'h27;  frame0.valid[60] = 1'b1;  frame0.error[60] = 1'b0;
  frame0.data[61] = 8'h28;  frame0.valid[61] = 1'b1;  frame0.error[61] = 1'b0;
  frame0.data[62] = 8'h29;  frame0.valid[62] = 1'b1;  frame0.error[62] = 1'b0;
  frame0.data[63] = 8'h2a;  frame0.valid[63] = 1'b1;  frame0.error[63] = 1'b0;
  frame0.data[64] = 8'h2b;  frame0.valid[64] = 1'b1;  frame0.error[64] = 1'b0;
  frame0.data[65] = 8'h2c;  frame0.valid[65] = 1'b1;  frame0.error[65] = 1'b0;
  frame0.data[66] = 8'h2d;  frame0.valid[66] = 1'b1;  frame0.error[66] = 1'b0;
  frame0.data[67] = 8'h2e;  frame0.valid[67] = 1'b1;  frame0.error[67] = 1'b0;
  frame0.data[68] = 8'h14;  frame0.valid[68] = 1'b1;  frame0.error[68] = 1'b0; // FCS field
  frame0.data[69] = 8'h19;  frame0.valid[69] = 1'b1;  frame0.error[69] = 1'b0;
  frame0.data[70] = 8'hd1;  frame0.valid[70] = 1'b1;  frame0.error[70] = 1'b0;
  frame0.data[71] = 8'hdd;  frame0.valid[71] = 1'b1;  frame0.error[71] = 1'b0;
  frame0.data[72] = 8'h00;  frame0.valid[72] = 1'b0;  frame0.error[72] = 1'b0;
  frame0.data[73] = 8'h00;  frame0.valid[73] = 1'b0;  frame0.error[73] = 1'b0;

  // frame 1...
  frame1.data[0]  = 8'h00;  frame1.valid[0]  = 1'b0;  frame1.error[0]  = 1'b0; // Preamble
  frame1.data[1]  = 8'h55;  frame1.valid[1]  = 1'b1;  frame1.error[1]  = 1'b0;
  frame1.data[2]  = 8'h55;  frame1.valid[2]  = 1'b1;  frame1.error[2]  = 1'b0;
  frame1.data[3]  = 8'h55;  frame1.valid[3]  = 1'b1;  frame1.error[3]  = 1'b0;
  frame1.data[4]  = 8'h55;  frame1.valid[4]  = 1'b1;  frame1.error[4]  = 1'b0;
  frame1.data[5]  = 8'h55;  frame1.valid[5]  = 1'b1;  frame1.error[5]  = 1'b0;
  frame1.data[6]  = 8'h55;  frame1.valid[6]  = 1'b1;  frame1.error[6]  = 1'b0;
  frame1.data[7]  = 8'hd5;  frame1.valid[7]  = 1'b1;  frame1.error[7]  = 1'b0; // SFD
  frame1.data[8]  = 8'h5a;  frame1.valid[8]  = 1'b1;  frame1.error[8]  = 1'b0; // Destination Address (DA)
  frame1.data[9]  = 8'h01;  frame1.valid[9]  = 1'b1;  frame1.error[9]  = 1'b0;
  frame1.data[10] = 8'h01;  frame1.valid[10] = 1'b1;  frame1.error[10] = 1'b0;
  frame1.data[11] = 8'h01;  frame1.valid[11] = 1'b1;  frame1.error[11] = 1'b0;
  frame1.data[12] = 8'h01;  frame1.valid[12] = 1'b1;  frame1.error[12] = 1'b0;
  frame1.data[13] = 8'h01;  frame1.valid[13] = 1'b1;  frame1.error[13] = 1'b0;
  frame1.data[14] = 8'hda;  frame1.valid[14] = 1'b1;  frame1.error[14] = 1'b0; // Source Address  (5A)
  frame1.data[15] = 8'h02;  frame1.valid[15] = 1'b1;  frame1.error[15] = 1'b0;
  frame1.data[16] = 8'h03;  frame1.valid[16] = 1'b1;  frame1.error[16] = 1'b0;
  frame1.data[17] = 8'h04;  frame1.valid[17] = 1'b1;  frame1.error[17] = 1'b0;
  frame1.data[18] = 8'h05;  frame1.valid[18] = 1'b1;  frame1.error[18] = 1'b0;
  frame1.data[19] = 8'h06;  frame1.valid[19] = 1'b1;  frame1.error[19] = 1'b0;
  frame1.data[20] = 8'h80;  frame1.valid[20] = 1'b1;  frame1.error[20] = 1'b0;
  frame1.data[21] = 8'h00;  frame1.valid[21] = 1'b1;  frame1.error[21] = 1'b0; // Length/Type = Length = 8000
  frame1.data[22] = 8'h01;  frame1.valid[22] = 1'b1;  frame1.error[22] = 1'b0;
  frame1.data[23] = 8'h02;  frame1.valid[23] = 1'b1;  frame1.error[23] = 1'b0; // Data
  frame1.data[24] = 8'h03;  frame1.valid[24] = 1'b1;  frame1.error[24] = 1'b0;
  frame1.data[25] = 8'h04;  frame1.valid[25] = 1'b1;  frame1.error[25] = 1'b0;
  frame1.data[26] = 8'h05;  frame1.valid[26] = 1'b1;  frame1.error[26] = 1'b0;
  frame1.data[27] = 8'h06;  frame1.valid[27] = 1'b1;  frame1.error[27] = 1'b0;
  frame1.data[28] = 8'h07;  frame1.valid[28] = 1'b1;  frame1.error[28] = 1'b0;
  frame1.data[29] = 8'h08;  frame1.valid[29] = 1'b1;  frame1.error[29] = 1'b0;
  frame1.data[30] = 8'h09;  frame1.valid[30] = 1'b1;  frame1.error[30] = 1'b0;
  frame1.data[31] = 8'h0a;  frame1.valid[31] = 1'b1;  frame1.error[31] = 1'b0;
  frame1.data[32] = 8'h0b;  frame1.valid[32] = 1'b1;  frame1.error[32] = 1'b0;
  frame1.data[33] = 8'h0c;  frame1.valid[33] = 1'b1;  frame1.error[33] = 1'b0;
  frame1.data[34] = 8'h0d;  frame1.valid[34] = 1'b1;  frame1.error[34] = 1'b0;
  frame1.data[35] = 8'h0e;  frame1.valid[35] = 1'b1;  frame1.error[35] = 1'b0;
  frame1.data[36] = 8'h0f;  frame1.valid[36] = 1'b1;  frame1.error[36] = 1'b0;
  frame1.data[37] = 8'h10;  frame1.valid[37] = 1'b1;  frame1.error[37] = 1'b0;
  frame1.data[38] = 8'h11;  frame1.valid[38] = 1'b1;  frame1.error[38] = 1'b0;
  frame1.data[39] = 8'h12;  frame1.valid[39] = 1'b1;  frame1.error[39] = 1'b0;
  frame1.data[40] = 8'h13;  frame1.valid[40] = 1'b1;  frame1.error[40] = 1'b0;
  frame1.data[41] = 8'h14;  frame1.valid[41] = 1'b1;  frame1.error[41] = 1'b0;
  frame1.data[42] = 8'h15;  frame1.valid[42] = 1'b1;  frame1.error[42] = 1'b0;
  frame1.data[43] = 8'h16;  frame1.valid[43] = 1'b1;  frame1.error[43] = 1'b0;
  frame1.data[44] = 8'h17;  frame1.valid[44] = 1'b1;  frame1.error[44] = 1'b0;
  frame1.data[45] = 8'h18;  frame1.valid[45] = 1'b1;  frame1.error[45] = 1'b0;
  frame1.data[46] = 8'h19;  frame1.valid[46] = 1'b1;  frame1.error[46] = 1'b0;
  frame1.data[47] = 8'h1a;  frame1.valid[47] = 1'b1;  frame1.error[47] = 1'b0;
  frame1.data[48] = 8'h1b;  frame1.valid[48] = 1'b1;  frame1.error[48] = 1'b0;
  frame1.data[49] = 8'h1c;  frame1.valid[49] = 1'b1;  frame1.error[49] = 1'b0;
  frame1.data[50] = 8'h1d;  frame1.valid[50] = 1'b1;  frame1.error[50] = 1'b0;
  frame1.data[51] = 8'h1e;  frame1.valid[51] = 1'b1;  frame1.error[51] = 1'b0;
  frame1.data[52] = 8'h1f;  frame1.valid[52] = 1'b1;  frame1.error[52] = 1'b0;
  frame1.data[53] = 8'h20;  frame1.valid[53] = 1'b1;  frame1.error[53] = 1'b0;
  frame1.data[54] = 8'h21;  frame1.valid[54] = 1'b1;  frame1.error[54] = 1'b0;
  frame1.data[55] = 8'h22;  frame1.valid[55] = 1'b1;  frame1.error[55] = 1'b0;
  frame1.data[56] = 8'h23;  frame1.valid[56] = 1'b1;  frame1.error[56] = 1'b0;
  frame1.data[57] = 8'h24;  frame1.valid[57] = 1'b1;  frame1.error[57] = 1'b0;
  frame1.data[58] = 8'h25;  frame1.valid[58] = 1'b1;  frame1.error[58] = 1'b0;
  frame1.data[59] = 8'h26;  frame1.valid[59] = 1'b1;  frame1.error[59] = 1'b0;
  frame1.data[60] = 8'h27;  frame1.valid[60] = 1'b1;  frame1.error[60] = 1'b0;
  frame1.data[61] = 8'h28;  frame1.valid[61] = 1'b1;  frame1.error[61] = 1'b0;
  frame1.data[62] = 8'h29;  frame1.valid[62] = 1'b1;  frame1.error[62] = 1'b0;
  frame1.data[63] = 8'h2a;  frame1.valid[63] = 1'b1;  frame1.error[63] = 1'b0;
  frame1.data[64] = 8'h2b;  frame1.valid[64] = 1'b1;  frame1.error[64] = 1'b0;
  frame1.data[65] = 8'h2c;  frame1.valid[65] = 1'b1;  frame1.error[65] = 1'b0;
  frame1.data[66] = 8'h2d;  frame1.valid[66] = 1'b1;  frame1.error[66] = 1'b0;
  frame1.data[67] = 8'h2e;  frame1.valid[67] = 1'b1;  frame1.error[67] = 1'b0;
  frame1.data[68] = 8'h2f;  frame1.valid[68] = 1'b1;  frame1.error[68] = 1'b0;
  frame1.data[69] = 8'h33;  frame1.valid[69] = 1'b1;  frame1.error[69] = 1'b0; // FCS field
  frame1.data[70] = 8'ha9;  frame1.valid[70] = 1'b1;  frame1.error[70] = 1'b0;
  frame1.data[71] = 8'haf;  frame1.valid[71] = 1'b1;  frame1.error[71] = 1'b0;
  frame1.data[72] = 8'h1d;  frame1.valid[72] = 1'b1;  frame1.error[72] = 1'b0;
  frame1.data[73] = 8'h00;  frame1.valid[73] = 1'b0;  frame1.error[73] = 1'b0;

  // frame 2...
  frame2.data[0]  = 8'h55;  frame2.valid[0]  = 1'b1;  frame2.error[0]  = 1'b0; // Preamble
  frame2.data[1]  = 8'h55;  frame2.valid[1]  = 1'b1;  frame2.error[1]  = 1'b0;
  frame2.data[2]  = 8'h55;  frame2.valid[2]  = 1'b1;  frame2.error[2]  = 1'b0;
  frame2.data[3]  = 8'h55;  frame2.valid[3]  = 1'b1;  frame2.error[3]  = 1'b0;
  frame2.data[4]  = 8'h55;  frame2.valid[4]  = 1'b1;  frame2.error[4]  = 1'b0;
  frame2.data[5]  = 8'h55;  frame2.valid[5]  = 1'b1;  frame2.error[5]  = 1'b0;
  frame2.data[6]  = 8'hd5;  frame2.valid[6]  = 1'b1;  frame2.error[6]  = 1'b0;
  frame2.data[7]  = 8'hFF;  frame2.valid[7]  = 1'b1;  frame2.error[7]  = 1'b0; // SFD
  frame2.data[8]  = 8'hFF;  frame2.valid[8]  = 1'b1;  frame2.error[8]  = 1'b0; // Destination Address (DA)
  frame2.data[9]  = 8'hFF;  frame2.valid[9]  = 1'b1;  frame2.error[9]  = 1'b0;
  frame2.data[10] = 8'hFF;  frame2.valid[10] = 1'b1;  frame2.error[10] = 1'b0;
  frame2.data[11] = 8'hFF;  frame2.valid[11] = 1'b1;  frame2.error[11] = 1'b0;
  frame2.data[12] = 8'hFF;  frame2.valid[12] = 1'b1;  frame2.error[12] = 1'b0;
  frame2.data[13] = 8'h00;  frame2.valid[13] = 1'b1;  frame2.error[13] = 1'b0;
  frame2.data[14] = 8'h5a;  frame2.valid[14] = 1'b1;  frame2.error[14] = 1'b0; // Source Address  (5A)
  frame2.data[15] = 8'h02;  frame2.valid[15] = 1'b1;  frame2.error[15] = 1'b0;
  frame2.data[16] = 8'h03;  frame2.valid[16] = 1'b1;  frame2.error[16] = 1'b0;
  frame2.data[17] = 8'h04;  frame2.valid[17] = 1'b1;  frame2.error[17] = 1'b0;
  frame2.data[18] = 8'h05;  frame2.valid[18] = 1'b1;  frame2.error[18] = 1'b0;
  frame2.data[19] = 8'h06;  frame2.valid[19] = 1'b1;  frame2.error[19] = 1'b0;
  frame2.data[20] = 8'h00;  frame2.valid[20] = 1'b1;  frame2.error[20] = 1'b0;
  frame2.data[21] = 8'h2e;  frame2.valid[21] = 1'b1;  frame2.error[21] = 1'b0; // Length/Type = Length = 46
  frame2.data[22] = 8'h01;  frame2.valid[22] = 1'b1;  frame2.error[22] = 1'b0;
  frame2.data[23] = 8'h02;  frame2.valid[23] = 1'b1;  frame2.error[23] = 1'b0; // Data
  frame2.data[24] = 8'h03;  frame2.valid[24] = 1'b1;  frame2.error[24] = 1'b0;
  frame2.data[25] = 8'h04;  frame2.valid[25] = 1'b1;  frame2.error[25] = 1'b0;
  frame2.data[26] = 8'h05;  frame2.valid[26] = 1'b1;  frame2.error[26] = 1'b0;
  frame2.data[27] = 8'h06;  frame2.valid[27] = 1'b1;  frame2.error[27] = 1'b0;
  frame2.data[28] = 8'h07;  frame2.valid[28] = 1'b1;  frame2.error[28] = 1'b0;
  frame2.data[29] = 8'h08;  frame2.valid[29] = 1'b1;  frame2.error[29] = 1'b0;
  frame2.data[30] = 8'h09;  frame2.valid[30] = 1'b1;  frame2.error[30] = 1'b0;
  frame2.data[31] = 8'h0a;  frame2.valid[31] = 1'b1;  frame2.error[31] = 1'b0;
  frame2.data[32] = 8'h0b;  frame2.valid[32] = 1'b1;  frame2.error[32] = 1'b0;
  frame2.data[33] = 8'h0c;  frame2.valid[33] = 1'b1;  frame2.error[33] = 1'b0;
  frame2.data[34] = 8'h0d;  frame2.valid[34] = 1'b1;  frame2.error[34] = 1'b0;
  frame2.data[35] = 8'h0e;  frame2.valid[35] = 1'b1;  frame2.error[35] = 1'b0;
  frame2.data[36] = 8'h0f;  frame2.valid[36] = 1'b1;  frame2.error[36] = 1'b0;
  frame2.data[37] = 8'h10;  frame2.valid[37] = 1'b1;  frame2.error[37] = 1'b0;
  frame2.data[38] = 8'h11;  frame2.valid[38] = 1'b1;  frame2.error[38] = 1'b0;
  frame2.data[39] = 8'h12;  frame2.valid[39] = 1'b1;  frame2.error[39] = 1'b0;
  frame2.data[40] = 8'h13;  frame2.valid[40] = 1'b1;  frame2.error[40] = 1'b0;
  frame2.data[41] = 8'h14;  frame2.valid[41] = 1'b1;  frame2.error[41] = 1'b0;
  frame2.data[42] = 8'h15;  frame2.valid[42] = 1'b1;  frame2.error[42] = 1'b0;
  frame2.data[43] = 8'h16;  frame2.valid[43] = 1'b1;  frame2.error[43] = 1'b0;
  frame2.data[44] = 8'h17;  frame2.valid[44] = 1'b1;  frame2.error[44] = 1'b0;
  frame2.data[45] = 8'h18;  frame2.valid[45] = 1'b1;  frame2.error[45] = 1'b0;
  frame2.data[46] = 8'h19;  frame2.valid[46] = 1'b1;  frame2.error[46] = 1'b0;
  frame2.data[47] = 8'h1a;  frame2.valid[47] = 1'b1;  frame2.error[47] = 1'b1; // Signal an Error
  frame2.data[48] = 8'h1b;  frame2.valid[48] = 1'b1;  frame2.error[48] = 1'b0;
  frame2.data[49] = 8'h1c;  frame2.valid[49] = 1'b1;  frame2.error[49] = 1'b0;
  frame2.data[50] = 8'h1d;  frame2.valid[50] = 1'b1;  frame2.error[50] = 1'b0;
  frame2.data[51] = 8'h1e;  frame2.valid[51] = 1'b1;  frame2.error[51] = 1'b0;
  frame2.data[52] = 8'h1f;  frame2.valid[52] = 1'b1;  frame2.error[52] = 1'b0;
  frame2.data[53] = 8'h20;  frame2.valid[53] = 1'b1;  frame2.error[53] = 1'b0;
  frame2.data[54] = 8'h21;  frame2.valid[54] = 1'b1;  frame2.error[54] = 1'b0;
  frame2.data[55] = 8'h22;  frame2.valid[55] = 1'b1;  frame2.error[55] = 1'b0;
  frame2.data[56] = 8'h23;  frame2.valid[56] = 1'b1;  frame2.error[56] = 1'b0;
  frame2.data[57] = 8'h24;  frame2.valid[57] = 1'b1;  frame2.error[57] = 1'b0;
  frame2.data[58] = 8'h25;  frame2.valid[58] = 1'b1;  frame2.error[58] = 1'b0;
  frame2.data[59] = 8'h26;  frame2.valid[59] = 1'b1;  frame2.error[59] = 1'b0;
  frame2.data[60] = 8'h27;  frame2.valid[60] = 1'b1;  frame2.error[60] = 1'b0;
  frame2.data[61] = 8'h28;  frame2.valid[61] = 1'b1;  frame2.error[61] = 1'b0;
  frame2.data[62] = 8'h29;  frame2.valid[62] = 1'b1;  frame2.error[62] = 1'b0;
  frame2.data[63] = 8'h2a;  frame2.valid[63] = 1'b1;  frame2.error[63] = 1'b0;
  frame2.data[64] = 8'h2b;  frame2.valid[64] = 1'b1;  frame2.error[64] = 1'b0;
  frame2.data[65] = 8'h2c;  frame2.valid[65] = 1'b1;  frame2.error[65] = 1'b0;
  frame2.data[66] = 8'h2d;  frame2.valid[66] = 1'b1;  frame2.error[66] = 1'b0;
  frame2.data[67] = 8'h2e;  frame2.valid[67] = 1'b1;  frame2.error[67] = 1'b0;
  frame2.data[68] = 8'h14;  frame2.valid[68] = 1'b1;  frame2.error[68] = 1'b0; // FCS field
  frame2.data[69] = 8'h19;  frame2.valid[69] = 1'b1;  frame2.error[69] = 1'b0;
  frame2.data[70] = 8'hd1;  frame2.valid[70] = 1'b1;  frame2.error[70] = 1'b0;
  frame2.data[71] = 8'hdd;  frame2.valid[71] = 1'b1;  frame2.error[71] = 1'b0;
  frame2.data[72] = 8'h00;  frame2.valid[72] = 1'b0;  frame2.error[72] = 1'b0;
  frame2.data[73] = 8'h00;  frame2.valid[73] = 1'b0;  frame2.error[73] = 1'b0;

  // frame 3...
  frame3.data[0]  = 8'h55;  frame3.valid[0]  = 1'b1;  frame3.error[0]  = 1'b0; // Preamble
  frame3.data[1]  = 8'h55;  frame3.valid[1]  = 1'b1;  frame3.error[1]  = 1'b0;
  frame3.data[2]  = 8'h55;  frame3.valid[2]  = 1'b1;  frame3.error[2]  = 1'b0;
  frame3.data[3]  = 8'h55;  frame3.valid[3]  = 1'b1;  frame3.error[3]  = 1'b0;
  frame3.data[4]  = 8'h55;  frame3.valid[4]  = 1'b1;  frame3.error[4]  = 1'b0;
  frame3.data[5]  = 8'h55;  frame3.valid[5]  = 1'b1;  frame3.error[5]  = 1'b0;
  frame3.data[6]  = 8'h55;  frame3.valid[6]  = 1'b1;  frame3.error[6]  = 1'b0;
  frame3.data[7]  = 8'hd5;  frame3.valid[7]  = 1'b1;  frame3.error[7]  = 1'b0; // SFD
  frame3.data[8]  = 8'h5a;  frame3.valid[8]  = 1'b1;  frame3.error[8]  = 1'b0; // Destination Address (DA)
  frame3.data[9]  = 8'h01;  frame3.valid[9]  = 1'b1;  frame3.error[9]  = 1'b0;
  frame3.data[10] = 8'h01;  frame3.valid[10] = 1'b1;  frame3.error[10] = 1'b0;
  frame3.data[11] = 8'h01;  frame3.valid[11] = 1'b1;  frame3.error[11] = 1'b0;
  frame3.data[12] = 8'h01;  frame3.valid[12] = 1'b1;  frame3.error[12] = 1'b0;
  frame3.data[13] = 8'h01;  frame3.valid[13] = 1'b1;  frame3.error[13] = 1'b0;
  frame3.data[14] = 8'hda;  frame3.valid[14] = 1'b1;  frame3.error[14] = 1'b0; // Source Address  (5A)
  frame3.data[15] = 8'h02;  frame3.valid[15] = 1'b1;  frame3.error[15] = 1'b0;
  frame3.data[16] = 8'h03;  frame3.valid[16] = 1'b1;  frame3.error[16] = 1'b0;
  frame3.data[17] = 8'h04;  frame3.valid[17] = 1'b1;  frame3.error[17] = 1'b0;
  frame3.data[18] = 8'h05;  frame3.valid[18] = 1'b1;  frame3.error[18] = 1'b0;
  frame3.data[19] = 8'h06;  frame3.valid[19] = 1'b1;  frame3.error[19] = 1'b0;
  frame3.data[20] = 8'h00;  frame3.valid[20] = 1'b1;  frame3.error[20] = 1'b0;
  frame3.data[21] = 8'h03;  frame3.valid[21] = 1'b1;  frame3.error[21] = 1'b0; // Length/Type = Length = 3
  frame3.data[22] = 8'h01;  frame3.valid[22] = 1'b1;  frame3.error[22] = 1'b0;  // Therefore padding is required
  frame3.data[23] = 8'h02;  frame3.valid[23] = 1'b1;  frame3.error[23] = 1'b0;
  frame3.data[24] = 8'h03;  frame3.valid[24] = 1'b1;  frame3.error[24] = 1'b0;
  frame3.data[25] = 8'h00;  frame3.valid[25] = 1'b1;  frame3.error[25] = 1'b0;  // Padding (uses zero value bytes)
  frame3.data[26] = 8'h00;  frame3.valid[26] = 1'b1;  frame3.error[26] = 1'b0;
  frame3.data[27] = 8'h00;  frame3.valid[27] = 1'b1;  frame3.error[27] = 1'b0;
  frame3.data[28] = 8'h00;  frame3.valid[28] = 1'b1;  frame3.error[28] = 1'b0;
  frame3.data[29] = 8'h00;  frame3.valid[29] = 1'b1;  frame3.error[29] = 1'b0;
  frame3.data[30] = 8'h00;  frame3.valid[30] = 1'b1;  frame3.error[30] = 1'b0;
  frame3.data[31] = 8'h00;  frame3.valid[31] = 1'b1;  frame3.error[31] = 1'b0;
  frame3.data[32] = 8'h00;  frame3.valid[32] = 1'b1;  frame3.error[32] = 1'b0;
  frame3.data[33] = 8'h00;  frame3.valid[33] = 1'b1;  frame3.error[33] = 1'b0;
  frame3.data[34] = 8'h00;  frame3.valid[34] = 1'b1;  frame3.error[34] = 1'b0;
  frame3.data[35] = 8'h00;  frame3.valid[35] = 1'b1;  frame3.error[35] = 1'b0;
  frame3.data[36] = 8'h00;  frame3.valid[36] = 1'b1;  frame3.error[36] = 1'b0;
  frame3.data[37] = 8'h00;  frame3.valid[37] = 1'b1;  frame3.error[37] = 1'b0;
  frame3.data[38] = 8'h00;  frame3.valid[38] = 1'b1;  frame3.error[38] = 1'b0;
  frame3.data[39] = 8'h00;  frame3.valid[39] = 1'b1;  frame3.error[39] = 1'b0;
  frame3.data[40] = 8'h00;  frame3.valid[40] = 1'b1;  frame3.error[40] = 1'b0;
  frame3.data[41] = 8'h00;  frame3.valid[41] = 1'b1;  frame3.error[41] = 1'b0;
  frame3.data[42] = 8'h00;  frame3.valid[42] = 1'b1;  frame3.error[42] = 1'b0;
  frame3.data[43] = 8'h00;  frame3.valid[43] = 1'b1;  frame3.error[43] = 1'b0;
  frame3.data[44] = 8'h00;  frame3.valid[44] = 1'b1;  frame3.error[44] = 1'b0;
  frame3.data[45] = 8'h00;  frame3.valid[45] = 1'b1;  frame3.error[45] = 1'b0;
  frame3.data[46] = 8'h00;  frame3.valid[46] = 1'b1;  frame3.error[46] = 1'b0;
  frame3.data[47] = 8'h00;  frame3.valid[47] = 1'b1;  frame3.error[47] = 1'b0;
  frame3.data[48] = 8'h00;  frame3.valid[48] = 1'b1;  frame3.error[48] = 1'b0;
  frame3.data[49] = 8'h00;  frame3.valid[49] = 1'b1;  frame3.error[49] = 1'b0;
  frame3.data[50] = 8'h00;  frame3.valid[50] = 1'b1;  frame3.error[50] = 1'b0;
  frame3.data[51] = 8'h00;  frame3.valid[51] = 1'b1;  frame3.error[51] = 1'b0;
  frame3.data[52] = 8'h00;  frame3.valid[52] = 1'b1;  frame3.error[52] = 1'b0;
  frame3.data[53] = 8'h00;  frame3.valid[53] = 1'b1;  frame3.error[53] = 1'b0;
  frame3.data[54] = 8'h00;  frame3.valid[54] = 1'b1;  frame3.error[54] = 1'b0;
  frame3.data[55] = 8'h00;  frame3.valid[55] = 1'b1;  frame3.error[55] = 1'b0;
  frame3.data[56] = 8'h00;  frame3.valid[56] = 1'b1;  frame3.error[56] = 1'b0;
  frame3.data[57] = 8'h00;  frame3.valid[57] = 1'b1;  frame3.error[57] = 1'b0;
  frame3.data[58] = 8'h00;  frame3.valid[58] = 1'b1;  frame3.error[58] = 1'b0;
  frame3.data[59] = 8'h00;  frame3.valid[59] = 1'b1;  frame3.error[59] = 1'b0;
  frame3.data[60] = 8'h00;  frame3.valid[60] = 1'b1;  frame3.error[60] = 1'b0;
  frame3.data[61] = 8'h00;  frame3.valid[61] = 1'b1;  frame3.error[61] = 1'b0;
  frame3.data[62] = 8'h00;  frame3.valid[62] = 1'b1;  frame3.error[62] = 1'b0;
  frame3.data[63] = 8'h00;  frame3.valid[63] = 1'b1;  frame3.error[63] = 1'b0;
  frame3.data[64] = 8'h00;  frame3.valid[64] = 1'b1;  frame3.error[64] = 1'b0;
  frame3.data[65] = 8'h00;  frame3.valid[65] = 1'b1;  frame3.error[65] = 1'b0;
  frame3.data[66] = 8'h00;  frame3.valid[66] = 1'b1;  frame3.error[66] = 1'b0;
  frame3.data[67] = 8'h00;  frame3.valid[67] = 1'b1;  frame3.error[67] = 1'b0;
  frame3.data[68] = 8'h73;  frame3.valid[68] = 1'b1;  frame3.error[68] = 1'b0; // FCS field
  frame3.data[69] = 8'h00;  frame3.valid[69] = 1'b1;  frame3.error[69] = 1'b0;
  frame3.data[70] = 8'h75;  frame3.valid[70] = 1'b1;  frame3.error[70] = 1'b0;
  frame3.data[71] = 8'h22;  frame3.valid[71] = 1'b1;  frame3.error[71] = 1'b0;
  frame3.data[72] = 8'h00;  frame3.valid[72] = 1'b0;  frame3.error[72] = 1'b0;
  frame3.data[73] = 8'h00;  frame3.valid[73] = 1'b0;  frame3.error[73] = 1'b0;

end

  // testbench control semaphores
  reg simulation_finished = 0;


  //----------------------------------------------------------------------------
  // DUT signals
  //----------------------------------------------------------------------------

  // An independent clock source used as the reference clock for an
  // IDELAYCTRL (if present) and for the main GT transceiver reset logic.
  // This example design assumes that this is of frequency 200MHz.
  reg  independent_clock;

  // GMII Interface
  //---------------
  reg [7:0] gmii_txd;
  reg gmii_tx_en;
  reg gmii_tx_er;

  reg rst;

  //----------------------------------------------------------------------------
  // Create clock sources
  //----------------------------------------------------------------------------
  initial
  begin
    independent_clock <= 1'b0;
    forever
    begin
      independent_clock <= 1'b0;
      #4000;
      independent_clock <= 1'b1;
      #4000;
    end
  end

  reg table_clk; 
  initial
  begin
    table_clk <= 1'b0;
    forever
    begin
      table_clk <= 1'b0;
      #40000;
      table_clk <= 1'b1;
      #40000;
    end
  end

  //----------------------------------------------------------------------------
  // Wire up Device Under Test
  //----------------------------------------------------------------------------
  gmii_switch_2x2 dut
     (
      .arp_table_clk(table_clk),
      .clk_port0(independent_clock),
      .clk_port1(independent_clock),
      .clk_port2(independent_clock),
      .clk_port3(independent_clock),
      .rst(rst),
      .gmii_rxd_0               (gmii_txd),
      .gmii_rx_dv_0             (gmii_tx_en),
      .gmii_rx_err_0             (gmii_tx_er),

      .gmii_rxd_1              (0),
      .gmii_rx_dv_1             (0),
      .gmii_rx_err_1             (0),

      .gmii_txd_2               (0),
      .gmii_tx_dv_2             (0),
      .gmii_tx_err_2             (0),

      .gmii_txd_3               (0),
      .gmii_tx_dv_3             (0),
      .gmii_tx_err_3             (0)
      );

  task tx_stimulus_send_frame;
    input   `FRAME_TYP frame;
    integer column_index;
    integer I;
  begin
    // import the frame into scratch space
    tx_stimulus_working_frame.frombits(frame);

    column_index = 0;
    gmii_txd   <= 8'h0;
    gmii_tx_en <= 1'b0;
    gmii_tx_er <= 1'b0;
    for (I = 0; I < 50; I = I + 1)   // delay to create Inter Packet Gap.
        @(posedge independent_clock);

    // loop over columns in frame.
    while (tx_stimulus_working_frame.valid[column_index] != 1'b0)
      begin
        gmii_txd   <= tx_stimulus_working_frame.data[column_index];
        gmii_tx_en <= tx_stimulus_working_frame.valid[column_index];
        gmii_tx_er <= tx_stimulus_working_frame.error[column_index];
        @(posedge independent_clock);        // wait for next clock tick
        column_index = column_index + 1;
      end

      // Clear the data lines.
      gmii_txd   <= 8'h0;
      gmii_tx_en <= 1'b0;
      gmii_tx_er <= 1'b0;

    for (I = 0; I < 12; I = I + 1)   // delay to create Inter Packet Gap.
        @(posedge independent_clock);

     end
  endtask // tx_stimulus_send_frame



  // loop over all the frames in the stimulus vector
  initial
  begin : p_tx_stimulus

    gmii_txd   <= 8'h00;
    gmii_tx_en <= 1'b0;
    gmii_tx_er <= 1'b0;

    rst <= 1'b1;
    $display("Reset core ... ");
    @(posedge independent_clock)
    @(posedge independent_clock)
    rst <= 1'b0;
    @(posedge independent_clock)


    // Wait for the configuration process to finish
//    wait (configuration_finished == 1);

    $display("Tx Stimulus: sending 4 frames ... ");

    // Transmit four frames through the GMII transmit interface.
    //      -- frame 0 = standard frame
    //      -- frame 1 = type frame
    //      -- frame 2 = frame containing an error
    //      -- frame 3 = standard frame with padding

    @(posedge independent_clock)
    tx_stimulus_send_frame(frame0.tobits(0));
    tx_stimulus_send_frame(frame1.tobits(0));
    tx_stimulus_send_frame(frame2.tobits(0));
    tx_stimulus_send_frame(frame3.tobits(0));


    tx_stimulus_send_frame(frame0.tobits(0));
    tx_stimulus_send_frame(frame1.tobits(0));
    tx_stimulus_send_frame(frame2.tobits(0));
    tx_stimulus_send_frame(frame3.tobits(0));

    simulation_finished = 1;
  end // p_tx_stimulus


  //----------------------------------------------------------------------------
  // End the simulation.
  //----------------------------------------------------------------------------

//  assign simulation_finished = tx_monitor_finished & rx_monitor_finished;


  initial
  begin : p_end_simulation
  fork: sim_in_progress
     @(posedge simulation_finished) disable sim_in_progress;
     #2000000000                     
     #2000000000                     
     #500000000                     
     disable sim_in_progress;
     
  join
  if (simulation_finished) begin
       #1000000
       $display("Test completed successfully");
       $display("Simulation Complete.");
  end
  else
     $display("** Error: Testbench timed out");
  $stop;
  end // p_end_simulation


endmodule
