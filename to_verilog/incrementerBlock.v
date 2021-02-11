// File ./Stage1/incrementerBlock.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module incrementerBlock(
input wire [N - 1:0] in1,
output wire [N - 1:0] res
);

parameter [31:0] N = 30;



wire [N - 2:0] connection;

  assign res[0] =  ~(in1[0]);
  assign connection[0] = in1[0];
  genvar I;
  generate for (I=1; I <= N - 2; I = I + 1) begin: genSubBlock
      incrementerSubBlock subBlock(
          in1[I],
      connection[I - 1],
      res[I],
      connection[I]);

  end
  endgenerate
  assign res[N - 1] = in1[N - 1] ^ connection[N - 2];

endmodule
