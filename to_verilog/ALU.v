// File ./Stage3/ALUBlock/ALU.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module ALU(
input wire [N - 1:0] A,
input wire [N - 1:0] B,
input wire [2:0] ALU_OP,
output wire [N - 1:0] RES
);

parameter [31:0] N = 32;



wire en_ADD; wire en_ANDI; wire en_SRAI; wire en_XOR; wire ALU_OP_ABS;
wire [1:0] ALU_OP_MUX;
wire [31:0] enADD; wire [31:0] enANDI; wire [31:0] enXOR; wire [31:0] enSRAI; wire [31:0] outADD; wire [31:0] outAND; wire [31:0] outSRAI; wire [31:0] outXOR; wire [31:0] outInc; wire [31:0] outXOR_fin; wire [31:0] inpostxor;
wire [31:0] in1ADD; wire [31:0] in2ADD; wire [31:0] in1AND; wire [31:0] in2AND; wire [31:0] in1SRAI; wire [31:0] in1XOR; wire [31:0] in2XOR; wire [31:0] in2XOR_fin;
wire [4:0] in2SRAI; wire [4:0] B_srai; wire [4:0] enSRAI_B;
wire [31:0] in1_ADD; wire [31:0] in2_ADD; wire [31:0] out_ADD;
wire in2dec; wire selsign; wire sel_op;

  assign In2dec = ALU_OP[1] | (ALU_OP[2] & ALU_OP[0]);
  // IN ORDER TO ENABLE THE PROPER OPERATION
  Decoder2TO4 DECODER(
      ALU_OP[0],
    in2dec,
    en_ADD,
    en_ANDI,
    en_SRAI,
    en_XOR);

  assign enADD = {en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD,en_ADD};
  assign enANDI = {en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI,en_ANDI};
  assign enSRAI_B = {en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI};
  assign enSRAI = {en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI,en_SRAI};
  assign enXOR = {en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR,en_XOR};
  assign ALU_OP_MUX = {in2dec,ALU_OP[0]};
  assign ALU_OP_ABS = ALU_OP[2] &  ~(ALU_OP[1]) & ALU_OP[0];
  // IN ORDER TO SELECT THE PROPER ALU_OUTPUT
  mux4to1 #(
      .N(32))
  MUX_4TO1(
      outADD,
    outAND,
    outSRAI,
    outXOR_fin,
    ALU_OP_MUX,
    RES);

  // IN ORDER TO ENABLE THE INPUT FOR THE ADDER
  andBlock #(
      .N(32))
  AND_BLOCK_ADD_A(
      A,
    enADD,
    in1ADD);

  assign in1_ADD = in1ADD;
  andBlock #(
      .N(32))
  AND_BLOCK_ADD_B(
      B,
    enADD,
    in2ADD);

  assign in2_ADD = in2ADD;
  // IN ORDER TO ENABLE THE INPUT FOR THE AND
  andBlock #(
      .N(32))
  AND_BLOCK_AND_A(
      A,
    enANDI,
    in1AND);

  andBlock #(
      .N(32))
  AND_BLOCK_AND_B(
      B,
    enANDI,
    in2AND);

  // IN ORDER TO ENABLE THE INPUT FOR THE SRAI
  andBlock #(
      .N(32))
  AND_BLOCK_SRAI_A(
      A,
    enSRAI,
    in1SRAI);

  assign B_srai = B[4:0];
  andBlock #(
      .N(5))
  AND_BLOCK_SRAI_B(
      B_srai,
    enSRAI_B,
    in2SRAI);

  // IN ORDER TO ENABLE THE INPUT FOR THE XOR
  andBlock #(
      .N(32))
  AND_BLOCK_XOR_A(
      A,
    enXOR,
    in1XOR);

  andBlock #(
      .N(32))
  AND_BLOCK_XOR_B(
      B,
    enXOR,
    in2XOR);

  // AND BLOCK
  andBlock #(
      .N(32))
  AND_BLOCK(
      in1AND,
    in2AND,
    outAND);

  // SRAI BLOCK
  sraiBlock #(
      .N(32))
  SRAI_BLOCK(
      in1SRAI,
    in2SRAI,
    outSRAI);

  // XOR BLOCK
  xorBlock #(
      .N(32))
  XOR_BLOCK(
      in1XOR,
    in2XOR_fin,
    outXOR);

  //-ADD-SUB BLOCK
  adderSubALUNbit #(
      .N(32))
  ADD_SUB(
      in1_ADD,
    in2_ADD,
    ALU_OP[2],
    out_ADD);

  assign outADD = out_ADD;
  // PREPARE ABSOLUTE VALUE
  mux2to1Nbit #(
      .N(32))
  muxPreXor(
      in2XOR,
    32'b11111111111111111111111111111111,
    ALU_OP_ABS,
    in2XOR_fin);

  assign selsign =  ~(in1XOR[ + 1]) & ALU_OP_ABS;
  mux2to1Nbit #(
      .N(32))
  muxsign(
      outXOR,
    in1XOR,
    selsign,
    inpostxor);

  assign sel_op = selsign | ( ~(alu_OP[2]) & ALU_OP[1] & ALU_OP[0]);
  mux2to1Nbit #(
      .N(32))
  muxPostXor(
      outInc,
    inpostxor,
    sel_op,
    outXOR_fin);

  incrementerBlock #(
      .N(32))
  incBlock(
      outXOR,
    outInc);


endmodule
