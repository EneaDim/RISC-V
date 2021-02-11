library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;

entity tb_risc_abs is
end entity;

architecture beh of tb_risc_abs is

  component risc_v_abs is
    port(CLK, RSTN, EN: in std_logic;
		loadValue:in std_LOGIC_VECTOR(29 downto 0);
         outMemData : in std_logic_vector (31 downto 0);
	     inMemInstruction: in std_logic_vector(31 downto 0);
         outPC : out std_logic_vector( 31 downto 0);
         MemWriteTOMem, MemReadTOMem: OUT STD_LOGIC;
         inMemDataAddress : out  std_logic_vector (31 downto 0) ;
         inMemData :out std_logic_vector(31 downto 0));
  end component;
  
  signal 	   CLK, RSTN, EN:  std_logic :='0';
  signal       inMemInstruction :  std_logic_vector(31 downto 0);
  signal       outMemData:  std_logic_vector (31 downto 0);
  
  signal       outPC :  std_logic_vector( 31 downto 0); 
  signal       loadValue : std_logic_vector(29 downto 0):="000000000100000000000000000000";     
  signal       MemWriteTOMem, MemReadTOMem:  STD_LOGIC;
  signal       inMemDataAddress :  std_logic_vector(31 downto 0);
  signal       inMemData : std_logic_vector(31 downto 0);
  
begin

  uut : risc_v_abs port map(CLK, RSTN, EN, loadValue, outMemData, inMemInstruction, outPC, MemWriteTOMem, MemReadTOMem ,inMemDataAddress, inMemData );
  
  
  clock_process: process
          
        begin
          
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
        end process;

   reset_process: process
          
        begin
        RSTN <= '0';
        wait for 30 ns;
        RSTN <= '1';
        wait for 100000 ns;
        end process;

   enable_process: process
          
       begin
          
       EN <= '0';
       wait for 330 ns;
       EN <= '1';
       wait for 100000 ns ;
       end process;
	   
inMemInstruction_process: process

begin
         
	wait for  330 ns;
          --addi x16, x0, 7
inMemInstruction<="00000000011100000000100000010011";


wait for 10 ns ;

	--auipc x4, 64528 (0001111110000010000)
inMemInstruction<="00001111110000010000001000010111";

wait for 10 ns ;

          --addi x4, x4, -4 (111111111100)
inMemInstruction<="11111111110000100000001000010011";
		  
wait for 10 ns ;

	--auipc x5, 64528 (1111110000010000)
inMemInstruction<="00001111110000010000001010010111";
		  
wait for 10 ns ;

          --addi x5, x5, 16 (00010000)
inMemInstruction<="00000001000000101000001010010011";
		  
wait for 10 ns ;

          --lui x13, 262144 
inMemInstruction<="01000000000000000000011010110111";
		  
wait for 10 ns ;

          --addi x13, x13, 2 alla 32 
inMemInstruction<="11111111111101101000011010010011";
		  
wait for 10 ns ;

          --beq x16, x0, 24 ()
inMemInstruction<="00000010000010000000100001100011";
		  
wait for 10 ns ;

        --lw x8, 0(x4)
inMemInstruction<="00000000000000100010010000000011";
outMemData <= "00000000000000000000000000000001";

wait for 10 ns ;

          --srai x9, x8, 31 ()
inMemInstruction<="01000001111101000101010010010011";
		  
wait for 20 ns ;
          --xor x10, x8, x9
inMemInstruction<="00000000100101000100010100110011";
		  
wait for 10 ns ;

          --andi x9, x9, 1
inMemInstruction<="00000000000101001111010010010011";
		  
wait for 10 ns ;

          --add x10, x10, x9
inMemInstruction <="00000000100101010000010100110011";
		  
wait for 10 ns ;

          --addi x4, x4, 4
inMemInstruction<="00000000010000100000001000010011";
		  
wait for 10 ns ;

          --addi x16, x16, 2alla32 
inMemInstruction<="11111111111110000000100000010011";
		  
wait for 10 ns ;

	--slt x11, x10, x13
inMemInstruction<="00000000110101010010010110110011";
		  
wait for 10 ns ;

          --beq x11, x0, 4294967278
inMemInstruction<="11111100000001011000111011100011";
		  
wait for 40 ns ;

          --add x13, x10, x0
inMemInstruction<="00000000000001010000011010110011";
		  
wait for 10 ns ;

          --jal x1, 4294967274
inMemInstruction<="11111101010111111111000011101111";
		  
wait for 10 ns ;

          --sw x13, 0x(5)
inMemInstruction<="00000000110100101010000000100011";
		  
wait for 10 ns ;

          --jal x1, 0
inMemInstruction<="00000000000000000000000011101111";
		  
wait for 10 ns ;

          --addi x0, x0, 0
inMemInstruction<="00000000000000000000000000010011";
		  
wait for 100000000 ns;

		 
end process;

        
          
          

end architecture;
