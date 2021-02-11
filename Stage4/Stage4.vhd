Library ieee;
use ieee.std_logic_1164.all;

ENTITY Stage4 IS
GENERIC (N : INTEGER);
PORT (ExMem_Regwrite, ExMem_MemtoReg, ExMem_MemRead, ExMem_MemWrite : IN STD_LOGIC;  --control signals in input
	   clk, rst_n, en_RdAdd, en_AluResbypass, en_ReadDataMem, en_MemtoReg, en_RegWrite: in std_logic;  
		ExMem_AluResBypass, FromMem_ReadDataMem: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); --data in input
		ExMem_RdAdd: IN STD_LOGIC_VECTOR (4 DOWNTO 0); --address of destination reg
		MemWriteTOMem, EXMEMRegWrite, MemReadTOMem, MemWb_Regwrite, MemWb_MemtoReg: OUT STD_LOGIC; --delayed control signals in output
		MemWb_ReadDataMem, MemWb_AluResBypass: OUT STD_LOGIC_VECTOR(N-1 downto 0); --data in output
		MemWb_RdAdd: OUT STD_LOGIC_VECTOR(4 downto 0)); --delayed destination reg address
END ENTITY;

ARCHITECTURE structural OF Stage4 IS

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

MemReadTOMem<=ExMem_MemRead;
MemWriteTOMem<=ExMem_MemWrite;

MemWbRegRdAdd: registerNbit
generic map (N=>5)
port map (clk, rst_n, en_RdAdd, ExMem_RdAdd, MemWb_RdAdd);



MemWbRegAluResBypass: registerNbit
generic map (N=>32)
port map (clk, rst_n, en_AluResbypass, ExMem_AluResbypass, MemWb_AluResBypass);

ExMemRegReadDataMem: registerNbit
generic map (N=>32)
port map (clk, rst_n, en_ReadDataMem, FromMem_ReadDataMem , MemWb_ReadDataMem);


ExMemFFRegWrite: FF_en
port map (clk, rst_n, en_RegWrite, ExMem_Regwrite, MemWb_Regwrite);

ExMEMRegWrite<=ExMem_Regwrite;

ExMemFFMemTOReg: FF_en
port map (clk, rst_n, en_MemtoReg, ExMem_MemtoReg, MemWb_MemtoReg);

end architecture;
