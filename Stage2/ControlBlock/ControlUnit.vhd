library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity ControlUnit is
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
end ControlUnit;

architecture Behavioral of ControlUnit is
  
  signal beq_OK : STD_LOGIC;
  signal  add_OK : STD_LOGIC;
  signal  addi_OK :  STD_LOGIC;
    signal slt_OK : STD_LOGIC;
       signal  auipc_OK :  STD_LOGIC;
       signal jal_OK : STD_LOGIC;
        signal lui_OK :  STD_LOGIC;
      signal   srai_OK :  STD_LOGIC;
       signal  andi_OK :  STD_LOGIC;
       signal  xor_OK :  STD_LOGIC;
       signal  lw_OK :  STD_LOGIC;
  signal sw_OK : STD_LOGIC;
  signal abs_OK : std_logic;
  
begin

  beq_OK <= not(func3(0) or func3(1) or func3(2) ) and ((opcode(6) and opcode(5)) and not(opcode(4) or opcode(3) or opcode(2)) and (opcode(1) and opcode(0)) );
  
  --for the branch pay attention if zero if '1' is necessary to determine the
  --next address with the previous data for the immediate generation
  
  add_OK <= (not(func7(6) or func7(5) or func7(4) or func7(3)) and (not(func7(2) or func7(1) or func7(0))) and (not(func3(2) or func3(1) or func3(0)))) and (not(opcode(6) or opcode(3) or opcode(2)) and (opcode(5) and opcode(4) and opcode(1) and opcode(0)));

  addi_OK <= not(func3(2) or func3(1) or func3(0)) and ( not(opcode(6) or opcode(5) or opcode(3) or opcode(2)) and (opcode(4) and opcode(1) and opcode(0)) );


  slt_OK <= ( not(func7(6) or func7(5) or func7(4)) and not(func7(3) or func7(2) or func7(1)) and not(func7(0) or func3(2) or func3(0)) ) and ( not(opcode(6) or opcode(3) or opcode(2)) and ( (func3(1)) and (opcode(5)) and (opcode (4)) ) and ( (opcode(1)) and (opcode(0)) ) );
  
  auipc_OK <= not(opcode(6) or opcode(5) or opcode(3)) and ( (opcode(4)) and (opcode(2)) and (opcode(1)) and (opcode(0)));

  lui_OK <= ( not(opcode(6)) and (opcode(5)) and (opcode(4)) and not(opcode(3)) ) and ( (opcode(2)) and (opcode(1)) and (opcode(0)) ) ;

  srai_OK <= ( not(func7(6) or func7(4) or func7(3)) and not(func7(2) or func7(1) or func7(0)) and not(func3(1) or opcode(6) or opcode(5)) ) and ( not(not(func3(2)) or opcode(3) or opcode(2)) and (func3(0) and opcode(4) and opcode(1)) and (opcode(0)) and func7(5) );

  andi_OK <= (func3(2) and func3(1) and func3(0)) and (opcode(4) and opcode(1) and opcode(0)) and not(opcode(6) or opcode(5) or opcode(3) or opcode(2));
  
  xor_OK <= ( not(func7(6) or func7(5) or func7(4)) and not(func7(3) or func7(2) or func7(1)) ) and ( not(func7(0) or func3(1) or func3(0)) and not(opcode(6) or opcode(3) or opcode(2)) ) and ( (opcode(5) and opcode(4) and opcode(1)) and (opcode(0) and func3(2)) );

  jal_OK <= ( opcode(6) and opcode(5) and not(opcode(4))) and (opcode(3) and opcode(2) and opcode(1) and opcode(0));

  lw_OK <= (func3(1) and opcode(1) and opcode(0)) and not(func3(2) or func3(0) or opcode(6)) and not(opcode(5) or opcode(4) or opcode(3) or opcode(2)) ;

  sw_OK <= ( not(func3(2) or func3(0) or opcode(6)) and not(opcode(4) or opcode(3) or opcode(2)) ) and ( (func3(1) and opcode(5)) and (opcode(1) and opcode(0)) ) ;

  abs_OK <= (not(func7(6) or not(func7(5)) or func7(4) or func7(3)) and (not(func7(2) or func7(1) or func7(0))) and (not(func3(2) or func3(1) or func3(0)))) and (not(opcode(6) or opcode(3) or opcode(2)) and (opcode(5) and opcode(4) and opcode(1) and opcode(0)));


  branch <= jal_ok or (beq_OK and zero);

  alu_src <= add_OK or xor_OK or slt_OK;

  alu_op(0) <=  xor_OK or andi_OK or abs_OK ;

  alu_op(1) <= srai_OK or xor_OK;

  alu_op(2) <= slt_OK or abs_OK;


  mem_wr <= sw_OK;

  mem_rd <= lw_OK;

  mem_to_reg <= lw_OK;

  reg_wr <= add_OK or addi_OK or lui_OK or auipc_OK or lw_OK  or jal_OK or srai_OK or andi_OK or xor_OK or slt_OK or abs_OK;

  controlRS1in <= lui_OK;

  controlRS1out <= jal_OK or auipc_OK;

  --en_add_pc <= (beqOK and zero) or jalOK;

 -- en_ALU <= not(beq_OK);
  
  beqOK <= beq_OK;
  addOK <= add_OK;
  addiOK  <= addi_OK;
  sltOK <= slt_OK;
  auipcOK <= auipc_OK;
  luiOK <= lui_OK;
  jalOK <= jal_OK;
  sraiOK <= srai_OK;
  andiOK <= andi_OK;
  xorOK <= xor_OK;
  lwOK <= lw_OK;
  swOK <= sw_OK;
  absOK<= abs_OK;
  
  end Behavioral;
