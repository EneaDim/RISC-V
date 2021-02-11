LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY HazardDetector IS
 
	PORT (ID_EX_RegWrite, EX_MEM_RegWrite, MEM_WB_RegWrite, instBEQ, instADDI, instLW, instANDI, instSRAI, instADD,instXOR,instSLT,
		instSW, instABS, clk, rst_n: IN STD_LOGIC;
	ADD1, ADD2, ID_EX_ADDRD, EX_MEM_ADDRD, MEM_WB_ADDRD: IN STD_LOGIC_VECTOR(4 downto 0);
			Mux_control, IF_ID_PCenable, IF_ID_INSTenable, PC_enable : OUT STD_LOGIC); 
END HazardDetector;

ARCHITECTURE combinational OF HazardDetector IS

component ff_en is
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
	en : in std_LOGIC;
	a : in std_logic;
	b :out std_logic);
end component;


component Comparator_Nbit IS
generic ( N : INTEGER);
PORT (RdAdd, RsAdd: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	  equality : OUT STD_LOGIC);
end component;

signal verify_Add2,  outcomp1, outcomp1_2,outcomp1_3, outcomp2,outcomp2_2,outcomp2_3, outadd2,outadd2_2,outadd2_3, same_reg,same_reg_2, same_reg_3,   ffbobble3_out,
 bobble_3, bobble_2,  ffbobble2_out, ffbobble2input, bobble_1, possibile_inst, LWplusinstruction, bobbleLW, bobbleout, instLWff  :std_LOGIC;


BEGIN
	
	comp1: Comparator_Nbit generic map(N=>5) port map(RdAdd=>ID_EX_ADDRD, RsAdd=>ADD1, equality=>outcomp1);
	
	comp2: Comparator_Nbit generic map(N=>5) port map(RdAdd=>ID_EX_ADDRD, RsAdd=>ADD2, equality=>outcomp2);

	verify_Add2<= instBEQ or instADDI or instLW or instANDI or instSRAI or instADD or instXOR or instSLT or instABS;  -- instADD or instXOR or instSLT or instBEQ;
	
	outadd2<=outcomp2 and verify_Add2;
	
	same_reg<=outcomp1 or outadd2;
	
	
	comp1_2: Comparator_Nbit generic map(N=>5) port map(RdAdd=>EX_MEM_ADDRD, RsAdd=>ADD1, equality=>outcomp1_2);
	
	comp2_2: Comparator_Nbit generic map(N=>5) port map(RdAdd=>EX_MEM_ADDRD, RsAdd=>ADD2, equality=>outcomp2_2);
		
	outadd2_2<=outcomp2_2 and verify_Add2;
	
	same_reg_2<=outcomp1_2 or outadd2_2;
	
	
	comp1_3: Comparator_Nbit generic map(N=>5) port map(RdAdd=>MEM_WB_ADDRD, RsAdd=>ADD1, equality=>outcomp1_3);
	 
	comp2_3: Comparator_Nbit generic map(N=>5) port map(RdAdd=>MEM_WB_ADDRD, RsAdd=>ADD2, equality=>outcomp2_3);
		
	outadd2_3<=outcomp2_3 and verify_Add2;
	
	same_reg_3<=outcomp1_3 or outadd2_3;
	
	
	-- BEQ caso delle 3 bolle 
	
	bobble_3<=instBEQ and ID_EX_RegWrite and same_reg;
	
	ffbobble3: ff_en port map (clk, rst_n, '1', bobble_3, ffbobble3_out);	--ffbobble3: ff con input bubble_3
	
	-- BEQ caso delle 2 bolle

	bobble_2<=instBEQ and EX_MEM_RegWrite and same_reg_2;
	 
	ffbobble2input<=bobble_2 or ffbobble3_out;
	
	ffbobble2: ff_en port map(clk, rst_n, '1', ffbobble2input, ffbobble2_out);
	
	-- BEQ caso di 1 bolla
	bobble_1<=MEM_WB_RegWrite and instBEQ and same_reg_3;
	
	-- LD + altra istruzione

	ffLW: ff_en port map(clk, rst_n, '1', instLW, instLWff);
	
	possibile_inst<=instADD or instADDI or instANDI or instSLT or instXOR or instSRAI or instLW or instSW or instABS;
	
	LWplusinstruction<=instLWff and possibile_inst;
	bobbleLW<=LWplusinstruction and same_reg;
	
	-- OUT
	bobbleout <= bobbleLW or bobble_1 or ffbobble2_out or ffbobble3_out or bobble_3;
	
	Mux_control<=bobbleout;
	IF_ID_PCenable<=not(bobbleout);
	IF_ID_INSTenable<=not(bobbleout);
	PC_enable<=not(bobbleout);

		
END combinational;
