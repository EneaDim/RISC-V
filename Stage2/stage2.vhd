library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity stage2 is
  generic ( N : integer);
    port ( CLK, RSTN, EN : in std_logic; --, EN_AddRD,EN_AddRS2, EN_AddRS1, EN_Imm, EN_RS2, EN_RS1, EN_EX, EN_MEM, EN_WB : in std_logic ;
           MemInstructionPipe : in std_logic_vector (N-1 downto 0);
           PCPipe : in std_logic_vector (N-3 downto 0);
           AddRD_MemWb : in std_logic_vector (4 downto 0);
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
           --AddRD_IdEx : in std_logic_vector(4 downto 0);

        
           selJump : out std_logic;
           targetAddJump : out std_logic_vector(N-3 downto 0);
      
           outMux : out std_logic_vector (N-1 downto 0);
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
end entity;

architecture struct of stage2 is

  signal zero, outXor : std_logic;
  signal RS1,RS2 : std_logic_vector (31 downto 0);
  signal beqOk:  STD_LOGIC;
  signal addOK:  STD_LOGIC;
  signal addiOK :  STD_LOGIC;
  signal sltOK:  STD_LOGIC;
  signal auipcOK :  STD_LOGIC;
  signal luiOK :  STD_LOGIC;
  signal sraiOK :  STD_LOGIC;
  signal andiOK :  STD_LOGIC;
  signal xorOK :  STD_LOGIC;
  signal jalOK:  STD_LOGIC;
  signal lwOK:  STD_LOGIC;
  signal swOK, absOK :  STD_LOGIC;
  signal immediateValue : std_logic_vector( 31 downto 0);
  signal immediate_Value : signed(29 downto 0);
  signal target_AddJump : signed (29 downto 0);
  signal dataWb : std_logic_vector(31 downto 0);

  signal branch:  STD_LOGIC;
  signal alu_src :  STD_LOGIC;
  signal alu_op :  STD_LOGIC_VECTOR(2 downto 0);
  signal  mem_wr :  STD_LOGIC;
  signal mem_rd :  STD_LOGIC;
  signal mem_to_reg :  STD_LOGIC;
  signal reg_wr :  STD_LOGIC;
  signal controlSignals : STD_LOGIC_VECTOR(7 downto 0);
  signal controlRS1in : std_logic;
  signal controlRS1out : std_logic;
  signal targetRS1, outAddRDIdEx : STD_LOGIC_VECTOR (4 downto 0);
  signal RS1inPipe : STD_LOGIC_VECTOR (31 downto 0);
  signal PC_Pipe : std_logic_vector (31 downto 0);
  signal PC_Pipe_s : signed (29 downto 0);
  signal EN_AddRD,EN_AddRS2, EN_AddRS1, EN_Imm, EN_RS2, EN_RS1, EN_EX, EN_MEM, EN_WB : std_logic ;
  signal beq,mux_Control, en_jump, en_Eq : STD_LOGIC;
  signal in_en_A, in_en_B,  en_jump_a, en_jump_b : std_logic_vector (29 downto 0);
  signal in_en_rs1, in_en_rs2, en_xor_rs1, en_xor_rs2 : std_logic_vector (31 downto 0);
 

  COMPONENT andBlock IS
generic(N: integer);
    Port ( IN1 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           IN2 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           RES  : out STD_LOGIC_VECTOR (N-1 downto 0));
END COMPONENT;

  
  component FF_en is
	PORT (  CLK, RST_N, EN : in STD_LOGIC;
                A : IN STD_LOGIC;
                B : OUT STD_LOGIC);
                end component;
                
  component registerNbit is
    	generic(N: integer );
	port ( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
        enable : in std_logic;
	a : in std_logic_vector(N-1 downto 0);
	b :out std_logic_vector(N-1 downto 0));

  end component;
  
  component mux2to1Nbit is
    	generic(N: integer );
	PORT (	A,B : IN STD_LOGIC_VECTOR(N-1 downto 0);
				s: in std_LOGIC;
				Z : OUT STD_LOGIC_vector(N-1 downto 0)); 

  end component;
   
  component adderSubNbit is
    generic(N: integer );
    Port ( IN1 : in  SIGNED (N-1 downto 0) ;
           IN2 : in  SIGNED (N-1 downto 0) ;
           SUM  : out SIGNED (N-1 downto 0));
 end component;

  component ImmediateGenerator is
   port ( ADD, XORinst, SLT, AUIPC, LUI, ADDI, LW, ANDI, SRAI, BEQ, JAL, SW, ABSV: IN STD_LOGIC;  --signals that indicate the instruction
	instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0); --instruction sampled from the instruction memory
	Immediate : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));  --SIGNED (31 DOWNTO 0)); --immediate value properly generated depending on the instruction in input

  end component;

  
  component  REGISTERS_mainblock is
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
	Regwrite: in STD_LOGIC;
	ReadRS1: in STD_LOGIC_VECTOR(4 downto 0);
	ReadRS2: in STD_LOGIC_VECTOR(4 downto 0);
	writereg: in STD_LOGIC_VECTOR(4 downto 0);
	Datawrite: in STD_LOGIC_VECTOR(31 downto 0);
	Readdata1: out STD_LOGIC_VECTOR(31 downto 0);
	Readdata2: out STD_LOGIC_VECTOR(31 downto 0));
  end component;
  
