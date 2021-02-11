library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ff_en is
port( clk : in STD_LOGIC; 
      rst_n : in STD_LOGIC;
      en : in STD_LOGIC;
	a : in std_logic;
	b :out std_logic);
end ff_en;

architecture beh of ff_en is
begin
process(clk)
begin
if (clk'event and clk='1') then
	if (rst_n = '0') then
		b <= '0';
	elsif (en = '1') then
		b <= a;
	end if;
end if;
end process;
end beh;
