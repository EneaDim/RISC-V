// File ./Stage2/stage2.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module stage2(
input wire CLK,
input wire RSTN,
input wire EN,
input wire [N - 1:0] MemInstructionPipe,
input wire [N - 3:0] PCPipe,
input wire [4:0] AddRD_MemWb,
input wire [N - 1:0] ALURes_MemWb,
input wire [N - 1:0] MemData_MemWb,
input wire memToReg_MemWb,
input wire regWR_MemWb,
input wire regWR_ExMem,
input wire regWR_IdEx,
input wire [4:0] AddRD_ExMem,
output wire selJump,
output wire [N - 3:0] targetAddJump,
output wire [N - 1:0] outMux,
output wire [4:0] outAddRd_IdEx,
output wire [4:0] outAddRs2_IdEx,
output wire [4:0] outAddRs1_IdEx,
output wire [N - 1:0] outImmGen_IdEx,
output wire [N - 1:0] outDataRs2_IdEx,
output wire [N - 1:0] outData1_IdEx,
output wire outAluSrc_IdEx,
output wire [2:0] outAluOP_IdEx,
output wire outMemWR_IdEx,
output wire outMemRD_IdEx,
output wire outMemToReg_IdEx,
output wire outRegWR_IdEx,
output wire EN_IF_ID_PC,
output wire EN_IF_ID_INST,
output wire EN_PC
);

parameter [31:0] N = 32;
//, EN_AddRD,EN_AddRS2, EN_AddRS1, EN_Imm, EN_RS2, EN_RS1, EN_EX, EN_MEM, EN_WB : in std_logic ;
//memWr_IdEx: in std_logic;
//memRd_IdEx: in std_logic;
//memWr_ExMem : in std_logic;
//memRd_ExMem : in std_logic;
//AddRD_IdEx : in std_logic_vector(4 downto 0);



