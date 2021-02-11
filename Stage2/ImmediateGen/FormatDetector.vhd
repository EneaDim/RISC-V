LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FormatDetector IS
 
	PORT (instADD, instXOR, instSLT, InstAUIPC, instLUI, instADDI, instLW, instANDI, instSRAI, instBEQ, instJAL, instSW, instABS : IN STD_LOGIC;
			Rformat, Uformat, Iformat, IbutnotSRAIformat, SBformat, UJformat, Sformat : OUT STD_LOGIC); 
END FormatDetector;

ARCHITECTURE combinational OF FormatDetector IS

signal Isignal:std_LOGIC;
BEGIN
		
	Rformat <= instADD or instXOR or instSLT or instABS;
	Uformat <= instAUIPC or instLUI;
	Isignal <= instADDI or instLW or instANDI or instSRAI;
	Iformat <= Isignal;
	IbutnotSRAIformat <= Isignal and (not(instSRAI));
	SBformat <= instBEQ;
	UJformat <= instJAL;
	Sformat <= instSW;

		
END combinational;
