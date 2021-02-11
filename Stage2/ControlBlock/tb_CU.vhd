LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY work;

entity tb_CU is
end tb_CU;



ARCHITECTURE test OF tb_CU IS 



COMPONENT ControlUnit is
    Port (
    opcode : in STD_LOGIC_VECTOR (6 downto 0);
  func3 : in STD_LOGIC_VECTOR (2 downto 0);
  func7 : in STD_LOGIC_VECTOR (6 downto 0);
  zero : in STD_LOGIC ;

  beqOK : out STD_LOGIC;
  addOK : out STD_LOGIC;
  addiOK : out STD_LOGIC;
  sltOK : out STD_LOGIC;
  auipcOK : out STD_LOGIC;
  luiOK : out STD_LOGIC;
  jalOK : out STD_LOGIC;
  sraiOK : out STD_LOGIC;
  andiOK : out STD_LOGIC;
  xorOK : out STD_LOGIC;
  lwOK : out STD_LOGIC;
  swOK : out STD_LOGIC;
  absOK : out STD_LOGIC;


  branch: out STD_LOGIC;
  alu_src : out STD_LOGIC;
  alu_op : out STD_LOGIC_VECTOR(2 downto 0);
  mem_wr : out STD_LOGIC;
  mem_rd : out STD_LOGIC;
  mem_to_reg : out STD_LOGIC;
  reg_wr : out STD_LOGIC;
  controlRS1in : out STD_LOGIC;
  controlRS1out : out STD_LOGIC
);
end component;

signal opcode : STD_LOGIC_VECTOR (6 downto 0);
signal  func3 : STD_LOGIC_VECTOR (2 downto 0);
signal  func7 : STD_LOGIC_VECTOR (6 downto 0);
signal zero :  STD_LOGIC;
signal beqOK:  STD_LOGIC;
signal  addOK:  STD_LOGIC;
signal  addiOK :  STD_LOGIC;
signal  sltOK:  STD_LOGIC;
signal  auipcOK :  STD_LOGIC;
signal  luiOK :  STD_LOGIC;
signal  sraiOK :  STD_LOGIC;
signal  andiOK :  STD_LOGIC;
signal  xorOK :  STD_LOGIC;
signal  jalOK: STD_LOGIC;
signal  lwOK:  STD_LOGIC;
signal  swOK, absOK : STD_LOGIC;

signal branch:  STD_LOGIC;
signal  alu_src : STD_LOGIC;
signal  alu_op : STD_LOGIC_VECTOR(2 downto 0);
signal  mem_wr : STD_LOGIC;
signal  mem_rd : STD_LOGIC;
signal  mem_to_reg : STD_LOGIC;
signal  reg_wr : STD_LOGIC;
signal controlRS1in : STD_LOGIC;
signal  controlRS1out : STD_LOGIC;
--signal en_add_pc :  STD_LOGIC;
--signal  en_ALU :  STD_LOGIC;

begin

uut: ControlUnit PORT MAP (opcode,func3,func7,zero,
beqOK,
  addOK ,
  addiOK ,
  sltOK , 
  auipcOK ,
  luiOK ,
  jalOK,
  sraiOK ,
  andiOK ,
  xorOK ,
  lwOK,
  swOK,
  absOK,
  branch,
  alu_src,
  alu_op,
  mem_wr,
  mem_rd,
  mem_to_reg,
  reg_wr,
  controlRS1in,
  controlRS1out);

process
begin

  wait for 100 ns;
  opcode <= "0000000";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '0';

  -- BEQ_FALSE
   wait for 100 ns;
  opcode <= "1100011";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '0';


   -- BEQ_TRUE
   wait for 100 ns;
  opcode <= "1100011";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '1';
  
 -- ADD
   wait for 100 ns;
  opcode <= "0110011";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '0';
  
  -- ADDI
   wait for 100 ns;
  opcode <= "0010011";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '0';

 -- SLT
   wait for 100 ns;
  opcode <= "0110011";
  func3  <= "010";
  func7  <= "0000000";
  zero <= '0';

 -- AUPIC
   wait for 100 ns;
  opcode <= "0010111";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '0';

  -- LUI
   wait for 100 ns;
  opcode <= "0110111";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '0';

  -- SRAI
   wait for 100 ns;
  opcode <= "0010011";
  func3  <= "101";
  func7  <= "0100000";
  zero <= '0';
  
  -- ANDI
   wait for 100 ns;
  opcode <= "0010011";
  func3  <= "111";
  func7  <= "0000000";
  zero <= '0';

  -- XOR
   wait for 100 ns;
  opcode <= "0110011";
  func3  <= "100";
  func7  <= "0000000";
  zero <= '0';

  -- JAL
   wait for 100 ns;
  opcode <= "1101111";
  func3  <= "000";
  func7  <= "0000000";
  zero <= '0';

  -- LW
   wait for 100 ns;
  opcode <= "0000011";
  func3  <= "010";
  func7  <= "0000000";
  zero <= '0';

  -- SW
   wait for 100 ns;
  opcode <= "0100011";
  func3  <= "010";
  func7  <= "0000000";
  zero <= '0';

end process;
end test;
