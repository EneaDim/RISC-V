LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

entity tb_hazard is
end tb_hazard;



ARCHITECTURE bdf_type OF tb_hazard IS 



COMPONENT HazardDetector IS
 
	PORT (ID_EX_RegWrite, EX_MEM_RegWrite, MEM_WB_RegWrite, instBEQ, instADDI, instLW, instANDI, instSRAI, instADD,instXOR,instSLT,
		instSW, clk, rst_n: IN STD_LOGIC;
			ADD1, ADD2, ID_EX_ADDRD, EX_MEM_ADDRD, MEM_WB_ADDRD: IN STD_LOGIC_VECTOR(4 downto 0);
			Mux_control, IF_ID_enable, PC_enable : OUT STD_LOGIC); 
END component;

SIGNAL tbCLK: STD_LOGIC :='0';
signal tbID_EX_RegWrite, tbEX_MEM_RegWrite, tbMEM_WB_RegWrite, tbinstBEQ, tbinstADDI, tbinstLW, tbinstANDI, tbinstSRAI, tbinstADD, tbinstXOR, tbinstSLT,
		tbinstSW, tbrst_n, tbMux_control, tbIF_ID_enable, tbPC_enable: STD_LOGIC;
signal tbADD1, tbADD2, tbID_EX_ADDRD, tbEX_MEM_ADDRD, tbMEM_WB_ADDRD: STD_LOGIC_VECTOR(4 downto 0);

begin

uut: HazardDetector PORT MAP (tbID_EX_RegWrite, tbEX_MEM_RegWrite, tbMEM_WB_RegWrite, tbinstBEQ, tbinstADDI, tbinstLW, tbinstANDI, tbinstSRAI, tbinstADD, tbinstXOR, tbinstSLT,
		tbinstSW, tbclk, tbrst_n, tbADD1, tbADD2, tbID_EX_ADDRD, tbEX_MEM_ADDRD, tbMEM_WB_ADDRD, tbMux_control, tbIF_ID_enable, tbPC_enable);


process
begin
	wait for 50 ns;
	tbCLK<= not tbCLK;
end process;


process
begin
wait for 20 ns;
tbrst_n<='1';
tbID_EX_RegWrite<='0'; tbEX_MEM_RegWrite<='0'; tbMEM_WB_RegWrite<='0'; tbinstBEQ<='0'; tbinstADDI<='0'; tbinstLW<='0'; tbinstANDI<='0'; tbinstSRAI<='0'; 
tbinstADD<='0'; tbinstXOR<='0'; tbinstSLT<='0';	tbinstSW<='0'; tbADD1<="00000"; tbADD2<="00001"; tbID_EX_ADDRD<="00000"; tbEX_MEM_ADDRD<="00000"; tbMEM_WB_ADDRD<="00000";
wait for 150 ns;
tbID_EX_RegWrite<='1';
tbinstADDI<='1';
wait for 100 ns;
tbEX_MEM_RegWrite<='1';
tbinstADDI<='0';
tbinstBEQ<='1';
wait for 300 ns;
tbEX_MEM_RegWrite<='0';
tbinstADDI<='0';
wait for 600 ns;
tbinstBEQ<='1';
tbEX_MEM_RegWrite<='1';
tbID_EX_RegWrite<='1';
tbMEM_WB_RegWrite<='1';
tbinstLW<='1';
tbinstXOR<='1';
wait  for 500 ns;

end process;

END bdf_type;