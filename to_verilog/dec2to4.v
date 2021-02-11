// File ./Stage2/RegisterFile/dec2to4.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module dec2to4(
input wire [1:0] w,
input wire enable,
output reg [3:0] y
);





  always @(w, enable) begin
    if(enable == 1'b0) begin
      y <= 4'b0000;
    end
    else begin
      case(w)
      2'b00 : begin
        y <= 4'b1000;
      end
      2'b01 : begin
        y <= 4'b0100;
      end
      2'b10 : begin
        y <= 4'b0010;
      end
      2'b11 : begin
        y <= 4'b0001;
      end
      default : begin
        y <= 4'b0000;
      end
      endcase
    end
  end


endmodule
