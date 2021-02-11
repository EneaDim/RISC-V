Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY ImmediateGenerator IS
PORT (ADD, XORinst, SLT, AUIPC, LUI, ADDI, LW, ANDI, SRAI, BEQ, JAL, SW, ABSV: IN STD_LOGIC;  --signals that indicate the instruction
	instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0); --instruction sampled from the instruction memory
	Immediate : out  STD_LOGIC_VECTOR (31 DOWNTO 0));-- SIGNED (31 DOWNTO 0)); --immediate value properly generated depending on the instruction in input
END ENTITY;

ARCHITECTURE structural OF ImmediateGenerator IS

signal imm: std_LOGIC_VECTOR(31 downto 0);
signal inst31_20, imm31_20, inst31exp11: std_LOGIC_VECTOR(11 downto 0);
signal inst20, inst7,  imm11, imm0 : std_logic;
signal inst19_12, imm19_12, inst31exp8: std_LOGIC_VECTOR(7 downto 0);
signal inst30_25, imm10_5: std_LOGIC_VECTOR(5 downto 0);
signal inst24_21, inst11_8, imm4_1: std_LOGIC_VECTOR(3 downto 0);
signal Rtype, Utype, Itype, IbutnotSRAItype, SBtype, UJype, Stype: std_LOGIC; 
signal sel31_20, sel19_12,  sel10_5: std_LOGIC;
signal sel11, sel4_1, sel0: std_logic_vector(1 downto 0);

component mux2to1Nbit IS
	generic(N: integer );
	PORT (	A,B : IN STD_LOGIC_VECTOR(N-1 downto 0);
				S: in std_LOGIC;
				Z : OUT STD_LOGIC_vector(N-1 downto 0)); 
END component;

component mux4to1 is
		generic(N: integer );
       port( A,B,C,D: in std_logic_vector(N-1 downto 0);
             S: in std_logic_vector(1 downto 0);
             Z: out std_logic_vector(N-1 downto 0));
end component;

component mux4to1_1bit is
       port( A,B,C,D: in std_logic;
             S: in std_logic_vector(1 downto 0);
             Z: out std_logic);

end component;

component FormatDetector IS
 
	PORT (instADD, instXOR, instSLT, InstAUIPC, instLUI, instADDI, instLW, instANDI, instSRAI, instBEQ, instJAL, instSW, instABS : IN STD_LOGIC;
			Rformat, Uformat, Iformat, IbutnotSRAIformat, SBformat, UJformat, Sformat : OUT STD_LOGIC); 
end component;

component MUXSELGenerator IS
 
	PORT ( Rformat, Uformat, Iformat, IbutnotSRAIformat, SBformat, UJformat, Sformat: IN STD_LOGIC;
			 sel31_20, sel19_12,  sel10_5 : OUT STD_LOGIC; 
			 sel11, sel4_1, sel0: out std_logic_vector(1 downto 0));
END component;

begin 

inst31_20 <= instruction(31 downto 20);
inst19_12 <= instruction(19 downto 12);
inst30_25 <= instruction(30 downto 25);
inst24_21 <= instruction(24 downto 21);
inst11_8 <= instruction(11 downto 8);
inst20 <= instruction(20);
inst7 <= instruction(7);
inst31exp8(7) <= instruction(31);
inst31exp8(6) <= instruction(31);
inst31exp8(5) <= instruction(31);
inst31exp8(4) <= instruction(31);
inst31exp8(3) <= instruction(31);
inst31exp8(2) <= instruction(31);
inst31exp8(1) <= instruction(31);
inst31exp8(0) <= instruction(31);
inst31exp11(7 downto 0)<= inst31exp8;
inst31exp11(8) <= instruction(31);
inst31exp11(9) <= instruction(31);
inst31exp11(10) <= instruction(31);
inst31exp11(11) <= instruction(31);

 FD: FormatDetector
PORT MAP (ADD, XOrinst, SLT, AUIPC, LUI, ADDI, LW, ANDI, SRAI, BEQ, JAL, SW, ABSV, Rtype, Utype, Itype, IbutnotSRAItype, SBtype, UJype, Stype);

MSG : MUXSELGenerator
PORT MAP (Rtype, Utype, Itype, IbutnotSRAItype, SBtype, UJype, Stype, sel31_20, sel19_12,  sel10_5, sel11, sel4_1, sel0);

MUX30_20 : mux2to1Nbit
generic MAP (N=>12)
PORT MAP (inst31exp11, inst31_20, sel31_20, imm31_20);

MUX19_12 : mux2to1Nbit
generic MAP (N=>8)
PORT MAP (inst31exp8, inst19_12, sel19_12, imm19_12);

MUX4_1 : MUx4TO1
generic MAP (N=>4)
PORT MAP (inst24_21, inst11_8, "0000", "0000", sel4_1, imm4_1);

MUX11 : MUx4TO1_1bit
PORT MAP ( inst20, inst7, '0', instruction(31), sel11, imm11);

MUX10_5 : mux2to1Nbit
generic map (N=>6)
PORT MAP ( inst30_25, "000000", sel10_5, imm10_5);

MUX0 : MUx4TO1_1bit
PORT MAP ( inst20, inst7, '0', '0', sel0, imm0);

imm(31 downto 20) <= imm31_20;
imm(19 downto 12) <= imm19_12; 
imm(11) <= imm11; 
imm(10 downto 5) <= imm10_5;
imm(4 downto 1) <= imm4_1;
imm(0) <= imm0;

--immediate<=signed(imm);
immediate <= imm;
end architecture;
