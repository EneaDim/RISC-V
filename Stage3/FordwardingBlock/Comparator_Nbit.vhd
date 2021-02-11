Library ieee;
use ieee.std_logic_1164.all;

ENTITY Comparator_Nbit IS
generic ( N : INTEGER);
PORT (RdAdd, RsAdd: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); --sources and destinations regs addresses
	  equality : OUT STD_LOGIC); --equality signal to indicate if the data input are equal (RsAdd is equal to RdAdd)
END ENTITY;

ARCHITECTURE behavioral OF Comparator_Nbit IS

begin

equality <= '1' when RdAdd = RsAdd else '0';

end architecture;