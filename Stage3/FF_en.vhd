library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FF_en is
port( clk : in STD_LOGIC; 
      rst_n : in STD_LOGIC;
      en : in STD_LOGIC;
	a : in std_logic;
	b :out std_logic);
end FF_en;

architecture beh of FF_en is
begin
process(clk)
begin
if (clk'event and clk='1' and rst_n = '0') then
	b <= '0';
end if;
if (clk'event and clk='1' and en = '1') then
        b <= a;
end if;
end process;
end beh;
