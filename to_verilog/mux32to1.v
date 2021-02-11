// File ./Stage2/RegisterFile/mux32to1.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module mux32to1(
input wire [31:0] X1,
input wire [31:0] X2,
input wire [31:0] X3,
input wire [31:0] X4,
input wire [31:0] X5,
input wire [31:0] X6,
input wire [31:0] X7,
input wire [31:0] X8,
input wire [31:0] X9,
input wire [31:0] X10,
input wire [31:0] X11,
input wire [31:0] X12,
input wire [31:0] X13,
input wire [31:0] X14,
input wire [31:0] X15,
input wire [31:0] X16,
input wire [31:0] X17,
input wire [31:0] X18,
input wire [31:0] X19,
input wire [31:0] X20,
input wire [31:0] X21,
input wire [31:0] X22,
input wire [31:0] X23,
input wire [31:0] X24,
input wire [31:0] X25,
input wire [31:0] X26,
input wire [31:0] X27,
input wire [31:0] X28,
input wire [31:0] X29,
input wire [31:0] X30,
input wire [31:0] X31,
input wire [31:0] X32,
input wire [4:0] Sel,
output wire [31:0] Y
);




// istanzio il mux 64 to 1 usando 4 mux 8 to 1 (3 in parallelo all'inizio e uno in serie
wire [2:0] SEL1;
wire [1:0] SEL2;
wire [31:0] Y1; wire [31:0] Y2; wire [31:0] Y3; wire [31:0] Y4;

  assign SEL1 = SEL[2:0];
  assign SEL2 = SEL[4:3];
  MUX8_1 #(
      .N(32))
  Mux1(
      X1,
    X2,
    X3,
    X4,
    X5,
    X6,
    X7,
    X8,
    SEL1,
    Y1);

  MUX8_1 #(
      .N(32))
  Mux2(
      X9,
    X10,
    X11,
    X12,
    X13,
    X14,
    X15,
    X16,
    SEL1,
    Y2);

  MUX8_1 #(
      .N(32))
  Mux3(
      X17,
    X18,
    X19,
    X20,
    X21,
    X22,
    X23,
    X24,
    SEL1,
    Y3);

  MUX8_1 #(
      .N(32))
  Mux4(
      X25,
    X26,
    X27,
    X28,
    X29,
    X30,
    X31,
    X32,
    SEL1,
    Y4);

  mux4to1 #(
      .N(32))
  Muxfin(
      Y1,
    Y2,
    Y3,
    Y4,
    SEL2,
    Y);


endmodule
