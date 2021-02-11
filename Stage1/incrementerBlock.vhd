library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity incrementerBlock is
  generic ( N : integer );
  port ( in1 : in std_logic_vector (N-1 downto 0);

         res : out std_logic_vector (N-1 downto 0));
  end entity;

  architecture struct of incrementerBlock is

  signal connection : std_logic_vector(N-2 downto 0);
      
  component incrementerSubBlock is
     port ( in1 : in std_logic;
         in2 : in std_logic;

         res : out std_logic;
         cout: out std_logic);
  end component;

  begin

    res(0) <= not(in1(0));
    connection(0) <= in1(0);
    genSubBlock : for I in 1 to N-2 GENERATE
      subBlock: incrementerSubBlock port map ( in1(I), connection(I-1), res(I), connection(I) );
      end GENERATE;

    res(N-1) <= in1(N-1) xor connection(N-2);
      
  end;
      
                        
