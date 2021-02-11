library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity register_nbit_clock_n is
generic (N: integer);
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
    enable : in std_logic;
	a : in STD_LOGIC_VECTOR(N-1 downto 0);
	b :out STD_LOGIC_VECTOR(N-1 downto 0));
end register_nbit_clock_n;

architecture beh of register_nbit_clock_n is
begin
process(clk)
begin
if (clk'event and clk='0') then
        if (rst_n = '0') then
                b <= (others => '0');
        elsif (enable = '1') then
                b <= a;
        end if;
end if;

end process;
end beh;
