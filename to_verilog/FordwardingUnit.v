// File ./Stage3/FordwardingBlock/ForwardingUnit.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module ForwardingUnit(
input wire MemWbRegwrite,
input wire ExMemRegWrite,
input wire [4:0] MemWbRdAdd,
input wire [4:0] ExMemRdAdd,
input wire [4:0] IdExRs1Add,
input wire [4:0] IdExRs2Add,
output wire [1:0] ForwardA,
output wire [1:0] ForwardB
);

//signals that indicate the will to write in registers file
//sources and destinations regs addresses


//selection signal for ALU sources (indicate the needed to forwarded and if there is, from which stage)

wire MemWbRs1_Equal; wire MemWbRs2_Equal; wire ExMemRs1_Equal; wire ExMemRs2_Equal; wire MemWbRd_Null; wire ExMemRd_Null; wire MemWbRd_NotNull; wire ExMemRd_NotNull;

  Comparator_Nbit #(
      .N(5))
  COMP_MEMWbRdNull(
      MemWbRdAdd,
    5'b00000,
    MemWbRd_Null);

  assign MemWbRd_NotNull =  ~(MemWbRd_Null);
  Comparator_Nbit #(
      .N(5))
  COMP_ExMEMRdNull(
      ExMemRdAdd,
    5'b00000,
    ExMemRd_Null);

  assign ExMemRd_NotNull =  ~(ExMemRd_Null);
  Comparator_Nbit #(
      .N(5))
  COMP_IdExRs1EQUALTOMemWbRd(
      IdExRs1Add,
    MemWbRdAdd,
    MemWbRs1_Equal);

  Comparator_Nbit #(
      .N(5))
  COMP_IdExRs2EQUALTOMemWbRd(
      IdExRs2Add,
    MemWbRdAdd,
    MemWbRs2_Equal);

  Comparator_Nbit #(
      .N(5))
  COMP_IdExRs1EQUALTOExMemRd(
      IdExRs1Add,
    ExMemRdAdd,
    ExMemRs1_Equal);

  Comparator_Nbit #(
      .N(5))
  COMP_IdExRs2EQUALTOExMemRd(
      IdExRs2Add,
    ExMemRdAdd,
    ExMemRs2_Equal);

  GatesNet GatesNetMuxA(
      ExMemRegWrite,
    MemWbRegWrite,
    MemWbRd_NotNull,
    ExMemRd_NotNull,
    MemWbRs1_Equal,
    ExMemRs1_Equal,
    forwardA);

  GatesNet GatesNetMuxB(
      ExMemRegWrite,
    MemWbRegWrite,
    MemWbRd_NotNull,
    ExMemRd_NotNull,
    MemWbRs2_Equal,
    ExMemRs2_Equal,
    forwardB);


endmodule
