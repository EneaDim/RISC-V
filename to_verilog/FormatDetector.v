// File ./Stage2/ImmediateGen/FormatDetector.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2017 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

// no timescale needed

module FormatDetector(
input wire instADD,
input wire instXOR,
input wire instSLT,
input wire InstAUIPC,
input wire instLUI,
input wire instADDI,
input wire instLW,
input wire instANDI,
input wire instSRAI,
input wire instBEQ,
input wire instJAL,
input wire instSW,
input wire instABS,
output wire Rformat,
output wire Uformat,
output wire Iformat,
output wire IbutnotSRAIformat,
output wire SBformat,
output wire UJformat,
output wire Sformat
);




wire Isignal;

  assign Rformat = instADD | instXOR | instSLT | instABS;
  assign Uformat = instAUIPC | instLUI;
  assign Isignal = instADDI | instLW | instANDI | instSRAI;
  assign Iformat = Isignal;
  assign IbutnotSRAIformat = Isignal & ( ~(instSRAI));
  assign SBformat = instBEQ;
  assign UJformat = instJAL;
  assign Sformat = instSW;

endmodule
