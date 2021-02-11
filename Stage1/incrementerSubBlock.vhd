library ieee;
use ieee.std_logic_1164.all;

entity incrementerSubBlock is
  port ( in1 : in std_logic;
         in2 : in std_logic;

         res : out std_logic;
         cout: out std_logic);
  end entity;

  architecture struct of incrementerSubBlock is

    begin

      res <= in1 xor in2 ;
      cout <= in1 and in2 ;
      
     end architecture;
      
