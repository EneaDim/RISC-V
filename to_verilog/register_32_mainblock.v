// File ./Stage2/RegisterFile/registers_32_mainblock.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module REGISTERS_mainblock(
input wire clk,
input wire rst_n,
input wire Regwrite,
input wire [4:0] ReadRS1,
input wire [4:0] ReadRS2,
input wire [4:0] writereg,
input wire [31:0] Datawrite,
output wire [31:0] Readdata1,
output wire [31:0] Readdata2
);




wire [31:0] decodedadd;
wire [31:0] rd1; wire [31:0] rd2; wire [31:0] rd3; wire [31:0] rd4; wire [31:0] rd5; wire [31:0] rd6; wire [31:0] rd7; wire [31:0] rd8; wire [31:0] rd9; wire [31:0] rd10; wire [31:0] rd11; wire [31:0] rd12; wire [31:0] rd13; wire [31:0] rd14; wire [31:0] rd15; wire [31:0] rd16; wire [31:0] rd17; wire [31:0] rd18; wire [31:0] rd19; wire [31:0] rd20; wire [31:0] rd21; wire [31:0] rd22; wire [31:0] rd23; wire [31:0] rd24; wire [31:0] rd25; wire [31:0] rd26; wire [31:0] rd27; wire [31:0] rd28; wire [31:0] rd29; wire [31:0] rd30; wire [31:0] rd31; wire [31:0] rd0;

  // istanzio il decoder dove ho l'indirizzo di scrittura, lui è abilitato quando ho un segnale di regwrite e da un uscita l'indirizzo
  dec5to32 WRITEDECODER(
      .x(writereg),
    .enable(Regwrite),
    .z(decodedadd));

  // devo capire come generare 64 registri con il generate, nel frattempo l'ho fatto a mano
  // questi registri sono selezionati dall'indirizzo di scrittura quando devono essere sovrascritti
  register_nbit_clock_n #(
      .N(32))
  REG0(
      clk,
    rst_n,
    decodedadd[31],
    Datawrite,
    rd0);

  register_nbit_clock_n #(
      .N(32))
  REG1(
      clk,
    rst_n,
    decodedadd[30],
    Datawrite,
    rd1);

  //----
  register_nbit_clock_n #(
      .N(32))
  REG2(
      clk,
    rst_n,
    decodedadd[29],
    Datawrite,
    rd2);

  register_nbit_clock_n #(
      .N(32))
  REG3(
      clk,
    rst_n,
    decodedadd[28],
    Datawrite,
    rd3);

  register_nbit_clock_n #(
      .N(32))
  REG4(
      clk,
    rst_n,
    decodedadd[27],
    Datawrite,
    rd4);

  register_nbit_clock_n #(
      .N(32))
  REG5(
      clk,
    rst_n,
    decodedadd[26],
    Datawrite,
    rd5);

  register_nbit_clock_n #(
      .N(32))
  REG6(
      clk,
    rst_n,
    decodedadd[25],
    Datawrite,
    rd6);

  register_nbit_clock_n #(
      .N(32))
  REG7(
      clk,
    rst_n,
    decodedadd[24],
    Datawrite,
    rd7);

  register_nbit_clock_n #(
      .N(32))
  REG8(
      clk,
    rst_n,
    decodedadd[23],
    Datawrite,
    rd8);

  register_nbit_clock_n #(
      .N(32))
  REG9(
      clk,
    rst_n,
    decodedadd[22],
    Datawrite,
    rd9);

  register_nbit_clock_n #(
      .N(32))
  REG10(
      clk,
    rst_n,
    decodedadd[21],
    Datawrite,
    rd10);

  register_nbit_clock_n #(
      .N(32))
  REG11(
      clk,
    rst_n,
    decodedadd[20],
    Datawrite,
    rd11);

  register_nbit_clock_n #(
      .N(32))
  REG12(
      clk,
    rst_n,
    decodedadd[19],
    Datawrite,
    rd12);

  register_nbit_clock_n #(
      .N(32))
  REG13(
      clk,
    rst_n,
    decodedadd[18],
    Datawrite,
    rd13);

  register_nbit_clock_n #(
      .N(32))
  REG14(
      clk,
    rst_n,
    decodedadd[17],
    Datawrite,
    rd14);

  register_nbit_clock_n #(
      .N(32))
  REG15(
      clk,
    rst_n,
    decodedadd[16],
    Datawrite,
    rd15);

  register_nbit_clock_n #(
      .N(32))
  REG16(
      clk,
    rst_n,
    decodedadd[15],
    Datawrite,
    rd16);

  register_nbit_clock_n #(
      .N(32))
  REG17(
      clk,
    rst_n,
    decodedadd[ + 1],
    Datawrite,
    rd17);

  register_nbit_clock_n #(
      .N(32))
  REG18(
      clk,
    rst_n,
    decodedadd[13],
    Datawrite,
    rd18);

  register_nbit_clock_n #(
      .N(32))
  REG19(
      clk,
    rst_n,
    decodedadd[12],
    Datawrite,
    rd19);

  register_nbit_clock_n #(
      .N(32))
  REG20(
      clk,
    rst_n,
    decodedadd[11],
    Datawrite,
    rd20);

  register_nbit_clock_n #(
      .N(32))
  REG21(
      clk,
    rst_n,
    decodedadd[10],
    Datawrite,
    rd21);

  register_nbit_clock_n #(
      .N(32))
  REG22(
      clk,
    rst_n,
    decodedadd[9],
    Datawrite,
    rd22);

  register_nbit_clock_n #(
      .N(32))
  REG23(
      clk,
    rst_n,
    decodedadd[8],
    Datawrite,
    rd23);

  register_nbit_clock_n #(
      .N(32))
  REG24(
      clk,
    rst_n,
    decodedadd[7],
    Datawrite,
    rd24);

  register_nbit_clock_n #(
      .N(32))
  REG25(
      clk,
    rst_n,
    decodedadd[6],
    Datawrite,
    rd25);

  register_nbit_clock_n #(
      .N(32))
  REG26(
      clk,
    rst_n,
    decodedadd[5],
    Datawrite,
    rd26);

  register_nbit_clock_n #(
      .N(32))
  REG27(
      clk,
    rst_n,
    decodedadd[4],
    Datawrite,
    rd27);

  register_nbit_clock_n #(
      .N(32))
  REG28(
      clk,
    rst_n,
    decodedadd[3],
    Datawrite,
    rd28);

  register_nbit_clock_n #(
      .N(32))
  REG29(
      clk,
    rst_n,
    decodedadd[2],
    Datawrite,
    rd29);

  register_nbit_clock_n #(
      .N(32))
  REG30(
      clk,
    rst_n,
    decodedadd[1],
    Datawrite,
    rd30);

  register_nbit_clock_n #(
      .N(32))
  REG31(
      clk,
    rst_n,
    decodedadd[0],
    Datawrite,
    rd31);

  // ora instanzio i due mux che hanno gli stessi ingressi, cambiano solamente nel selettore
  mux32to1 MUX1(
      rd0,
    rd1,
    rd2,
    rd3,
    rd4,
    rd5,
    rd6,
    rd7,
    rd8,
    rd9,
    rd10,
    rd11,
    rd12,
    rd13,
    rd14,
    rd15,
    rd16,
    rd17,
    rd18,
    rd19,
    rd20,
    rd21,
    rd22,
    rd23,
    rd24,
    rd25,
    rd26,
    rd27,
    rd28,
    rd29,
    rd30,
    rd31,
    ReadRS1,
    Readdata1);

  mux32to1 MUX2(
      rd0,
    rd1,
    rd2,
    rd3,
    rd4,
    rd5,
    rd6,
    rd7,
    rd8,
    rd9,
    rd10,
    rd11,
    rd12,
    rd13,
    rd14,
    rd15,
    rd16,
    rd17,
    rd18,
    rd19,
    rd20,
    rd21,
    rd22,
    rd23,
    rd24,
    rd25,
    rd26,
    rd27,
    rd28,
    rd29,
    rd30,
    rd31,
    ReadRS2,
    Readdata2);


endmodule
