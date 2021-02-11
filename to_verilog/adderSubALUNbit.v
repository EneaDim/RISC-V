// File ./Stage3/ALUBlock/adderSubALUNbit.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module adderSubALUNbit(
input wire [N - 1:0] IN1,
input wire [N - 1:0] IN2,
input wire CIN,
output wire [N - 1:0] SUM
);

parameter [31:0] N = 32;



reg cin_sign;
reg [N - 1:0] sum_sign;

  always @(CIN, cin_sign, IN1, IN2, sum_sign) begin : P1
    reg [N - 1:0] sum_var;

    cin_sign <= cin;
    if(CIN_sign == 1'b0) begin
      SUM_var = IN1 + IN2;
    end
    else if(CIN_sign == 1'b1) begin
      sum_var = IN1 - IN2;
      if(sum_var[31] == 1'b1) begin
        sum_var = 32'b11111111111111111111111111111111;
      end
      else begin
        sum_var = 32'b00000000000000000000000000000000;
      end
    end
    else begin
      sum_var = sum_var;
    end
    sum_sign <= sum_var;
  end

  assign sum = sum_sign;

endmodule
