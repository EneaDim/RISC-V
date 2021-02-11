library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adderSubALUNBIT is
generic(N: integer );
    Port ( IN1 : in  signed (N-1 downto 0) ;
           IN2 : in  signed (N-1 downto 0) ;
           CIN : in STD_LOGIC;
           SUM  : out signed (N-1 downto 0));
end adderSubALUNBIT;

architecture Behavioral of adderSubALUNBIT is
signal cin_sign : std_LOGIC; 

signal sum_sign : signed (N-1 downto 0);
begin

process (CIN, cin_sign, IN1, IN2, sum_sign)
variable sum_var : signed(N-1 downto 0);
    begin
	cin_sign<=cin; 
			if CIN_sign = '0' then 
				SUM_var := IN1 + IN2;
			elsif CIN_sign = '1' then
				sum_var := IN1 - IN2;
				if sum_var(31) = '1' then 
				sum_var := "11111111111111111111111111111111";
				else
				sum_var := "00000000000000000000000000000000";
				end if;
			else
				sum_var:=sum_var;
			end if;
			sum_sign<=sum_var;
end process; 

sum<=sum_sign;  
End Behavioral;
