LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY mux32to1 IS
PORT (X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16,
	 X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31, X32: IN STD_LOGIC_VECTOR(31 DOWNTO 0) ;
	 Sel: IN STD_LOGIC_VECTOR(4 downto 0);
Y: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) ) ;
END mux32to1 ;

ARCHITECTURE Behavior OF mux32to1 IS
-- istanzio il mux 64 to 1 usando 4 mux 8 to 1 (3 in parallelo all'inizio e uno in serie

component MUX8_1 IS
generic(N: integer);
PORT(A,B,C,D,E,F,G,H:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
SEL:IN STD_LOGIC_VECTOR(2 DOWNTO 0);
DOUT:OUT STD_LOGIC_VECTOR(N-1 downto 0));
END component;

component mux4to1 is
		generic(N: integer);
       port( A,B,C,D: in std_logic_vector(N-1 downto 0);
             S: in std_logic_vector(1 downto 0);
             Z: out std_logic_vector(N-1 downto 0));
END component;


signal SEL1: STD_LOGIC_VECTOR(2 downto 0);
signal SEL2: STD_LOGIC_VECTOR (1 downto 0);
signal Y1, Y2, Y3, Y4: STD_LOGIC_VECTOR(31 downto 0);
begin

SEL1<=SEL(2 downto 0);
SEL2<=SEL(4 downto 3);

Mux1: MUX8_1 generic map(N=>32) port map(X1, X2, X3, X4, X5, X6, X7, X8, SEL1, Y1);
Mux2: MUX8_1 generic map(N=>32) port map(X9, X10, X11, X12, X13, X14, X15, X16, SEL1, Y2);
Mux3: MUX8_1 generic map(N=>32) port map(X17, X18, X19, X20, X21, X22, X23, X24, SEL1, Y3);
Mux4: MUX8_1 generic map(N=>32) port map(X25, X26, X27, X28, X29, X30, X31, X32, SEL1, Y4);

Muxfin: mux4to1  generic map(N=>32) port map(Y1, Y2, Y3, Y4,  SEL2, Y);

end behavior;
