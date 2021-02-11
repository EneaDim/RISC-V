library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Decoder2TO4 is

  port(
     IN1 : in STD_LOGIC;
     IN2 : in STD_LOGIC;

     EN_ADD : out STD_LOGIC;
     EN_ANDI : out STD_LOGIC;
     EN_SRAI : out STD_LOGIC;
     EN_XOR : out STD_LOGIC);
  
end Decoder2TO4;

architecture beh of Decoder2TO4 is
begin

  EN_ADD <= (NOT(IN1) and NOT(IN2));
  EN_ANDI <= (NOT(IN1) and (IN2));
  EN_SRAI <= ((IN1) and NOT(IN2));
  EN_XOR <= (IN1 and IN2);
  
end beh;
