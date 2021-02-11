library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity mux4to1 is
		generic(N: integer );
       port( A,B,C,D: in std_logic_vector(N-1 downto 0);
             S: in std_logic_vector(1 downto 0);
             Z: out std_logic_vector(N-1 downto 0));

end mux4to1;

architecture Behavioral of mux4to1 is
begin


	process(S, A, B, C, D)
begin
case S is
	when "00" => Z <= A;
	when "01" => Z <= B;
	when "10" => Z <= C;
	when "11" => Z <= D;
	when others => Z <= A;
	end case;
	END PROCESS;
	
	
	end Behavioral;