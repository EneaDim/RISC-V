// File ./Stage2/ImmediateGen/ImmediateGenerator.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module ImmediateGenerator(
input wire ADD,
input wire XORinst,
input wire SLT,
input wire AUIPC,
input wire LUI,
input wire ADDI,
input wire LW,
input wire ANDI,
input wire SRAI,
input wire BEQ,
input wire JAL,
input wire SW,
input wire ABSV,
input wire [31:0] instruction,
output wire [31:0] Immediate
);

//signals that indicate the instruction
//instruction sampled from the instruction memory


// SIGNED (31 DOWNTO 0)); --immediate value properly generated depending on the instruction in input

wire [31:0] imm;
wire [11:0] inst31_20; wire [11:0] imm31_20; wire [11:0] inst31exp11;
wire inst20; wire inst7; wire imm11; wire imm0;
wire [7:0] inst19_12; wire [7:0] imm19_12; wire [7:0] inst31exp8;
wire [5:0] inst30_25; wire [5:0] imm10_5;
wire [3:0] inst24_21; wire [3:0] inst11_8; wire [3:0] imm4_1;
wire Rtype; wire Utype; wire Itype; wire IbutnotSRAItype; wire SBtype; wire UJype; wire Stype;
wire sel31_20; wire sel19_12; wire sel10_5;
wire [1:0] sel11; wire [1:0] sel4_1; wire [1:0] sel0;

  assign inst31_20 = instruction[31:20];
  assign inst19_12 = instruction[19:12];
  assign inst30_25 = instruction[30:25];
  assign inst24_21 = instruction[24:21];
  assign inst11_8 = instruction[11:8];
  assign inst20 = instruction[20];
  assign inst7 = instruction[7];
  assign inst31exp8[7] = instruction[31];
  assign inst31exp8[6] = instruction[31];
  assign inst31exp8[5] = instruction[31];
  assign inst31exp8[4] = instruction[31];
  assign inst31exp8[3] = instruction[31];
  assign inst31exp8[2] = instruction[31];
  assign inst31exp8[1] = instruction[31];
  assign inst31exp8[0] = instruction[31];
  assign inst31exp11[7:0] = inst31exp8;
  assign inst31exp11[8] = instruction[31];
  assign inst31exp11[9] = instruction[31];
  assign inst31exp11[10] = instruction[31];
  assign inst31exp11[11] = instruction[31];
  FormatDetector FD(
      ADD,
    XOrinst,
    SLT,
    AUIPC,
    LUI,
    ADDI,
    LW,
    ANDI,
    SRAI,
    BEQ,
    JAL,
    SW,
    ABSV,
    Rtype,
    Utype,
    Itype,
    IbutnotSRAItype,
    SBtype,
    UJype,
    Stype);

  MUXSELGenerator MSG(
      Rtype,
    Utype,
    Itype,
    IbutnotSRAItype,
    SBtype,
    UJype,
    Stype,
    sel31_20,
    sel19_12,
    sel10_5,
    sel11,
    sel4_1,
    sel0);

  mux2to1Nbit #(
      .N(12))
  MUX30_20(
      inst31exp11,
    inst31_20,
    sel31_20,
    imm31_20);

  mux2to1Nbit #(
      .N(8))
  MUX19_12(
      inst31exp8,
    inst19_12,
    sel19_12,
    imm19_12);

  mux4to1 #(
      .N(4))
  MUX4_1(
      inst24_21,
    inst11_8,
    4'b0000,
    4'b0000,
    sel4_1,
    imm4_1);

  mux4to1_1bit MUX11(
      inst20,
    inst7,
    1'b0,
    instruction[31],
    sel11,
    imm11);

  mux2to1Nbit #(
      .N(6))
  MUX10_5(
      inst30_25,
    6'b000000,
    sel10_5,
    imm10_5);

  mux4to1_1bit MUX0(
      inst20,
    inst7,
    1'b0,
    1'b0,
    sel0,
    imm0);

  assign imm[31:20] = imm31_20;
  assign imm[19:12] = imm19_12;
  assign imm[11] = imm11;
  assign imm[10:5] = imm10_5;
  assign imm[4:1] = imm4_1;
  assign imm[0] = imm0;
  //immediate<=signed(imm);
  assign immediate = imm;

endmodule
