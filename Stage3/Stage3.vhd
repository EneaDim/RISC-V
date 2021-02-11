Library ieee;
use ieee.std_logic_1164.all;

ENTITY Stage3 IS
GENERIC (N : INTEGER);
PORT (IdEx_Regwrite, IdEx_MemRead, IdEx_MemWrite, IdEx_MemtoReg, IdEx_AluSrc,  MemWb_RegwriteMuxStage : IN STD_LOGIC;  --control signals in input
	clk, rst_n,  en_RdAdd, en_RS2bypass, en_ALUres, en_RegWrite, en_MemRead, en_MemWrite, en_MemtoReg: in std_logic;  
	IdEx_AluOp: in STD_LOGIC_VECTOR(2 downto 0);
	IdEx_ReadData1, IdEx_ReadData2, IdEx_Immediate, ExMem_AluResult_Stage4, FinalMuxResult: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); --data in input
	IdEx_Rs1Add, IdEx_Rs2Add, IdEx_RdAdd, ExMem_RdAddStage4, MemWb_RdAddMuxStage  : IN STD_LOGIC_VECTOR (4 DOWNTO 0); --address of sources regs and of destination reg
	ExMem_RegwriteStage3, ExMem_MemReadStage3, ExMem_MemWriteStage3, ExMem_MemtoRegStage3 : OUT STD_LOGIC; --delayed control signals in output
	ExMem_AluResult_Stage3, ExMem_ReadData2Bypass: OUT STD_LOGIC_VECTOR(N-1 downto 0); --data in output
	ExMem_RdAddStage3: OUT STD_LOGIC_VECTOR(4 downto 0)); --delayed destination reg address
END ENTITY;

ARCHITECTURE structural OF Stage3 IS

signal ForwardA, ForwardB : std_logic_VECTOR(1 downto 0);
signal ALUOperand1, ALUOperand2, OutMuxImmORDataType, ALUResult : std_LOGIC_VECTOR(31 downto 0);
signal ExMemRegWrite: std_logic;

component ALU IS
generic(N:integer);
PORT (A : in STD_LOGIC_VECTOR (31 downto 0);
      B : in STD_LOGIC_VECTOR (31 downto 0);
      ALU_OP : in STD_LOGIC_VECTOR (2 downto 0);
      RES: out STD_LOGIC_VECTOR (31 downto 0));
END component;

component ForwardingUnit IS
PORT (MemWbRegwrite, ExMemRegWrite : IN STD_LOGIC;  --signals that indicate the will to write in registers file
	MemWbRdAdd, ExMemRdAdd, IdExRs1Add, IdExRs2Add: IN STD_LOGIC_VECTOR (4 DOWNTO 0); --sources and destinations regs addresses
	ForwardA, ForwardB : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --selection signal for ALU sources (indicate the needed to forwarded and if there is, from which stage)
END component;

component mux4to1 is
		generic(N: integer);
       port( A,B,C,D: in std_logic_vector(N-1 downto 0);
             S: in std_logic_vector(1 downto 0);
             Z: out std_logic_vector(N-1 downto 0));
end component;

component mux2to1Nbit IS
generic(N:integer);
		PORT (A,B: IN STD_LOGIC_VECTOR(N-1 downto 0);
				S: IN STD_LOGIC;	
				Z : OUT STD_LOGIC_VECTOR(N-1 downto 0)); 
END component;

component registerNbit is
generic (N: integer);
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
        enable : in std_logic;
	a : in std_logic_vector(N-1 downto 0);
	b :out std_logic_vector(N-1 downto 0));
end component;

component FF_en is
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
   en : in std_logic;
	a : in std_logic;
	b :out std_logic);
end component;

begin 

FU: ForwardingUnit
port map (MemWb_RegwriteMuxStage, ExMemRegWrite, MemWb_RdAddMuxStage, ExMem_RdAddStage4, IdEx_Rs1Add, IdEx_Rs2Add,ForwardA, ForwardB);

EU: ALU
generic map(N=>32)
port map (ALuOperand1, ALUOperand2, IdEx_AluOp, ALUResult);

MUXOperand1: mux4to1
generic map (N=>32)
port map (IdEx_ReadData1, ExMem_AluResult_Stage4, FinalMuxResult, "00000000000000000000000000000000", ForwardA, AluOperand1);

MUXOperand2: mux4to1
generic map (N=>32)
port map (outMuxImmORDataType, ExMem_AluResult_Stage4, FinalMuxResult, "00000000000000000000000000000100", ForwardB, AluOperand2);

MUXImmORDataType: mux2to1Nbit
generic map (N=>32)
port map (IdEx_Immediate, IdEx_ReadData2, IdEx_AluSrc, outMuxImmORDataType);

ExMemRegRdAdd: registerNbit
generic map (N=>5)
port map (clk, rst_n, en_RdAdd, IdEx_RdAdd, ExMem_RdAddStage3);

ExMemRegRs2Bypass: registerNbit
generic map (N=>32)
port map (clk, rst_n, en_RS2bypass, IdEx_ReadData2, ExMem_ReadData2Bypass);


ExMemRegAluRes: registerNbit
generic map (N=>32)
port map (clk, rst_n, en_ALUres, AluResult , ExMem_AluResult_Stage3);


ExMemFFRegWrite: FF_en
port map (clk, rst_n, en_RegWrite, IdEx_Regwrite, ExMemRegwrite);
ExMem_RegwriteStage3<=ExMemRegWrite;

ExMemFFMemWrite: FF_en
port map (clk, rst_n, en_MemWrite, IdEx_Memwrite, ExMem_MemWriteStage3);

ExMemFFMemRead: FF_en
port map (clk, rst_n, en_MemRead, IdEx_MemRead, ExMem_MemReadStage3);

ExMemFFMemtoReg: FF_en
port map (clk, rst_n, en_MemtoReg, IdEx_MemtoReg, ExMem_MemtoRegStage3);

end architecture;
