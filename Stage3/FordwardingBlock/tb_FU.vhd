LIBRARY ieee;
USE ieee.std_logic_1164.all; 

--LIBRARY work;

entity tb_FU is
end tb_FU;



ARCHITECTURE bdf_type OF tb_FU IS 



component ForwardingUnit IS
PORT (MemWbRegwrite, ExMemRegWrite : IN STD_LOGIC;  --signals that indicate the will to write in registers file
	MemWbRdAdd, ExMemRdAdd, IdExRs1Add, IdExRs2Add: IN STD_LOGIC_VECTOR (4 DOWNTO 0); --sources and destinations regs addresses
	ForwardA, ForwardB : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --selection signal for ALU sources (indicate the needed to forwarded and if there is, from which stage)
END component;

signal MemWb_Regwrite, ExMem_RegWrite  :  STD_LOGIC;
signal MemWb_RdAdd, ExMem_RdAdd, IdEx_Rs1Add, IdEx_Rs2Add :  STD_LOGIC_VECTOR(4 downto 0) ;
signal Forward_A, Forward_B : STD_LOGIC_VECTOR (1 DOWNTO 0);

begin

uut: ForwardingUnit PORT MAP (MemWb_Regwrite, ExMem_RegWrite, MemWb_RdAdd, ExMem_RdAdd, IdEx_Rs1Add, IdEx_Rs2Add, Forward_A, Forward_B);

--process
--begin
	--wait for 200 ns;
	--CLK<= not CLK;
--end process;


process
begin

wait for 400 ns;  --test case in which ExMemRdAdd and MemWb_RdAdd are equal to zero
MemWb_Regwrite <= '0';
ExMem_RegWrite <= '0';
MemWb_RdAdd <= "00000";
ExMem_RdAdd <= "00000";
IdEx_Rs1Add <= "10100";
IdEx_Rs2Add <= "10100";


wait for 400 ns;  --test case in which Rs1 and Rs2 are equal to ExMemRdAdd
MemWb_Regwrite <= '0';
ExMem_RegWrite <= '1';
MemWb_RdAdd <= "00000";
ExMem_RdAdd <= "10100";
IdEx_Rs1Add <= "10100";
IdEx_Rs2Add <= "10100";

wait for 400 ns;  --test case in which MemWbRdAdd are null and Rs1Add is equal to ExMemRdAdd
MemWb_Regwrite <= '0';
ExMem_RegWrite <= '1';
MemWb_RdAdd <= "00000";
ExMem_RdAdd <= "10100";
IdEx_Rs1Add <= "10100";
IdEx_Rs2Add <= "10100";

wait for 400 ns; --test case in which Rs1Add is equal to ExMemRdAdd and Rs2Add is equal to MemWbRdAdd
MemWb_Regwrite <= '1';
ExMem_RegWrite <= '1';
MemWb_RdAdd <= "10100";
ExMem_RdAdd <= "10000";
IdEx_Rs1Add <= "10000";
IdEx_Rs2Add <= "10100";

wait for 400 ns;  --test case in which RS1Add and Rs2Add are equal to RdAdd but it is null
MemWb_Regwrite <= '1';
ExMem_RegWrite <= '1';
MemWb_RdAdd <= "00000";
ExMem_RdAdd <= "00000";
IdEx_Rs1Add <= "00000";
IdEx_Rs2Add <= "00000";


end process;

END bdf_type;
