LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY dec2to4 IS
PORT (w: IN STD_LOGIC_VECTOR(1 DOWNTO 0) ;
enable: IN STD_LOGIC;
y: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) ) ;
END dec2to4 ;


ARCHITECTURE Behavior OF dec2to4 IS
BEGIN
PROCESS (w, enable)
BEGIN
if enable='0' then
	y <= "0000";
	else
	CASE w IS
	WHEN "00" => 
	y <= "1000" ;
	WHEN "01" => 
	y <= "0100" ;
	WHEN "10" => 
	y <= "0010" ;
	WHEN "11" => 
	y <= "0001" ;
	when others => y <= "0000";
END CASE ;
end if;
END PROCESS ;
END Behavior;
