// File ./Stage3/ALUBlock/Decoder2TO4.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module Decoder2TO4(
input wire IN1,
input wire IN2,
output wire EN_ADD,
output wire EN_ANDI,
output wire EN_SRAI,
output wire EN_XOR
);





  assign EN_ADD =  ~(IN1) &  ~(IN2);
  assign EN_ANDI =  ~(IN1) & (IN2);
  assign EN_SRAI = (IN1) &  ~(IN2);
  assign EN_XOR = IN1 & IN2;

endmodule