component Comparator_Nbit IS
generic ( N : INTEGER);
PORT (RdAdd, RsAdd: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); --sources and destinations regs addresses
	  equality : OUT STD_LOGIC); --equality signal to indicate if the data input are equal (RsAdd is equal to RdAdd)
END component;

  component  HazardDetector IS
 
	PORT (ID_EX_RegWrite, EX_MEM_RegWrite, MEM_WB_RegWrite, instBEQ, instADDI, instLW, instANDI, instSRAI, instADD,instXOR,instSLT, instSW, instABS, clk, rst_n: IN STD_LOGIC;
	ADD1, ADD2, ID_EX_ADDRD, EX_MEM_ADDRD, MEM_WB_ADDRD: IN STD_LOGIC_VECTOR(4 downto 0);
			Mux_control, IF_ID_PCenable, IF_ID_INSTenable, PC_enable : OUT STD_LOGIC); 
  END component;

  -- MANCA INGRESSO 'ZERO'

 

  component ControlUnit is
    Port ( opcode : in STD_LOGIC_VECTOR (6 downto 0);
  func3 : in STD_LOGIC_VECTOR (2 downto 0);
  func7 : in STD_LOGIC_VECTOR (6 downto 0);
  zero : in STD_LOGIC;

  beqOK: out STD_LOGIC;
  addOK: out STD_LOGIC;
  addiOK : out STD_LOGIC;
  sltOK: out STD_LOGIC;
  auipcOK : out STD_LOGIC;
  luiOK : out STD_LOGIC;
  jalOK: out STD_LOGIC;
  sraiOK : out STD_LOGIC;
  andiOK : out STD_LOGIC;
  xorOK : out STD_LOGIC;
  lwOK: out STD_LOGIC;
  swOK, absOK : out STD_LOGIC;
  
  branch: out STD_LOGIC;
  alu_src : out STD_LOGIC;
  alu_op : out STD_LOGIC_VECTOR(2 downto 0);
  mem_wr : out STD_LOGIC;
  mem_rd : out STD_LOGIC;
  mem_to_reg : out STD_LOGIC;
  reg_wr : out STD_LOGIC;
  controlRS1in : out STD_LOGIC;
  controlRS1out : out STD_LOGIC);
 -- enALU : out STD_LOGIC);
  end component;
  
begin


  en_jump <= branch or jalOK;
  en_Eq <= beqOK;
  
  en_jump_a<= en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump ;
  en_jump_b<=  en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump & en_jump;
  en_xor_rs1<= en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq ;
  en_xor_rs2<=en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq & en_Eq ;
 

  MuxWB : mux2to1Nbit generic map (N=>32) port map ( ALURes_MemWb,  MemData_MemWb , memToReg_MemWb, dataWB);
  outMux <= dataWB;


   andBlockEqRs1: andBlock generic map(N=>32) port map ( RS1 ,en_xor_rs1, in_en_rs1);
  
  andBlockEqRs2: andBlock generic map(N=>32) port map ( RS2 ,en_xor_rs2, in_en_rs2);
  
  
  ComparatorBlock : comparator_nbit generic map (N => 32) port map(in_en_rs1, in_en_rs2, outXor);
  zero <= outXor;
 
  selJump <= branch;
  
  ImmediateBlock: ImmediateGenerator port map (addOK, xorOK, sltOK, auipcOK, luiOK, addiOK, lwOK, andiOK, sraiOK, beqOK, jalOK, swOK, absOK, MemInstructionPipe, immediateValue);


  
  andBlockJumpA: andBlock generic map(N=>30) port map ( immediateValue(31 downto 2) ,en_jump_a, in_en_A);
  
  andBlockJumpB: andBlock generic map(N=>30) port map ( PCPIPE ,en_jump_b, in_en_B);
  
  
  immediate_Value <= signed(in_en_A);
  PC_Pipe_s <= signed(in_en_B);
  
  adderBlock: adderSubNbit generic map (N=>30) port map (PC_Pipe_s ,  immediate_Value , target_AddJump);
                         
  targetAddJump <= std_logic_vector(target_AddJump);                      
