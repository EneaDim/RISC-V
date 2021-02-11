// File ./Stage2/RegisterFile/dec3to8.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module dec3to8(
input wire [2:0] w,
input wire enable,
output reg [7:0] y
);





  always @(w, enable) begin
    if(enable == 1'b0) begin
      y <= 8'b00000000;
    end
    else begin
      case(w)
      3'b000 : begin
        y <= 8'b10000000;
      end
      3'b001 : begin
        y <= 8'b01000000;
      end
      3'b010 : begin
        y <= 8'b00100000;
      end
      3'b011 : begin
        y <= 8'b00010000;
      end
      3'b100 : begin
        y <= 8'b00001000;
      end
      3'b101 : begin
        y <= 8'b00000100;
      end
      3'b110 : begin
        y <= 8'b00000010;
      end
      3'b111 : begin
        y <= 8'b00000001;
      end
      default : begin
        y <= 8'b00000000;
      end
      endcase
    end
  end


endmodule
