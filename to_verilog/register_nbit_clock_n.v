// File ./Stage2/RegisterFile/register_nbit_clock_n.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module register_nbit_clock_n(
input wire clk,
input wire rst_n,
input wire enable,
input wire [N - 1:0] a,
output reg [N - 1:0] b
);

parameter [31:0] N = 32;




  always @(negedge clk) begin
    if((rst_n == 1'b0)) begin
      b <= {(((N - 1))-((0))+1){1'b0}};
    end
    else if((enable == 1'b1)) begin
      b <= a;
    end
  end


endmodule
