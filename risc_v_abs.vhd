library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

 entity risc_v_abs is
    port(CLK, RSTN, EN : in std_logic;
			loadValue:in std_LOGIC_VECTOR(29 downto 0);
         outMemData : in std_logic_vector (31 downto 0);
			inMemInstruction: in std_logic_vector(31 downto 0);
         outPC : out std_logic_vector( 31 downto 0);
         MemWriteTOMem, MemReadTOMem: OUT STD_LOGIC;
         inMemDataAddress : out std_logic_vector (31 downto 0) ;
         inMemData :out std_logic_vector(31 downto 0));
  end entity;

architecture struct of RISC_V_ABS is
  signal en1: std_LOGIC;
  signal  EN_PC :  std_logic;
  signal  EN_IF_ID_PC :  std_logic;
  signal  EN_IF_ID_INST :  std_logic;
  signal  selJump :  std_logic;
  signal  outMem_Instruction :  std_logic_vector(31 downto 0);
  signal  targetAddJump :  std_logic_vector(29 downto 0);
  signal  outRdAdd_IdEx:  STD_LOGIC_VECTOR (4 DOWNTO 0); --address of destination reg
  signal	 MemWrite_TOMem, MemRead_TOMem:  STD_LOGIC; --delayed control signals in output
                                                                                       --output 
  signal  EN_AddRD,EN_AddRS2, EN_AddRS1, EN_Imm, EN_RS2, EN_RS1, EN_EX, EN_MEM, EN_WB :  std_logic ;
  signal          MemInstructionPipe :  std_logic_vector (31 downto 0);
  signal         PCPipe :  std_logic_vector (29 downto 0);
  signal         AddRD_MemWb,    AddRd_ExMem :  std_logic_vector (4 downto 0);-- log_2(M)-1 downto
                                                          -- 0
  signal         ALURes_MemWb :  std_logic_vector (31 downto 0);
  signal         MemData_MemWb :  std_logic_vector (31 downto 0);
   signal         memToReg_MemWb :  std_logic;
  signal          regWR_MemWb :  std_logic;

   signal        outMux:  std_logic_vector(31 downto 0);
   signal        outAddRs2_IdEx :  std_logic_vector (4 downto 0);
   signal        outAddRs1_IdEx :  std_logic_vector (4 downto 0);
   signal        outImmGen_IdEx :  std_logic_vector (31 downto 0);
   signal        outDataRs2_IdEx :  std_logic_vector (31 downto 0);
    signal       outData1_IdEx :  std_logic_vector (31 downto 0);
   signal        outAluSrc_IdEx :  std_logic;
   signal        outAluOP_IdEx :  std_logic_vector (2 downto 0);
   signal        outMemWR_IdEx :  std_logic;
   signal        outMemRD_IdEx :  std_logic;
   signal        outMemToReg_IdEx :  std_logic;
   signal        RegWRIdEx :  std_logic;
   --signal        EN_IF_ID :  STD_LOGIC;
  signal  ExMem_RegwriteStage3, ExMem_MemReadStage3, ExMem_MemWriteStage3, ExMem_MemtoRegStage3 :  STD_LOGIC;
  signal ExMemAluResult, ExMem_ReadData2Bypass : STD_LOGIC_VECTOR(31 downto 0); 
  signal out_PC :  std_logic_vector(31 downto 0);
