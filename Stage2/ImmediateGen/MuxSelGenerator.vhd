library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY MUXSELGenerator IS
 
	PORT ( Rformat, Uformat, Iformat, IbutnotSRAIformat, SBformat, UJformat, Sformat: IN STD_LOGIC;
			 sel31_20, sel19_12,  sel10_5 : OUT STD_LOGIC; 
			 sel11, sel4_1, sel0: out std_logic_vector(1 downto 0));
END MUXSELGenerator;

ARCHITECTURE combinational OF MUXSELGenerator IS

BEGIN
		
	sel31_20 <= Uformat;
	sel19_12 <= Uformat or UJformat;
	sel10_5 <= not(IbutnotSRAIformat or Sformat or SBformat or UJformat);
	sel11(1) <= not(UJformat or SBformat);
	sel11(0) <= not(UJformat or Uformat);
	sel4_1(1) <= Rformat or Uformat;
	sel4_1(0) <= Sformat or SBformat;
	sel0(1) <= not(Iformat or Sformat);
	sel0(0) <= Sformat;

		
END combinational;