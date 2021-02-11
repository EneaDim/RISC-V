// File ./Stage2/ImmediateGen/Mux4to1_1bit.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module mux4to1_1bit(
input wire A,
input wire B,
input wire C,
input wire D,
input wire [1:0] S,
output reg Z
);





  always @(S, A, B, C, D) begin
    case(S)
    2'b00 : begin
      Z <= A;
    end
    2'b01 : begin
      Z <= B;
    end
    2'b10 : begin
      Z <= C;
    end
    2'b11 : begin
      Z <= D;
    end
    default : begin
      Z <= A;
    end
    endcase
  end


endmodule
