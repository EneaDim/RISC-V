library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux2to1Nbit is
  generic ( N : integer );
  port ( A : in std_logic_vector (N-1 downto 0);
         B : in std_logic_vector (N-1 downto 0);
         s : in std_logic;
         Z : out std_logic_vector (N-1 downto 0));
  end entity;

  architecture beh of mux2to1Nbit is
begin
PROCESS(a,b,S)
BEGIN
CASE S IS
WHEN'0'=>Z<=A;
WHEN'1'=>Z<=B;

WHEN OTHERS=>
Z<=A;
END CASE;
END PROCESS;
      
    end architecture;