signal en_RdAdd, en_AluResbypass,  en_ReadDataMem, en_MemtoRegExMem : std_logic;
signal en_RS2bypass, en_ALUres, en_RegWriteExMem, en_MemReadExMem, en_MemWriteExMem : std_logic;
signal en_MemToRegMemWb, en_RegWriteMemWb, EXMEMRegWrite: std_logic;
  signAL ENPC,ENIFIDPC,ENIFIDINST: std_logic;
  
  component stage1 is
 generic ( N : integer := 32 );
  port ( CLK : in std_logic;
         RSTN : in std_logic;
         EN_PC : in std_logic;
         EN_PIPE_PC : in std_logic;
         EN_PIPE_Instruction : in std_logic;
         selJump : in std_logic;
	loadValue: in std_LOGIC_VECTOR(N-3 downto 0);
         outMemInstruction : in std_logic_vector(N-1 downto 0);--(31 downto 0);--
         targetAddJump : in std_logic_vector(N-3 downto 0);--(29 downto 0);--

         outPC : out std_logic_vector(N-1 downto 0);--(31 downto 0);--
         outMemInstructionPipe : out std_logic_vector(N-1 downto 0);--(31 downto 0);--(N-1 downto 0);
         outPipeRegPC : out std_logic_vector(N-3 downto 0));--(29 downto 0));--(N-3 downto 0));
  end component;


  component stage2 is
    generic (N : integer);
    port(CLK, RSTN ,EN : in std_logic;--EN_AddRD,EN_AddRS2, EN_AddRS1, EN_Imm, EN_RS2, EN_RS1, EN_EX, EN_MEM, EN_WB : in std_logic ;
           MemInstructionPipe : in std_logic_vector (N-1 downto 0);
           PCPipe : in std_logic_vector (N-3 downto 0);
           AddRD_MemWb : in std_logic_vector (4 downto 0);-- log_2(M)-1 downto
                                                          -- 0
           ALURes_MemWb : in std_logic_vector (N-1 downto 0);
           MemData_MemWb : in std_logic_vector (N-1 downto 0);
           memToReg_MemWb : in std_logic;
           regWR_MemWb : in std_logic;
           regWR_ExMem : in std_logic;
           regWR_IdEx : in std_logic;
           --memWr_IdEx: in std_logic;
           --memRd_IdEx: in std_logic;
           --memWr_ExMem : in std_logic;
           --memRd_ExMem : in std_logic;
           AddRD_ExMem : in std_logic_vector(4 downto 0);

           selJump : out std_logic;
           targetAddJump : out std_logic_vector(N-3 downto 0);

           outMux: out std_logic_vector(N-1 downto 0);
           outAddRd_IdEx : out std_logic_vector (4 downto 0);
           outAddRs2_IdEx : out std_logic_vector (4 downto 0);
           outAddRs1_IdEx : out std_logic_vector (4 downto 0);
           outImmGen_IdEx : out std_logic_vector (N-1 downto 0);
           outDataRs2_IdEx : out std_logic_vector (N-1 downto 0);
           outData1_IdEx : out std_logic_vector (N-1 downto 0);
           outAluSrc_IdEx : out std_logic;
           outAluOP_IdEx : out std_logic_vector (2 downto 0);
           outMemWR_IdEx : out std_logic;
           outMemRD_IdEx : out std_logic;
           outMemToReg_IdEx : out std_logic;
           outRegWR_IdEx : out std_logic;
           EN_IF_ID_PC, EN_IF_ID_INST : OUT STD_LOGIC;
           EN_PC : OUT STD_LOGIC);
  end component;

  component Stage3 is
    generic (N: integer);
    port(IdEx_Regwrite, IdEx_MemRead, IdEx_MemWrite, IdEx_MemtoReg, IdEx_AluSrc, MemWb_RegwriteMuxStage: IN STD_LOGIC;  --control signals in input
	clk, rst_n,  en_RdAdd, en_RS2bypass, en_ALUres, en_RegWrite, en_MemRead, en_MemWrite, en_MemtoReg: in std_logic;  
	IdEx_AluOp: in STD_LOGIC_VECTOR(2 downto 0);
	IdEx_ReadData1, IdEx_ReadData2, IdEx_Immediate, ExMem_AluResult_Stage4, FinalMuxResult: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); --data in input
	IdEx_Rs1Add, IdEx_Rs2Add, IdEx_RdAdd, ExMem_RdAddStage4, MemWb_RdAddMuxStage  : IN STD_LOGIC_VECTOR (4 DOWNTO 0); --address of sources regs and of destination reg
	ExMem_RegwriteStage3, ExMem_MemReadStage3, ExMem_MemWriteStage3, ExMem_MemtoRegStage3 : OUT STD_LOGIC; --delayed control signals in output
	ExMem_AluResult_Stage3, ExMem_ReadData2Bypass: OUT STD_LOGIC_VECTOR(N-1 downto 0); --data in output
	ExMem_RdAddStage3: OUT STD_LOGIC_VECTOR(4 downto 0)); --delayed destination reg address);
  end component;

  component Stage4 is
    generic (N: integer);
    port(ExMem_Regwrite, ExMem_MemtoReg, ExMem_MemRead, ExMem_MemWrite : IN STD_LOGIC;  --control signals in input
	   clk, rst_n, en_RdAdd, en_AluResbypass, en_ReadDataMem, en_MemtoReg, en_RegWrite: in std_logic;  
		ExMem_AluResBypass, FromMem_ReadDataMem: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); --data in input
		ExMem_RdAdd: IN STD_LOGIC_VECTOR (4 DOWNTO 0); --address of destination reg
		MemWriteTOMem, EXMEMRegWrite, MemReadTOMem, MemWb_Regwrite, MemWb_MemtoReg: OUT STD_LOGIC; --delayed control signals in output
		MemWb_ReadDataMem, MemWb_AluResBypass: OUT STD_LOGIC_VECTOR(N-1 downto 0); --data in output
		MemWb_RdAdd: OUT STD_LOGIC_VECTOR(4 downto 0)); --delayed destination reg address
  end component;

