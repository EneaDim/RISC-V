// File ./Stage2/RegisterFile/dec5to32.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2017 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

// no timescale needed

module dec5to32(
input wire [4:0] x,
input wire enable,
output wire [31:0] z
);




wire [7:0] enabledecoders;
wire enable1; wire enable2; wire enable3; wire enable4; wire enable5; wire enable6; wire enable7; wire enable8;
wire [2:0] ingresso1;
wire [1:0] ingressi2;
wire [3:0] out1; wire [3:0] out2; wire [3:0] out3; wire [3:0] out4; wire [3:0] out5; wire [3:0] out6; wire [3:0] out7; wire [3:0] out8;

  assign ingresso1 = x[4:2];
  assign ingressi2 = x[1:0];
  assign enable1 = enabledecoders[0];
  assign enable2 = enabledecoders[1];
  assign enable3 = enabledecoders[2];
  assign enable4 = enabledecoders[3];
  assign enable5 = enabledecoders[4];
  assign enable6 = enabledecoders[5];
  assign enable7 = enabledecoders[6];
  assign enable8 = enabledecoders[7];
  assign z[3:0] = out1;
  assign z[7:4] = out2;
  assign z[11:8] = out3;
  assign z[15:12] = out4;
  assign z[19:16] = out5;
  assign z[23:20] = out6;
  assign z[27:24] = out7;
  assign z[31:28] = out8;
  dec3to8 FIRSTDEC(
      .w(ingresso1),
    .y(enabledecoders),
    .enable(enable));

  dec2to4 DEC1(
      .w(ingressi2),
    .y(out1),
    .enable(enable1));

  dec2to4 DEC2(
      .w(ingressi2),
    .y(out2),
    .enable(enable2));

  dec2to4 DEC3(
      .w(ingressi2),
    .y(out3),
    .enable(enable3));

  dec2to4 DEC4(
      .w(ingressi2),
    .y(out4),
    .enable(enable4));

  dec2to4 DEC5(
      .w(ingressi2),
    .y(out5),
    .enable(enable5));

  dec2to4 DEC6(
      .w(ingressi2),
    .y(out6),
    .enable(enable6));

  dec2to4 DEC7(
      .w(ingressi2),
    .y(out7),
    .enable(enable7));

  dec2to4 DEC8(
      .w(ingressi2),
    .y(out8),
    .enable(enable8));


endmodule
