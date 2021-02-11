// File ./Stage2/RegisterFile/mux_8_to_1.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module MUX8_1(
input wire [N - 1:0] A,
input wire [N - 1:0] B,
input wire [N - 1:0] C,
input wire [N - 1:0] D,
input wire [N - 1:0] E,
input wire [N - 1:0] F,
input wire [N - 1:0] G,
input wire [N - 1:0] H,
input wire [2:0] SEL,
output reg [N - 1:0] DOUT
);

parameter [31:0] N = 32;




  always @(a, b, c, d, e, f, g, h, SEL) begin
    case(SEL)
    3'b000 : begin
      DOUT <= A;
    end
    3'b001 : begin
      DOUT <= B;
    end
    3'b010 : begin
      DOUT <= C;
    end
    3'b011 : begin
      DOUT <= D;
    end
    3'b100 : begin
      DOUT <= E;
    end
    3'b101 : begin
      DOUT <= F;
    end
    3'b110 : begin
      DOUT <= G;
    end
    3'b111 : begin
      DOUT <= H;
    end
    default : begin
      DOUT <= A;
    end
    endcase
  end


endmodule