begin

  --outMem_Instruction <= inMemInstruction;
  
  Stage_1 : stage1 generic map (N=>32) port map(CLK, RSTN, ENPC, ENIFIDPC ,ENIFIDINST ,
                                                selJump,
						loadValue,
                                                inMemInstruction,
                                                targetAddJump,
                                                out_PC ,
                                                MemInstructionPipe,
          PCPipe );

  outPC <= out_PC ;
  
  Stage_2 : stage2 generic map(N=>32) port map(CLK, RSTN, en1,-- en1,en1, en1, en1, en1, en1, en1, en1, --EN_AddRD,EN_AddRS2, EN_AddRS1, EN_Imm, EN_RS2, EN_RS1, EN_EX, EN_MEM, EN_WB,
           MemInstructionPipe,
           PCPipe,
           AddRD_MemWb,
           ALURes_MemWb,
           MemData_MemWb,
           memToReg_MemWb,
           regWR_MemWb ,
           ExMemRegWrite,
           regWRIdEx,
           outRdAdd_IdEx,
           selJump, 
           targetAddJump,
           outMux,  outRdAdd_IdEx,
           outAddRs2_IdEx ,
           outAddRs1_IdEx ,
           outImmGen_IdEx ,
           outDataRs2_IdEx,
           outData1_IdEx,
           outAluSrc_IdEx,
           outAluOP_IdEx ,
           outMemWR_IdEx,
           outMemRD_IdEx,
           outMemToReg_IdEx,
           RegWRIdEx,
		   EN_IF_ID_PC, EN_IF_ID_INST,
           EN_PC 
          );

  Stage_3: Stage3 generic map(N=>32) port map(
   RegWRIdEx,
   outMemRD_IdEx,
   outMemWR_IdEx,
   outMemToReg_IdEx, 
   outAluSrc_IdEx,   
   regWR_MemWb,     
   CLK , 
   RSTN,  en1, en1, en1, en1, en1, en1, en1, --en_RdAdd, en_RS2bypass, en_ALUres, en_RegWriteExMem, en_MemReadExMem, en_MemWriteExMem, en_MemtoRegExMem,
   outAluOP_IdEx ,
   outData1_IdEx,  
   outDataRs2_IdEx,  
   outImmGen_IdEx ,
   ExMemAluResult,
   outMux, outAddRs1_IdEx , 
   outAddRs2_IdEx ,   
   outRdAdd_IdEx, 
   AddRd_ExMem, 
   AddRD_MemWb,
   ExMem_RegwriteStage3,
   ExMem_MemReadStage3,
   ExMem_MemWriteStage3, 
   ExMem_MemtoRegStage3 ,  
   ExMemAluResult, 
   ExMem_ReadData2Bypass ,
   addRD_ExMem);

  Stage_4: Stage4 generic map(N=>32) port map(
   ExMem_RegwriteStage3,
	ExMem_MemtoRegStage3,
   ExMem_MemReadStage3,
   ExMem_MemWriteStage3, 
   CLK, RSTN, en1, en1, en1, en1, en1,
   ExMemAluResult,  
   outMemData,
   AddRd_ExMem, 
   MemWrite_TOMem, EXMEMRegWrite, MemRead_TOMem,
   regWR_MemWb ,   	
   memToReg_MemWb, 
   MemData_MemWb,
	ALURes_MemWb,
   AddRD_MemWb);
	


  MemWriteTOMem <= MemWrite_TOMem;
  MemReadTOMem <= MemRead_TOMem;
  inMemDataAddress <= ExMemAluResult;
  inMemData <= ExMem_ReadData2Bypass;
    
	 en1<=en; 
	 ENPC<= EN1 and EN_PC;
	 ENIFIDPC<= EN1 and EN_IF_ID_PC;
	 ENIFIDINST<= EN1 and EN_IF_ID_INST;
   
   
    en_RdAdd <= EN1;
    
    en_ReadDataMem <= EN1;
    
   
    en_RS2bypass <= EN1;
    en_ALUres <= EN1;
    en_MemtoRegExMem <= EN1;
    en_RegWriteExMem <= EN1;
    --en_MemToRegMemWb <= EN;
    --en_RegWriteMemWb <= EN;
  
end architecture;

  
