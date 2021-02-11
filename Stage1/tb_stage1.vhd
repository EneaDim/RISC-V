library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity tb_stage1 is
end entity;

architecture test of tb_stage1 is

component stage1 is
 -- generic ( N : integer := 32 );
  port ( CLK : in std_logic;
         RSTN : in std_logic;
         EN_PC : in std_logic;
         EN_PIPE_PC : in std_logic;
         EN_PIPE_Instruction : in std_logic;
         
         selJump : in std_logic;
         outMemInstruction : in std_logic_vector(31 downto 0);--(N-1 downto 0);
         targetAddJump : in std_logic_vector(29 downto 0);--(N-3 downto 0);

         outPC : out std_logic_vector(31 downto 0);--(N-1 downto 0);
         outMemInstructionPipe : out std_logic_vector(31 downto 0);--(N-1 downto 0);
         outPipeRegPC : out std_logic_vector(29 downto 0));--(N-3 downto 0));
  end component;

     constant N : integer := 32;
     signal CLK :  std_logic;
     signal   RSTN :  std_logic;
     signal     EN_PC :  std_logic;
     signal     EN_PIPE_PC :  std_logic;
     signal    EN_PIPE_Instruction :  std_logic;
         
     signal    selJump :  std_logic;
     signal    outMemInstruction :  std_logic_vector(N-1 downto 0);
     signal    targetAddJump :  std_logic_vector(N-3 downto 0);

     signal   outPC :  std_logic_vector(N-1 downto 0);
     signal   outMemInstructionPipe :  std_logic_vector(N-1 downto 0);
     signal    outPipeRegPC :  std_logic_vector(N-3 downto 0);

     --constant clock_period : time := 10 ns;

  begin

    uut: stage1 port map (CLK,
         RSTN,
         EN_PC ,
         EN_PIPE_PC,
         EN_PIPE_Instruction ,
         
         selJump,
         outMemInstruction,
         targetAddJump,
         outPC,
         outMemInstructionPipe,
         outPipeRegPC);

  
        clock_process: process
          
        begin
          
        CLK <= '0';
        wait for 5 ns;
         CLK <= '1';
        wait for 5 ns;
        end process;

process 
    begin
         RSTN <= '0';
         EN_PC <= '0';
         EN_PIPE_PC <= '0';
         EN_PIPE_Instruction <= '0';
         
         selJump <= '0';
         outMemInstruction  <= "00000000000000000000000000000000";
         targetAddJump <= "000000000000000000000000000000";


        wait for 200 ns;

                  

         RSTN <= '1';
         EN_PC <= '1';
         EN_PIPE_PC <= '1';
         EN_PIPE_Instruction <= '1';
         
         selJump <= '0';
         outMemInstruction  <= "00000000000000001000000000110011";
         targetAddJump <= "000000000000000000000000000000";


        wait for 200 ns;

                  
         RSTN <= '1';
         EN_PC <= '0';
         EN_PIPE_PC <= '1';
         EN_PIPE_Instruction <= '1';
        
         selJump <= '0';
         selJump <= '0';
         outMemInstruction  <= "00000000000000001000000000110011";
         targetAddJump <= "000000000000000000000000000000";

        wait for 200 ns;

                  
         RSTN <= '1';
         EN_PC <= '1';
         EN_PIPE_PC <= '1';
         EN_PIPE_Instruction <= '1';
         
         selJump <= '0';
         outMemInstruction  <= "00000000000000000000000000000000";
         targetAddJump <= "000000000000000000000000000000";

        wait for 200 ns;
end process;
end test;
