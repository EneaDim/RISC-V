// File ./Stage3/Stage3.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module Stage3(
input wire IdEx_Regwrite,
input wire IdEx_MemRead,
input wire IdEx_MemWrite,
input wire IdEx_MemtoReg,
input wire IdEx_AluSrc,
input wire MemWb_RegwriteMuxStage,
input wire clk,
input wire rst_n,
input wire en_RdAdd,
input wire en_RS2bypass,
input wire en_ALUres,
input wire en_RegWrite,
input wire en_MemRead,
input wire en_MemWrite,
input wire en_MemtoReg,
input wire [2:0] IdEx_AluOp,
input wire [N - 1:0] IdEx_ReadData1,
input wire [N - 1:0] IdEx_ReadData2,
input wire [N - 1:0] IdEx_Immediate,
input wire [N - 1:0] ExMem_AluResult_Stage4,
input wire [N - 1:0] FinalMuxResult,
input wire [4:0] IdEx_Rs1Add,
input wire [4:0] IdEx_Rs2Add,
input wire [4:0] IdEx_RdAdd,
input wire [4:0] ExMem_RdAddStage4,
input wire [4:0] MemWb_RdAddMuxStage,
output wire ExMem_RegwriteStage3,
output wire ExMem_MemReadStage3,
output wire ExMem_MemWriteStage3,
output wire ExMem_MemtoRegStage3,
output wire [N - 1:0] ExMem_AluResult_Stage3,
output wire [N - 1:0] ExMem_ReadData2Bypass,
output wire [4:0] ExMem_RdAddStage3
);

parameter [31:0] N = 32;
//control signals in input
//data in input
//address of sources regs and of destination reg
//delayed control signals in output
//data in output


//delayed destination reg address

wire [1:0] ForwardA; wire [1:0] ForwardB;
wire [31:0] ALUOperand1; wire [31:0] ALUOperand2; wire [31:0] OutMuxImmORDataType; wire [31:0] ALUResult;
wire ExMemRegWrite;

  ForwardingUnit FU(
      MemWb_RegwriteMuxStage,
    ExMemRegWrite,
    MemWb_RdAddMuxStage,
    ExMem_RdAddStage4,
    IdEx_Rs1Add,
    IdEx_Rs2Add,
    ForwardA,
    ForwardB);

  ALU #(
      .N(32))
  EU(
      ALuOperand1,
    ALUOperand2,
    IdEx_AluOp,
    ALUResult);

  mux4to1 #(
      .N(32))
  MUXOperand1(
      IdEx_ReadData1,
    ExMem_AluResult_Stage4,
    FinalMuxResult,
    32'b00000000000000000000000000000000,
    ForwardA,
    AluOperand1);

  mux4to1 #(
      .N(32))
  MUXOperand2(
      outMuxImmORDataType,
    ExMem_AluResult_Stage4,
    FinalMuxResult,
    32'b00000000000000000000000000000100,
    ForwardB,
    AluOperand2);

  mux2to1Nbit #(
      .N(32))
  MUXImmORDataType(
      IdEx_Immediate,
    IdEx_ReadData2,
    IdEx_AluSrc,
    outMuxImmORDataType);

  registerNbit #(
      .N(5))
  ExMemRegRdAdd(
      clk,
    rst_n,
    en_RdAdd,
    IdEx_RdAdd,
    ExMem_RdAddStage3);

  registerNbit #(
      .N(32))
  ExMemRegRs2Bypass(
      clk,
    rst_n,
    en_RS2bypass,
    IdEx_ReadData2,
    ExMem_ReadData2Bypass);

  registerNbit #(
      .N(32))
  ExMemRegAluRes(
      clk,
    rst_n,
    en_ALUres,
    AluResult,
    ExMem_AluResult_Stage3);

  ff_en ExMemFFRegWrite(
      clk,
    rst_n,
    en_RegWrite,
    IdEx_Regwrite,
    ExMemRegwrite);

  assign ExMem_RegwriteStage3 = ExMemRegWrite;
  ff_en ExMemFFMemWrite(
      clk,
    rst_n,
    en_MemWrite,
    IdEx_Memwrite,
    ExMem_MemWriteStage3);

  ff_en ExMemFFMemRead(
      clk,
    rst_n,
    en_MemRead,
    IdEx_MemRead,
    ExMem_MemReadStage3);

  ff_en ExMemFFMemtoReg(
      clk,
    rst_n,
    en_MemtoReg,
    IdEx_MemtoReg,
    ExMem_MemtoRegStage3);


endmodule
