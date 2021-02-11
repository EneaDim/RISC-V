library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity REGISTERS_mainblock is
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
	Regwrite: in STD_LOGIC;
	ReadRS1: in STD_LOGIC_VECTOR(4 downto 0);
	ReadRS2: in STD_LOGIC_VECTOR(4 downto 0);
	writereg: in STD_LOGIC_VECTOR(4 downto 0);
	Datawrite: in STD_LOGIC_VECTOR(31 downto 0);
	Readdata1: out STD_LOGIC_VECTOR(31 downto 0);
	Readdata2: out STD_LOGIC_VECTOR(31 downto 0));
end registers_mainblock;


architecture beh of registers_mainblock is

component mux32to1 IS
PORT (X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16,
	 X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31, X32: IN STD_LOGIC_VECTOR(31 DOWNTO 0) ;
	 Sel: IN STD_LOGIC_VECTOR(4 downto 0);
Y: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) ) ;
END component ;

component dec5to32 IS
PORT (x: IN STD_LOGIC_VECTOR(4 DOWNTO 0) ;
enable: IN STD_LOGIC;
z: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) ) ;
END component ;

component register_nbit_clock_n is
generic (N: integer);
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
    enable: in std_logic;
	a : in STD_LOGIC_VECTOR(N-1 downto 0);
	b :out STD_LOGIC_VECTOR(N-1 downto 0));
end component;

signal decodedadd: STD_LOGIC_VECTOR(31 downto 0);
signal rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16,
	 rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd0: STD_LOGIC_VECTOR(31 downto 0);
begin

-- istanzio il decoder dove ho l'indirizzo di scrittura, lui è abilitato quando ho un segnale di regwrite e da un uscita l'indirizzo

WRITEDECODER: dec5to32 port map(x=>writereg, enable=>Regwrite, z=>decodedadd);

-- devo capire come generare 64 registri con il generate, nel frattempo l'ho fatto a mano
-- questi registri sono selezionati dall'indirizzo di scrittura quando devono essere sovrascritti

REG0: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(31), Datawrite, rd0);
REG1: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(30), Datawrite, rd1);------
REG2: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(29), Datawrite, rd2);
REG3: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(28), Datawrite, rd3);
REG4: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(27), Datawrite, rd4);
REG5: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(26), Datawrite, rd5);
REG6: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(25), Datawrite, rd6);
REG7: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(24), Datawrite, rd7);
REG8: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(23), Datawrite, rd8);
REG9: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(22), Datawrite, rd9);
REG10: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(21), Datawrite, rd10);
REG11: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(20), Datawrite, rd11);
REG12: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(19), Datawrite, rd12);
REG13: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(18), Datawrite, rd13);
REG14: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(17), Datawrite, rd14);
REG15: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(16), Datawrite, rd15);
REG16: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(15), Datawrite, rd16);
REG17: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(14), Datawrite, rd17);
REG18: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(13), Datawrite, rd18);
REG19: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(12), Datawrite, rd19);
REG20: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(11), Datawrite, rd20);
REG21: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(10), Datawrite, rd21);
REG22: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(9), Datawrite, rd22);
REG23: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(8),  Datawrite, rd23);
REG24: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(7), Datawrite, rd24);
REG25: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(6), Datawrite, rd25);
REG26: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(5), Datawrite, rd26);
REG27: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(4), Datawrite, rd27);
REG28: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(3), Datawrite, rd28);
REG29: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(2), Datawrite, rd29);
REG30: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(1), Datawrite, rd30);
REG31: register_nbit_clock_n generic map(N=>32) port map(clk, rst_n, decodedadd(0), Datawrite, rd31);




-- ora instanzio i due mux che hanno gli stessi ingressi, cambiano solamente nel selettore

MUX1: mux32to1 port map (rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16,
	 rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, ReadRS1, Readdata1);
	 
MUX2: mux32to1 port map (rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16,
	 rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, ReadRS2, Readdata2);

end beh;
