Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
             
ENTITY ALU IS
  generic (N: integer) ; 
PORT (A : in STD_LOGIC_VECTOR (N-1 downto 0);
      B : in STD_LOGIC_VECTOR (N-1 downto 0);

      
      ALU_OP : in STD_LOGIC_VECTOR (2 downto 0);

      RES: out STD_LOGIC_VECTOR (N-1 downto 0));
END ENTITY;

ARCHITECTURE behavior OF ALU IS

signal  en_ADD, en_ANDI, en_SRAI, en_XOR, ALU_OP_ABS : STD_LOGIC;

signal ALU_OP_MUX : STD_LOGIC_VECTOR (1 DOWNTO 0);

signal  enADD, enANDI, enXOR, enSRAI, outADD, outAND, outSRAI, outXOR, outInc, outXOR_fin, inpostxor : STD_LOGIC_VECTOR (31 downto 0);

signal in1ADD, in2ADD, in1AND, in2AND, in1SRAI, in1XOR, in2XOR, in2XOR_fin : STD_LOGIC_VECTOR (31 downto 0);

signal in2SRAI, B_srai,  enSRAI_B: std_LOGIC_VECTOR(4 downto 0);

signal in1_ADD, in2_ADD , out_ADD : signed (31 downto 0);

COMPONENT Decoder2TO4 IS
  
Port (
     IN1 : in STD_LOGIC;
     IN2 : in STD_LOGIC;

     EN_ADD : out STD_LOGIC;
     EN_ANDI : out STD_LOGIC;
     EN_SRAI : out STD_LOGIC;
     EN_XOR : out STD_LOGIC);
END COMPONENT; 

COMPONENT adderSubALUNbit IS
generic(N: integer);
    Port ( IN1 : in  Signed (N-1 downto 0) ;
           IN2 : in  Signed (N-1 downto 0) ;
           CIN : in STD_LOGIC;
           SUM  : out Signed (N-1 downto 0));
END COMPONENT;

COMPONENT andBlock IS
generic(N: integer:= 32);
    Port ( IN1 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           IN2 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           RES  : out STD_LOGIC_VECTOR (N-1 downto 0));
END COMPONENT;

COMPONENT xorBlock IS 
generic(N: integer:= 32);
    Port ( IN1 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           IN2 : in  STD_LOGIC_VECTOR (N-1 downto 0) ;
           RES  : out STD_LOGIC_VECTOR (N-1 downto 0));
END COMPONENT;

