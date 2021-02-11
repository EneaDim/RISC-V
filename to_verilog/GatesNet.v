// File ./Stage3/FordwardingBlock/GatesNet.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module GatesNet(
input wire ExMemRegWrite,
input wire MemWbRegWrite,
input wire MemWbRdNull,
input wire ExMemRdNull,
input wire MemWbRsEqual,
input wire ExMemRsEqual,
output wire [1:0] Forward
);

//signal necessary to understand if it's needed forward


//selection signal to give in input at the multiplexers

wire NotExMemRegWrite; wire NotMemWbRegWrite; wire NotMemWbRdNull; wire NotExMemRdNull; wire NotMemWbRsEqual; wire NotExMemRsEqual;
wire AND1S1; wire AND2S1; wire AND3S1; wire AND4S; wire AND5S1; wire AND1S2; wire AND2S2; wire AND3S2; wire AND5S2; wire ORS1; wire ORS2;

  assign NotExMemRegWrite =  ~(ExMemRegWrite);
  assign NotMemWbRegWrite =  ~(MemWbRegWrite);
  assign NotMemWbRdNull =  ~(MemWbRdNull);
  assign NotExMemRdNull =  ~(ExMemRdNull);
  assign NotMemWbRsEqual =  ~(MemWbRsEqual);
  assign NotExMemRsEqual =  ~(ExMemRsEqual);
  assign AND1S1 = NotExMemRegWrite & MemWbRegWrite & MemWbRdNull & MemWbRsEqual;
  assign AND2S1 = MemWbRdNull & NotExMemRsEqual & MemWbRsEqual;
  assign AND3S1 = NotExMemRdNull & MemWbRdNull & MemWbRsEqual;
  assign AND4S = ExMemRegWrite & MemWbRegWrite;
  assign ORS1 = AND2S1 | AND3S1;
  assign AND5S1 = AND4S & ORS1;
  assign Forward[1] = AND1S1 | AND5S1;
  assign AND1S2 = ExMemRegWrite & NotMemWbRegWrite & ExMemRdNull & ExMemRsEqual;
  assign AND2S2 = ExMemRdNull & NotMemWbRdNull & ExMemRsEqual;
  assign AND3S2 = ExMemRsEqual & NotMemWbRsEqual & ExMemRdNull;
  assign ORS2 = AND2S2 | AND3S2;
  assign AND5S2 = AND4S & ORS2;
  assign Forward[0] = AND1S2 | AND5S2;

endmodule
