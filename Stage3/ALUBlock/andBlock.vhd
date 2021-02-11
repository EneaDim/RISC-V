library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity andBlock is
generic(N: integer );
    Port ( IN1 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           IN2 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           RES  : out STD_LOGIC_VECTOR (N-1 downto 0));
end andBlock;

architecture Behavioral of andBlock is

begin
    
  GEN: for I in 0 to N-1 GENERATE
    RES(I) <= IN1(I) and IN2(I);
  end GENERATE;
    
End Behavioral;
