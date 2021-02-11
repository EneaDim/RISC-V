// File ./Stage2/HazardUnit/HazardDetector.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module HazardDetector(
input wire ID_EX_RegWrite,
input wire EX_MEM_RegWrite,
input wire MEM_WB_RegWrite,
input wire instBEQ,
input wire instADDI,
input wire instLW,
input wire instANDI,
input wire instSRAI,
input wire instADD,
input wire instXOR,
input wire instSLT,
input wire instSW,
input wire instABS,
input wire clk,
input wire rst_n,
input wire [4:0] ADD1,
input wire [4:0] ADD2,
input wire [4:0] ID_EX_ADDRD,
input wire [4:0] EX_MEM_ADDRD,
input wire [4:0] MEM_WB_ADDRD,
output wire Mux_control,
output wire IF_ID_PCenable,
output wire IF_ID_INSTenable,
output wire PC_enable
);




wire verify_Add2; wire outcomp1; wire outcomp1_2; wire outcomp1_3; wire outcomp2; wire outcomp2_2; wire outcomp2_3; wire outadd2; wire outadd2_2; wire outadd2_3; wire same_reg; wire same_reg_2; wire same_reg_3; wire ffbobble3_out; wire bobble_3; wire bobble_2; wire ffbobble2_out; wire ffbobble2input; wire bobble_1; wire possibile_inst; wire LWplusinstruction; wire bobbleLW; wire bobbleout; wire instLWff;

  Comparator_Nbit #(
      .N(5))
  comp1(
      .RdAdd(ID_EX_ADDRD),
    .RsAdd(ADD1),
    .equality(outcomp1));

  Comparator_Nbit #(
      .N(5))
  comp2(
      .RdAdd(ID_EX_ADDRD),
    .RsAdd(ADD2),
    .equality(outcomp2));

  assign verify_Add2 = instBEQ | instADDI | instLW | instANDI | instSRAI | instADD | instXOR | instSLT | instABS;
  // instADD or instXOR or instSLT or instBEQ;
  assign outadd2 = outcomp2 & verify_Add2;
  assign same_reg = outcomp1 | outadd2;
  Comparator_Nbit #(
      .N(5))
  comp1_2(
      .RdAdd(EX_MEM_ADDRD),
    .RsAdd(ADD1),
    .equality(outcomp1_2));

  Comparator_Nbit #(
      .N(5))
  comp2_2(
      .RdAdd(EX_MEM_ADDRD),
    .RsAdd(ADD2),
    .equality(outcomp2_2));

  assign outadd2_2 = outcomp2_2 & verify_Add2;
  assign same_reg_2 = outcomp1_2 | outadd2_2;
  Comparator_Nbit #(
      .N(5))
  comp1_3(
      .RdAdd(MEM_WB_ADDRD),
    .RsAdd(ADD1),
    .equality(outcomp1_3));

  Comparator_Nbit #(
      .N(5))
  comp2_3(
      .RdAdd(MEM_WB_ADDRD),
    .RsAdd(ADD2),
    .equality(outcomp2_3));

  assign outadd2_3 = outcomp2_3 & verify_Add2;
  assign same_reg_3 = outcomp1_3 | outadd2_3;
  // BEQ caso delle 3 bolle 
  assign bobble_3 = instBEQ & ID_EX_RegWrite & same_reg;
  ff_en ffbobble3(
      clk,
    rst_n,
    1'b1,
    bobble_3,
    ffbobble3_out);

  //ffbobble3: ff con input bubble_3
  // BEQ caso delle 2 bolle
  assign bobble_2 = instBEQ & EX_MEM_RegWrite & same_reg_2;
  assign ffbobble2input = bobble_2 | ffbobble3_out;
  ff_en ffbobble2(
      clk,
    rst_n,
    1'b1,
    ffbobble2input,
    ffbobble2_out);

  // BEQ caso di 1 bolla
  assign bobble_1 = MEM_WB_RegWrite & instBEQ & same_reg_3;
  // LD + altra istruzione
  ff_en ffLW(
      clk,
    rst_n,
    1'b1,
    instLW,
    instLWff);

  assign possibile_inst = instADD | instADDI | instANDI | instSLT | instXOR | instSRAI | instLW | instSW | instABS;
  assign LWplusinstruction = instLWff & possibile_inst;
  assign bobbleLW = LWplusinstruction & same_reg;
  // OUT
  assign bobbleout = bobbleLW | bobble_1 | ffbobble2_out | ffbobble3_out | bobble_3;
  assign Mux_control = bobbleout;
  assign IF_ID_PCenable =  ~(bobbleout);
  assign IF_ID_INSTenable =  ~(bobbleout);
  assign PC_enable =  ~(bobbleout);

endmodule
