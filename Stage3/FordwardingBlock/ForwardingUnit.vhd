Library ieee;
use ieee.std_logic_1164.all;

ENTITY ForwardingUnit IS
PORT (MemWbRegwrite, ExMemRegWrite : IN STD_LOGIC;  --signals that indicate the will to write in registers file
	MemWbRdAdd, ExMemRdAdd, IdExRs1Add, IdExRs2Add: IN STD_LOGIC_VECTOR (4 DOWNTO 0); --sources and destinations regs addresses
	ForwardA, ForwardB : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)); --selection signal for ALU sources (indicate the needed to forwarded and if there is, from which stage)
END ENTITY;

ARCHITECTURE structural OF ForwardingUnit IS

signal MemWbRs1_Equal, MemWbRs2_Equal, ExMemRs1_Equal, ExMemRs2_Equal, MemWbRd_Null, ExMemRd_Null, MemWbRd_NotNull, ExMemRd_NotNull : std_logic;

component Comparator_Nbit IS
generic ( N : INTEGER);
PORT (RdAdd, RsAdd: IN STD_LOGIC_VECTOR (4 DOWNTO 0); --sources and destinations regs addresses
	  equality : OUT STD_LOGIC); --equality signal to indicate if the data input are equal (RsAdd is equal to RdAdd)
END component;

component GatesNet IS
PORT (ExMemRegWrite, MemWbRegWrite, MemWbRdNull, ExMemRdNull, MemWbRsEqual, ExMemRsEqual: IN STD_LOGIC; --signal necessary to understand if it's needed forward
	  Forward: OUT STD_LOGIC_VECTOR(1 downto 0)); --selection signal to give in input at the multiplexers
END component;

begin 

COMP_MEMWbRdNull : Comparator_Nbit
generic MAP (N=>5)
PORT MAP (MemWbRdAdd, "00000", MemWbRd_Null);

MemWbRd_NotNull <= Not(MemWbRd_Null);

COMP_ExMEMRdNull : Comparator_Nbit
generic MAP (N=>5)
PORT MAP (ExMemRdAdd, "00000", ExMemRd_Null);

ExMemRd_NotNull <= Not(ExMemRd_Null);

COMP_IdExRs1EQUALTOMemWbRd : Comparator_Nbit
generic MAP (N=>5)
PORT MAP (IdExRs1Add, MemWbRdAdd, MemWbRs1_Equal);

COMP_IdExRs2EQUALTOMemWbRd : Comparator_Nbit
generic MAP (N=>5)
PORT MAP (IdExRs2Add, MemWbRdAdd, MemWbRs2_Equal);

COMP_IdExRs1EQUALTOExMemRd : Comparator_Nbit
generic MAP (N=>5)
PORT MAP (IdExRs1Add, ExMemRdAdd, ExMemRs1_Equal);

COMP_IdExRs2EQUALTOExMemRd : Comparator_Nbit
generic MAP (N=>5)
PORT MAP (IdExRs2Add, ExMemRdAdd, ExMemRs2_Equal);

GatesNetMuxA: GatesNet
port map (ExMemRegWrite, MemWbRegWrite, MemWbRd_NotNull, ExMemRd_NotNull, MemWbRs1_Equal, ExMemRs1_Equal, forwardA);

GatesNetMuxB: GatesNet
port map (ExMemRegWrite, MemWbRegWrite, MemWbRd_NotNull, ExMemRd_NotNull, MemWbRs2_Equal, ExMemRs2_Equal, forwardB);

end architecture;