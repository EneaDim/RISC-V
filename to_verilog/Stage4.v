// File ./Stage4/Stage4.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module Stage4(
input wire ExMem_Regwrite,
input wire ExMem_MemtoReg,
input wire ExMem_MemRead,
input wire ExMem_MemWrite,
input wire clk,
input wire rst_n,
input wire en_RdAdd,
input wire en_AluResbypass,
input wire en_ReadDataMem,
input wire en_MemtoReg,
input wire en_RegWrite,
input wire [N - 1:0] ExMem_AluResBypass,
input wire [N - 1:0] FromMem_ReadDataMem,
input wire [4:0] ExMem_RdAdd,
output wire MemWriteTOMem,
output wire EXMEMRegWrite,
output wire MemReadTOMem,
output wire MemWb_Regwrite,
output wire MemWb_MemtoReg,
output wire [N - 1:0] MemWb_ReadDataMem,
output wire [N - 1:0] MemWb_AluResBypass,
output wire [4:0] MemWb_RdAdd
);

parameter [31:0] N = 32;
//control signals in input
//data in input
//address of destination reg
//delayed control signals in output
//data in output


//delayed destination reg address


  assign MemReadTOMem = ExMem_MemRead;
  assign MemWriteTOMem = ExMem_MemWrite;
  registerNbit #(
      .N(5))
  MemWbRegRdAdd(
      clk,
    rst_n,
    en_RdAdd,
    ExMem_RdAdd,
    MemWb_RdAdd);

  registerNbit #(
      .N(32))
  MemWbRegAluResBypass(
      clk,
    rst_n,
    en_AluResbypass,
    ExMem_AluResbypass,
    MemWb_AluResBypass);

  registerNbit #(
      .N(32))
  ExMemRegReadDataMem(
      clk,
    rst_n,
    en_ReadDataMem,
    FromMem_ReadDataMem,
    MemWb_ReadDataMem);

  ff_en ExMemFFRegWrite(
      clk,
    rst_n,
    en_RegWrite,
    ExMem_Regwrite,
    MemWb_Regwrite);

  assign ExMEMRegWrite = ExMem_Regwrite;
  ff_en ExMemFFMemTOReg(
      clk,
    rst_n,
    en_MemtoReg,
    ExMem_MemtoReg,
    MemWb_MemtoReg);


endmodule