component sraiBlock IS
generic(N:integer);
PORT (DATA_IN: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	 SHIFT: IN STD_LOGIC_VECTOR(4 downto 0);
DATA_OUT: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
END component ;

COMPONENT mux4to1 IS 
generic(N: integer := 32 );
       port( A,B,C,D: in std_logic_vector(N-1 downto 0);
             S: in std_logic_vector(1 downto 0);
             Z: out std_logic_vector(N-1 downto 0));
END COMPONENT;

component incrementerBlock is
  generic ( N : integer );
  port ( in1 : in std_logic_vector (N-1 downto 0);

         res : out std_logic_vector (N-1 downto 0));
end component;

component mux2to1Nbit is
  generic ( N : integer );
  port ( A : in std_logic_vector (N-1 downto 0);
         B : in std_logic_vector (N-1 downto 0);
         s : in std_logic;
         Z : out std_logic_vector (N-1 downto 0));
end component;

signal in2dec, selsign, sel_op: std_LOGIC;

BEGIN


In2dec<=ALU_OP(1) or (ALU_OP(2) and ALU_OP(0)); 
-- IN ORDER TO ENABLE THE PROPER OPERATION
DECODER: Decoder2TO4 
PORT MAP ( ALU_OP(0), in2dec, en_ADD, en_ANDI, en_SRAI, en_XOR);


enADD <= en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD & en_ADD;

enANDI <= en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI & en_ANDI;

enSRAI_B <=  en_SRAI & en_SRAI & en_SRAI & en_SRAI & en_SRAI;

enSRAI <=  en_SRAI & en_SRAI & en_SRAI & en_SRAI & en_SRAI &  en_SRAI & en_SRAI & en_SRAI & en_SRAI & en_SRAI &  en_SRAI & en_SRAI & en_SRAI & en_SRAI & en_SRAI &  en_SRAI & en_SRAI & en_SRAI & en_SRAI & en_SRAI &  en_SRAI & en_SRAI & en_SRAI & en_SRAI & en_SRAI &  en_SRAI & en_SRAI & en_SRAI & en_SRAI & en_SRAI &  en_SRAI & en_SRAI;


enXOR <= en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR & en_XOR;


ALU_OP_MUX <= in2dec & ALU_OP(0);

ALU_OP_ABS <= ALU_OP(2) and not(ALU_OP(1)) and ALU_OP(0);

-- IN ORDER TO SELECT THE PROPER ALU_OUTPUT
MUX_4TO1: mux4TO1
  generic map(N => 32 )
port map (outADD, outAND, outSRAI, outXOR_fin, ALU_OP_MUX , RES );

-- IN ORDER TO ENABLE THE INPUT FOR THE ADDER
AND_BLOCK_ADD_A: andBlock
  generic map(N => 32)
  port map (A, enADD, in1ADD);
  in1_ADD <= signed(in1ADD);

AND_BLOCK_ADD_B: andBlock
  generic map(N => 32)
  port map (B, enADD, in2ADD);
  in2_ADD <= signed(in2ADD);

-- IN ORDER TO ENABLE THE INPUT FOR THE AND
AND_BLOCK_AND_A: andBlock
  generic map(N => 32)
port map (A, enANDI, in1AND);

AND_BLOCK_AND_B: andBlock
  generic map(N => 32)
port map (B, enANDI, in2AND);

-- IN ORDER TO ENABLE THE INPUT FOR THE SRAI
AND_BLOCK_SRAI_A: andBlock
  generic map(N => 32)
port map (A, enSRAI, in1SRAI);

B_srai<=B(4 downto 0);

AND_BLOCK_SRAI_B: andBlock
  generic map(N => 5)
port map (B_srai, enSRAI_B, in2SRAI);

-- IN ORDER TO ENABLE THE INPUT FOR THE XOR
AND_BLOCK_XOR_A: andBlock
  generic map(N => 32)
port map (A, enXOR, in1XOR);

AND_BLOCK_XOR_B: andBlock
  generic map(N => 32)
port map (B, enXOR, in2XOR);

-- AND BLOCK
AND_BLOCK: andBlock
  generic map(N => 32)
port map (in1AND, in2AND, outAND);

-- SRAI BLOCK
SRAI_BLOCK: sraiBlock
  generic map(N => 32)
port map  (in1SRAI, in2SRAI, outSRAI);

-- XOR BLOCK
XOR_BLOCK: xorBlock
  generic map(N => 32)
  port map  (in1XOR, in2XOR_fin, outXOR);

---ADD-SUB BLOCK

ADD_SUB: adderSubALUNbit
  generic map(N => 32)
  port map  (in1_ADD, in2_ADD, ALU_OP(2), out_ADD);
outADD <= std_logic_vector(out_ADD);

-- PREPARE ABSOLUTE VALUE

muxPreXor: mux2to1Nbit
  generic map(N=>32)
  port map(in2XOR, "11111111111111111111111111111111", ALU_OP_ABS, in2XOR_fin);

  selsign <= not(in1XOR(31)) and ALU_OP_ABS;
  
muxsign: mux2to1Nbit   generic map(N=>32)
  port map(outXOR, in1XOR, selsign, inpostxor);
  
  sel_op<= selsign or (not (alu_OP(2)) and ALU_OP(1) and ALU_OP(0));
muxPostXor: mux2to1Nbit
  generic map(N=>32)
  port map(outInc, inpostxor, sel_op, outXOR_fin);

incBlock : incrementerBlock
  generic map(N=>32)
  port map(outXOR,outInc);

end behavior;
