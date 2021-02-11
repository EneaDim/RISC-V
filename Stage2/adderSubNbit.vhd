library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adderSubNbit is
generic(N: integer );
    Port ( IN1 : in  signed (N-1 downto 0) ;
           IN2 : in  signed (N-1 downto 0) ;
           SUM  : out signed (N-1 downto 0));
end adderSubNbit;

architecture Behavioral of adderSubNbit is
begin
    
    SUM <= IN1 + IN2;
    
End Behavioral;
