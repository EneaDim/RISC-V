module risc_v_abs(
input wire CLK,
input wire RSTN,
input wire EN,
input wire [29:0] loadValue,
input wire [31:0] outMemData,
input wire [31:0] inMemInstruction,
output wire [31:0] outPC,
output wire MemWriteTOMem,
output wire MemReadTOMem,
output wire [31:0] inMemDataAddress,
output wire [31:0] inMemData
);




wire en1;
wire EN_PC;
wire EN_IF_ID_PC;
wire EN_IF_ID_INST;
wire selJump;
wire [31:0] outMem_Instruction;
wire [29:0] targetAddJump;
wire [4:0] outRdAdd_IdEx;  //address of destination reg
wire MemWrite_TOMem; wire MemRead_TOMem;  //delayed control signals in output
//output 
wire EN_AddRD; wire EN_AddRS2; wire EN_AddRS1; wire EN_Imm; wire EN_RS2; wire EN_RS1; wire EN_EX; wire EN_MEM; wire EN_WB;
wire [31:0] MemInstructionPipe;
wire [29:0] PCPipe;
wire [4:0] AddRD_MemWb; wire [4:0] AddRd_ExMem;  // log_2(M)-1 downto
// 0
wire [31:0] ALURes_MemWb;
wire [31:0] MemData_MemWb;
wire memToReg_MemWb;
wire regWR_MemWb;
wire [31:0] outMux;
wire [4:0] outAddRs2_IdEx;
wire [4:0] outAddRs1_IdEx;
wire [31:0] outImmGen_IdEx;
wire [31:0] outDataRs2_IdEx;
wire [31:0] outData1_IdEx;
wire outAluSrc_IdEx;
wire [2:0] outAluOP_IdEx;
wire outMemWR_IdEx;
wire outMemRD_IdEx;
wire outMemToReg_IdEx;
wire RegWRIdEx;  //signal        EN_IF_ID :  STD_LOGIC;
wire ExMem_RegwriteStage3; wire ExMem_MemReadStage3; wire ExMem_MemWriteStage3; wire ExMem_MemtoRegStage3;
wire [31:0] ExMemAluResult; wire [31:0] ExMem_ReadData2Bypass;
wire [31:0] out_PC;
wire en_RdAdd; wire en_AluResbypass; wire en_ReadDataMem; wire en_MemtoRegExMem;
wire en_RS2bypass; wire en_ALUres; wire en_RegWriteExMem; wire en_MemReadExMem; wire en_MemWriteExMem;
wire en_MemToRegMemWb; wire en_RegWriteMemWb; wire EXMEMRegWrite;
wire ENPC; wire ENIFIDPC; wire ENIFIDINST;

  //outMem_Instruction <= inMemInstruction;
  stage1 #(
      .N(32))
  Stage_1(
      CLK,
    RSTN,
    ENPC,
    ENIFIDPC,
    ENIFIDINST,
    selJump,
    loadValue,
    inMemInstruction,
    targetAddJump,
    out_PC,
    MemInstructionPipe,
    PCPipe);

  assign outPC = out_PC;
  stage2 #(
      .N(32))
  Stage_2(
      CLK,
    RSTN,
    en1,
    // en1,en1, en1, en1, en1, en1, en1, en1, --EN_AddRD,EN_AddRS2, EN_AddRS1, EN_Imm, EN_RS2, EN_RS1, EN_EX, EN_MEM, EN_WB,
    MemInstructionPipe,
    PCPipe,
    AddRD_MemWb,
    ALURes_MemWb,
    MemData_MemWb,
    memToReg_MemWb,
    regWR_MemWb,
    ExMemRegWrite,
    regWRIdEx,
    outRdAdd_IdEx,
    selJump,
    targetAddJump,
    outMux,
    outRdAdd_IdEx,
    outAddRs2_IdEx,
    outAddRs1_IdEx,
    outImmGen_IdEx,
    outDataRs2_IdEx,
    outData1_IdEx,
    outAluSrc_IdEx,
    outAluOP_IdEx,
    outMemWR_IdEx,
    outMemRD_IdEx,
    outMemToReg_IdEx,
    RegWRIdEx,
    EN_IF_ID_PC,
    EN_IF_ID_INST,
    EN_PC);

  Stage3 #(
      .N(32))
  Stage_3(
      RegWRIdEx,
    outMemRD_IdEx,
    outMemWR_IdEx,
    outMemToReg_IdEx,
    outAluSrc_IdEx,
    regWR_MemWb,
    CLK,
    RSTN,
    en1,
    en1,
    en1,
    en1,
    en1,
    en1,
    en1,
    //en_RdAdd, en_RS2bypass, en_ALUres, en_RegWriteExMem, en_MemReadExMem, en_MemWriteExMem, en_MemtoRegExMem,
    outAluOP_IdEx,
    outData1_IdEx,
    outDataRs2_IdEx,
    outImmGen_IdEx,
    ExMemAluResult,
    outMux,
    outAddRs1_IdEx,
    outAddRs2_IdEx,
    outRdAdd_IdEx,
    AddRd_ExMem,
    AddRD_MemWb,
    ExMem_RegwriteStage3,
    ExMem_MemReadStage3,
    ExMem_MemWriteStage3,
    ExMem_MemtoRegStage3,
    ExMemAluResult,
    ExMem_ReadData2Bypass,
    addRD_ExMem);

  Stage4 #(
      .N(32))
  Stage_4(
      ExMem_RegwriteStage3,
    ExMem_MemtoRegStage3,
    ExMem_MemReadStage3,
    ExMem_MemWriteStage3,
    CLK,
    RSTN,
    en1,
    en1,
    en1,
    en1,
    en1,
    ExMemAluResult,
    outMemData,
    AddRd_ExMem,
    MemWrite_TOMem,
    EXMEMRegWrite,
    MemRead_TOMem,
    regWR_MemWb,
    memToReg_MemWb,
    MemData_MemWb,
    ALURes_MemWb,
    AddRD_MemWb);

  assign MemWriteTOMem = MemWrite_TOMem;
  assign MemReadTOMem = MemRead_TOMem;
  assign inMemDataAddress = ExMemAluResult;
  assign inMemData = ExMem_ReadData2Bypass;
  assign en1 = en;
  assign ENPC = EN1 & EN_PC;
  assign ENIFIDPC = EN1 & EN_IF_ID_PC;
  assign ENIFIDINST = EN1 & EN_IF_ID_INST;
  assign en_RdAdd = EN1;
  assign en_ReadDataMem = EN1;
  assign en_RS2bypass = EN1;
  assign en_ALUres = EN1;
  assign en_MemtoRegExMem = EN1;
  assign en_RegWriteExMem = EN1;
    //en_MemToRegMemWb <= EN;
  //en_RegWriteMemWb <= EN;

endmodule