--non faccio il *2?? oppure si?? boh
-- manca blocco XOR per fare la SUB


  MuxIn1Reg : mux2to1Nbit generic map(N=>5) port map( MemInstructionPipe (19 downto 15), "00000", controlRS1in, targetRS1);
  

  RegisterBlock : REGISTERS_mainblock  port map ( CLK, RSTN, regWR_MemWb, targetRS1 , MemInstructionPipe (24 downto 20), AddRD_MemWb , dataWb, RS1, RS2);

  PC_Pipe <= PCPipe & '0' & '0';

  MuxRS1 : mux2to1Nbit generic map ( N => 32) port map (RS1, PC_Pipe, controlRS1out, RS1inPipe);
 
  

  controlSignals <= ( alu_src &  alu_op(2) & alu_op(1) & alu_op(0) & mem_wr & mem_rd & mem_to_reg & reg_wr) ;

  
  ControlUnitBlock : ControlUnit port map(MemInstructionPipe (6 downto 0), MemInstructionPipe(14 downto 12), MemInstructionPipe(31 downto 25), zero ,beqOk, addOK, addiOK, sltOK,  auipcOK ,  luiOK, jalOK,  sraiOK , andiOK , xorOK,  lwOK,  swOK, absOK,    branch,  alu_src,  alu_op,  mem_wr,  mem_rd,  mem_to_reg,  reg_wr , controlRS1in, controlRS1out);

  --controlSignals <=  ( alu_src & alu_op(2) & alu_op &  mem_wr &  mem_rd &  mem_to_reg &  reg_wr);
  
  
  outAddRD_IdEx <= outAddRDIdEx;

  HazardDetectorBlock : HazardDetector port map (regWR_IdEx, regWR_ExMem, regWr_MemWb, beqOK, addiOK, lwOK, andiOK, sraiOK, addOK, xorOK, sltOK, swOK, absOK, CLK, RSTN, MemInstructionPipe (19 downto 15), MemInstructionPipe (24 downto 20), outAddRDIdEx, AddRD_ExMem, AddRD_MemWb, mux_Control, EN_IF_ID_PC, EN_IF_ID_INST, EN_PC );

--  MuxControl : mux2to1Nbit generic map (N=>8) port map ( controlSignals, "00000000", mux_Control, controlSignalsPipe);


 
  EN_AddRD <= en; -- and not(beqOK);
  EN_AddRS2 <=en; -- and not(beqOK);
  EN_AddRS1 <=en; -- and not(beqOK);
  EN_Imm <=en; -- and not(beqOK);
  EN_RS2 <=en; -- and not(beqOK);
  EN_RS1 <=en; -- and not(beqOK);
  EN_EX <=en; -- and not(beq);
  EN_MEM <=en; -- and not(beq);
  EN_WB <=en; -- and not(beq);

  
  
  ID_EX_AddRD : registerNbit generic map (N=>5) port map (CLK, RSTN , EN_AddRD , MemInstructionPipe(11 downto 7),outAddRdIdEx );
   

  ID_EX_AddRS1 : registerNbit generic map (N=>5) port map (CLK, RSTN , EN_AddRS1 ,  MemInstructionPipe(19 downto 15),  outAddRs1_IdEx );
  
  ID_EX_AddRS2 : registerNbit generic map (N=>5) port map (CLK, RSTN, EN_AddRS2 ,MemInstructionPipe(24 downto 20),outAddRS2_IdEx );

  ID_EX_Imm : registerNbit generic map (N=>32 ) port map (CLK, RSTN , EN_Imm , immediateValue, outImmGen_IdEx );
  
  ID_EX_RS2 : registerNbit generic map (N=>32 ) port map (CLK, RSTN , EN_RS2 , RS2, outDataRS2_IdEx );
  
  ID_EX_RS1 : registerNbit generic map (N=>32 ) port map (CLK, RSTN , EN_RS1 , RS1inPipe, outData1_IdEx );

  ID_EX_AluSrc : ff_en port map (CLK, RSTN, EN_EX, controlSignals(7), outAluSrc_IdEx);
 
  ID_EX_AluOP : registerNbit generic map (N=>3 ) port map (CLK, RSTN , EN_EX , controlSignals( 6 downto 4) , outAluOP_IdEx );

  ID_EX_MemWR : ff_en port map (CLK, RSTN, EN_MEM, controlSignals(3), outMemWR_IdEx);
  
  ID_EX_MemRD : ff_en port map (CLK, RSTN, EN_MEM, controlSignals(2), outMemRD_IdEx);
  
  ID_EX_MemToReg : ff_en port map (CLK, RSTN, EN_WB, controlSignals(1), outMemToReg_IdEx);
  
  ID_EX_RegWR : ff_en port map (CLK, RSTN, EN_WB, controlSignals(0), outRegWR_IdEx);

  
end architecture;