wire zero; wire outXor;
wire [31:0] RS1; wire [31:0] RS2;
wire beqOk;
wire addOK;
wire addiOK;
wire sltOK;
wire auipcOK;
wire luiOK;
wire sraiOK;
wire andiOK;
wire xorOK;
wire jalOK;
wire lwOK;
wire swOK; wire absOK;
wire [31:0] immediateValue;
wire [29:0] immediate_Value;
wire [29:0] target_AddJump;
wire [31:0] dataWb;
wire branch;
wire alu_src;
wire [2:0] alu_op;
wire mem_wr;
wire mem_rd;
wire mem_to_reg;
wire reg_wr;
wire [7:0] controlSignals;
wire controlRS1in;
wire controlRS1out;
wire [4:0] targetRS1; wire [4:0] outAddRDIdEx;
wire [31:0] RS1inPipe;
wire [31:0] PC_Pipe;
wire [29:0] PC_Pipe_s;
wire EN_AddRD; wire EN_AddRS2; wire EN_AddRS1; wire EN_Imm; wire EN_RS2; wire EN_RS1; wire EN_EX; wire EN_MEM; wire EN_WB;
wire beq; wire mux_Control; wire en_jump; wire en_Eq;
wire [29:0] in_en_A; wire [29:0] in_en_B; wire [29:0] en_jump_a; wire [29:0] en_jump_b;
wire [31:0] in_en_rs1; wire [31:0] in_en_rs2; wire [31:0] en_xor_rs1; wire [31:0] en_xor_rs2;
// MANCA INGRESSO 'ZERO'

  assign en_jump = branch | jalOK;
  assign en_Eq = beqOK;
  assign en_jump_a = {en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump};
  assign en_jump_b = {en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump,en_jump};
  assign en_xor_rs1 = {en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq};
  assign en_xor_rs2 = {en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq,en_Eq};
  mux2to1Nbit #(
      .N(32))
  MuxWB(
      ALURes_MemWb,
    MemData_MemWb,
    memToReg_MemWb,
    dataWB);

  assign outMux = dataWB;
  andBlock #(
      .N(32))
  andBlockEqRs1(
      RS1,
    en_xor_rs1,
    in_en_rs1);

  andBlock #(
      .N(32))
  andBlockEqRs2(
      RS2,
    en_xor_rs2,
    in_en_rs2);

  Comparator_Nbit #(
      .N(32))
  ComparatorBlock(
      in_en_rs1,
    in_en_rs2,
    outXor);

  assign zero = outXor;
  assign selJump = branch;
  ImmediateGenerator ImmediateBlock(
      addOK,
    xorOK,
    sltOK,
    auipcOK,
    luiOK,
    addiOK,
    lwOK,
    andiOK,
    sraiOK,
    beqOK,
    jalOK,
    swOK,
    absOK,
    MemInstructionPipe,
    immediateValue);

  andBlock #(
      .N(30))
  andBlockJumpA(
      immediateValue[31:2],
    en_jump_a,
    in_en_A);

  andBlock #(
      .N(30))
  andBlockJumpB(
      PCPIPE,
    en_jump_b,
    in_en_B);

  assign immediate_Value = in_en_A;
  assign PC_Pipe_s = in_en_B;
  adderSubNbit #(
      .N(30))
  adderBlock(
      PC_Pipe_s,
    immediate_Value,
    target_AddJump);

  assign targetAddJump = target_AddJump;
  //non faccio il *2?? oppure si?? boh
  // manca blocco XOR per fare la SUB
  mux2to1Nbit #(
      .N(5))
  MuxIn1Reg(
      MemInstructionPipe[19:15],
    5'b00000,
    controlRS1in,
    targetRS1);

  REGISTERS_mainblock RegisterBlock(
      CLK,
    RSTN,
    regWR_MemWb,
    targetRS1,
    MemInstructionPipe[24:20],
    AddRD_MemWb,
    dataWb,
    RS1,
    RS2);

  assign PC_Pipe = {PCPipe,1'b0,1'b0};
  mux2to1Nbit #(
      .N(32))
  MuxRS1(
      RS1,
    PC_Pipe,
    controlRS1out,
    RS1inPipe);

  assign controlSignals = {alu_src,alu_op[2],alu_op[1],alu_op[0],mem_wr,mem_rd,mem_to_reg,reg_wr};
  ControlUnit ControlUnitBlock(
      MemInstructionPipe[6:0],
    MemInstructionPipe[14:12],
    MemInstructionPipe[31:25],
    zero,
    beqOk,
    addOK,
    addiOK,
    sltOK,
    auipcOK,
    luiOK,
    jalOK,
    sraiOK,
    andiOK,
    xorOK,
    lwOK,
    swOK,
    absOK,
    branch,
    alu_src,
    alu_op,
    mem_wr,
    mem_rd,
    mem_to_reg,
    reg_wr,
    controlRS1in,
    controlRS1out);

  //controlSignals <=  ( alu_src & alu_op(2) & alu_op &  mem_wr &  mem_rd &  mem_to_reg &  reg_wr);
  assign outAddRD_IdEx = outAddRDIdEx;
  HazardDetector HazardDetectorBlock(
      regWR_IdEx,
    regWR_ExMem,
    regWr_MemWb,
    beqOK,
    addiOK,
    lwOK,
    andiOK,
    sraiOK,
    addOK,
    xorOK,
    sltOK,
    swOK,
    absOK,
    CLK,
    RSTN,
    MemInstructionPipe[19:15],
    MemInstructionPipe[24:20],
    outAddRDIdEx,
    AddRD_ExMem,
    AddRD_MemWb,
    mux_Control,
    EN_IF_ID_PC,
    EN_IF_ID_INST,
    EN_PC);

  //  MuxControl : mux2to1Nbit generic map (N=>8) port map ( controlSignals, "00000000", mux_Control, controlSignalsPipe);
  assign EN_AddRD = en;
  // and not(beqOK);
  assign EN_AddRS2 = en;
  // and not(beqOK);
  assign EN_AddRS1 = en;
  // and not(beqOK);
  assign EN_Imm = en;
  // and not(beqOK);
  assign EN_RS2 = en;
  // and not(beqOK);
  assign EN_RS1 = en;
  // and not(beqOK);
  assign EN_EX = en;
  // and not(beq);
  assign EN_MEM = en;
  // and not(beq);
  assign EN_WB = en;
  // and not(beq);
  registerNbit #(
      .N(5))
  ID_EX_AddRD(
      CLK,
    RSTN,
    EN_AddRD,
    MemInstructionPipe[11:7],
    outAddRdIdEx);

  registerNbit #(
      .N(5))
  ID_EX_AddRS1(
      CLK,
    RSTN,
    EN_AddRS1,
    MemInstructionPipe[19:15],
    outAddRs1_IdEx);

  registerNbit #(
      .N(5))
  ID_EX_AddRS2(
      CLK,
    RSTN,
    EN_AddRS2,
    MemInstructionPipe[24:20],
    outAddRS2_IdEx);

  registerNbit #(
      .N(32))
  ID_EX_Imm(
      CLK,
    RSTN,
    EN_Imm,
    immediateValue,
    outImmGen_IdEx);

  registerNbit #(
      .N(32))
  ID_EX_RS2(
      CLK,
    RSTN,
    EN_RS2,
    RS2,
    outDataRS2_IdEx);

  registerNbit #(
      .N(32))
  ID_EX_RS1(
      CLK,
    RSTN,
    EN_RS1,
    RS1inPipe,
    outData1_IdEx);

  ff_en ID_EX_AluSrc(
      CLK,
    RSTN,
    EN_EX,
    controlSignals[7],
    outAluSrc_IdEx);

  registerNbit #(
      .N(3))
  ID_EX_AluOP(
      CLK,
    RSTN,
    EN_EX,
    controlSignals[6:4],
    outAluOP_IdEx);

  ff_en ID_EX_MemWR(
      CLK,
    RSTN,
    EN_MEM,
    controlSignals[3],
    outMemWR_IdEx);

  ff_en ID_EX_MemRD(
      CLK,
    RSTN,
    EN_MEM,
    controlSignals[2],
    outMemRD_IdEx);

  ff_en ID_EX_MemToReg(
      CLK,
    RSTN,
    EN_WB,
    controlSignals[1],
    outMemToReg_IdEx);

  ff_en ID_EX_RegWR(
      CLK,
    RSTN,
    EN_WB,
    controlSignals[0],
    outRegWR_IdEx);


endmodule
