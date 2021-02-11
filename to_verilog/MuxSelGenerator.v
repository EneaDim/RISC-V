// File ./Stage2/ImmediateGen/MuxSelGenerator.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module MUXSELGenerator(
input wire Rformat,
input wire Uformat,
input wire Iformat,
input wire IbutnotSRAIformat,
input wire SBformat,
input wire UJformat,
input wire Sformat,
output wire sel31_20,
output wire sel19_12,
output wire sel10_5,
output wire [1:0] sel11,
output wire [1:0] sel4_1,
output wire [1:0] sel0
);





  assign sel31_20 = Uformat;
  assign sel19_12 = Uformat | UJformat;
  assign sel10_5 =  ~(IbutnotSRAIformat | Sformat | SBformat | UJformat);
  assign sel11[1] =  ~(UJformat | SBformat);
  assign sel11[0] =  ~(UJformat | Uformat);
  assign sel4_1[1] = Rformat | Uformat;
  assign sel4_1[0] = Sformat | SBformat;
  assign sel0[1] =  ~(Iformat | Sformat);
  assign sel0[0] = Sformat;

endmodule
