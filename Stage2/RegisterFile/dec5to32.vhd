LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY dec5to32 IS
PORT (x: IN STD_LOGIC_VECTOR(4 DOWNTO 0) ;
enable: IN STD_LOGIC;
z: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) ) ;
END dec5to32 ;


ARCHITECTURE Behavior OF dec5to32 IS

component dec3to8 is
PORT (w: IN STD_LOGIC_VECTOR(2 DOWNTO 0) ;
enable: IN STD_LOGIC;
y: OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
END component;
	
component dec2to4 IS
PORT (w: IN STD_LOGIC_VECTOR(1 DOWNTO 0) ;
enable: IN STD_LOGIC;
y: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) ) ;
END	component;
	
signal enabledecoders: STD_LOGIC_VECTOR(7 downto 0);	
signal enable1, enable2, enable3, enable4, enable5, enable6, enable7, enable8: STD_LOGIC;	
signal ingresso1 : STD_LOGIC_VECTOR(2 downto 0);
signal ingressi2: STD_LOGIC_VECTOR(1 downto 0);
signal out1, out2, out3, out4, out5, out6, out7, out8: STD_LOGIC_VECTOR(3 downto 0);
BEGIN

ingresso1<=x(4 downto 2);
ingressi2<=x(1 downto 0);

enable1<=enabledecoders(0);
enable2<=enabledecoders(1);
enable3<=enabledecoders(2);
enable4<=enabledecoders(3);
enable5<=enabledecoders(4);
enable6<=enabledecoders(5);
enable7<=enabledecoders(6);
enable8<=enabledecoders(7);

z(3 downto 0)<=out1;
z(7 downto 4)<=out2;
z(11 downto 8)<=out3;
z(15 downto 12)<=out4;
z(19 downto 16)<=out5;
z(23 downto 20)<=out6;
z(27 downto 24)<=out7;
z(31 downto 28)<=out8;

FIRSTDEC: dec3to8 port map(w=>ingresso1, y=>enabledecoders, enable=>enable);
DEC1: dec2to4 port map (w=>ingressi2, y=>out1, enable=>enable1);
DEC2: dec2to4 port map (w=>ingressi2, y=>out2, enable=>enable2);
DEC3: dec2to4 port map (w=>ingressi2, y=>out3, enable=>enable3);
DEC4: dec2to4 port map (w=>ingressi2, y=>out4, enable=>enable4);
DEC5: dec2to4 port map (w=>ingressi2, y=>out5, enable=>enable5);
DEC6: dec2to4 port map (w=>ingressi2, y=>out6, enable=>enable6);
DEC7: dec2to4 port map (w=>ingressi2, y=>out7, enable=>enable7);
DEC8: dec2to4 port map (w=>ingressi2, y=>out8, enable=>enable8);

END Behavior;
