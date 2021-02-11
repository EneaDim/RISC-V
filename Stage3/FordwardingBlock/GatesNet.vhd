Library ieee;
use ieee.std_logic_1164.all;

ENTITY GatesNet IS
PORT (ExMemRegWrite, MemWbRegWrite, MemWbRdNull, ExMemRdNull, MemWbRsEqual, ExMemRsEqual: IN STD_LOGIC; --signal necessary to understand if it's needed forward
	  Forward: OUT STD_LOGIC_VECTOR(1 downto 0)); --selection signal to give in input at the multiplexers
END ENTITY;

ARCHITECTURE combinational OF GatesNet IS

signal NotExMemRegWrite, NotMemWbRegWrite, NotMemWbRdNull, NotExMemRdNull, NotMemWbRsEqual, NotExMemRsEqual: std_logic;
signal AND1S1, AND2S1, AND3S1, AND4S, AND5S1, AND1S2, AND2S2, AND3S2, AND5S2, ORS1, ORS2: std_logic;

begin 

NotExMemRegWrite <= NOT(ExMemRegWrite);
NotMemWbRegWrite <= NOT(MemWbRegWrite);
NotMemWbRdNull <= NOT(MemWbRdNull);
NotExMemRdNull <= NOT(ExMemRdNull);
NotMemWbRsEqual <= NOT(MemWbRsEqual);
NotExMemRsEqual <= NOT(ExMemRsEqual);

AND1S1 <= NotExMemRegWrite and MemWbRegWrite and MemWbRdNull and MemWbRsEqual;
AND2S1 <= MemWbRdNull and NotExMemRsEqual and MemWbRsEqual;
AND3S1 <= NotExMemRdNull and MemWbRdNull and MemWbRsEqual;
AND4S <= ExMemRegWrite and MemWbRegWrite;
ORS1 <= AND2S1 or AND3S1;
AND5S1 <= AND4S and ORS1;
Forward(1) <= AND1S1 or AND5S1;
AND1S2 <= ExMemRegWrite and NotMemWbRegWrite and ExMemRdNull and ExMemRsEqual;
AND2S2 <= ExMemRdNull and NotMemWbRdNull and ExMemRsEqual;
AND3S2 <= ExMemRsEqual and NotMemWbRsEqual and ExMemRdNull;
ORS2 <= AND2S2 or AND3S2;
AND5S2 <= AND4S and ORS2;
Forward(0) <= AND1S2 or AND5S2;

end architecture;