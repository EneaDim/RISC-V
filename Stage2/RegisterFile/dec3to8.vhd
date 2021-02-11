LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY dec3to8 IS
PORT (w: IN STD_LOGIC_VECTOR(2 DOWNTO 0) ;
enable: IN STD_LOGIC;
y: OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
END dec3to8 ;


ARCHITECTURE Behavior OF dec3to8 IS
BEGIN
PROCESS (w, enable)
BEGIN
if enable='0' then
	y <= "00000000";
	else
	CASE w IS
	WHEN "000" => 
	y <= "10000000" ;
	WHEN "001" => 
	y <= "01000000" ;
	WHEN "010" => 
	y <= "00100000" ;
	WHEN "011" => 
	y <= "00010000" ;
	WHEN "100" => 	
	y <= "00001000" ;
	WHEN "101" => 
	y <= "00000100" ;
	WHEN "110" => 
	y <= "00000010" ;
	WHEN "111" => 
	y <= "00000001" ;
	when others => y <= "00000000";
END CASE ;
end if;
END PROCESS ;
END Behavior;
