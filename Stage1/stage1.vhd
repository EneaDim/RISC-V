library ieee;
use ieee.std_logic_1164.all;

entity stage1 is
 generic ( N : integer := 32 );
  port ( CLK : in std_logic;
         RSTN : in std_logic;
         EN_PC : in std_logic;
         EN_PIPE_PC : in std_logic;
         EN_PIPE_Instruction : in std_logic;
         selJump : in std_logic;
			loadValue: in std_LOGIC_VECTOR(N-3 downto 0);
         outMemInstruction : in std_logic_vector(N-1 downto 0);--(31 downto 0);--
         targetAddJump : in std_logic_vector(N-3 downto 0);--(29 downto 0);--

         outPC : out std_logic_vector(N-1 downto 0);--(31 downto 0);--
         outMemInstructionPipe : out std_logic_vector(N-1 downto 0);--(31 downto 0);--(N-1 downto 0);
         outPipeRegPC : out std_logic_vector(N-3 downto 0));--(29 downto 0));--(N-3 downto 0));
  end entity;

  architecture struct of stage1 is


    signal targetAddress : std_logic_vector(N-3 downto 0);--(29 downto 0);--(N-3 downto 0); -- -1 -2 (lsb_bit)
    signal targetAddressSeq :  std_logic_vector(N-3 downto 0);--(29 downto 0);--(N-3 downto 0);
    signal targetAddPC : std_logic_vector(N-3 downto 0);--(29 downto 0);--(N-3 downto 0);
	 signal out_PC: std_LOGIC_VECTOR(N-3 downto 0);
   
	 
	 
component registerNbit is
generic (N: integer);
port( clk : in STD_LOGIC; 
	rst_n : in STD_LOGIC;
        enable : in std_logic;
	a : in std_logic_vector(N-1 downto 0);
	b :out std_logic_vector(N-1 downto 0));
end component;

component PC is
			generic (N: integer);
			port( clk : in STD_LOGIC; 
					rst_n : in STD_LOGIC;
					enable : in std_logic;
					loadValue : in std_logic_vector(N-1 downto 0);
					a : in std_logic_vector(N-1 downto 0);
					b :out std_logic_vector(N-1 downto 0));
end component;

    component mux2to1Nbit is
        generic ( N : integer );
          port ( A : in std_logic_vector (N-1 downto 0);
                 B : in std_logic_vector (N-1 downto 0);
                 s : in std_logic;
                 Z : out std_logic_vector (N-1 downto 0));
     end component;

    component incrementerBlock is
        generic ( N : integer );
          port ( in1 : in std_logic_vector (N-1 downto 0);
                 res : out std_logic_vector (N-1 downto 0));
    end component;

    begin
		
		
      ProgramCounter : PC generic map(N => 30) port map (CLK, RSTN, EN_PC, loadValue, targetAddress, targetAddPC );
      out_PC <= targetAddPC;
		
		outPC<=out_PC & '0' & '0';

      Mux : mux2to1Nbit generic map(N => 30) port map (targetAddressSeq, targetAddJump, selJump, targetAddress );

      Incrementer : incrementerBlock generic map( N => 30 ) port map (out_pc, targetAddressSeq );

      IF_ID_PC : registerNbit generic map ( N => 30) port map (CLK, RSTN,  EN_PIPE_PC, out_pc, outPipeRegPC);

      IF_ID_instruction : registerNbit generic map ( N => 32) port map (CLK, RSTN,  EN_PIPE_Instruction, outMemInstruction, outMemInstructionPipe);
      
    end architecture;
                                                   
