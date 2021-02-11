// File ./Stage1/stage1.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module stage1(
input wire CLK,
input wire RSTN,
input wire EN_PC,
input wire EN_PIPE_PC,
input wire EN_PIPE_Instruction,
input wire selJump,
input wire [N - 3:0] loadValue,
input wire [N - 1:0] outMemInstruction,
input wire [N - 3:0] targetAddJump,
output wire [N - 1:0] outPC,
output wire [N - 1:0] outMemInstructionPipe,
output wire [N - 3:0] outPipeRegPC
);

parameter [31:0] N=32;
//(31 downto 0);--
//(29 downto 0);--
//(31 downto 0);--
//(31 downto 0);--(N-1 downto 0);


//(29 downto 0));--(N-3 downto 0));

wire [N - 3:0] targetAddress;  //(29 downto 0);--(N-3 downto 0); -- -1 -2 (lsb_bit)
wire [N - 3:0] targetAddressSeq;  //(29 downto 0);--(N-3 downto 0);
wire [N - 3:0] targetAddPC;  //(29 downto 0);--(N-3 downto 0);
wire [N - 3:0] out_PC;

  PC #(
      .N(30))
  ProgramCounter(
      CLK,
    RSTN,
    EN_PC,
    loadValue,
    targetAddress,
    targetAddPC);

  assign out_PC = targetAddPC;
  assign outPC = {out_PC,1'b0,1'b0};
  mux2to1Nbit #(
      .N(30))
  Mux(
      targetAddressSeq,
    targetAddJump,
    selJump,
    targetAddress);

  incrementerBlock #(
      .N(30))
  Incrementer(
      out_pc,
    targetAddressSeq);

  registerNbit #(
      .N(30))
  IF_ID_PC(
      CLK,
    RSTN,
    EN_PIPE_PC,
    out_pc,
    outPipeRegPC);

  registerNbit #(
      .N(32))
  IF_ID_instruction(
      CLK,
    RSTN,
    EN_PIPE_Instruction,
    outMemInstruction,
    outMemInstructionPipe);


endmodule
