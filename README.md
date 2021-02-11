# RISC-V Processor

- 5 Stage Pipelined Architecture

## Simulation
Running 'tb\_script' , all files will be analyzed using <b>GHDL</b>.

The 'tb\_risc\_abs.vhd' is the testbench of the simulation.

The output of the simulation is the risc\_v\_abs.vcd file.

This simulation can be seen using <b>GTKWAVE</b>

## Synthesys
The vhdl code are converted in verilog files with <b>VHD2VL</b>.

With the verilog files the synthesys can be done with <b>YOSYS</b>.

The target platform is ICE40 FPGA's (You can change it with YOSYS).

The output of the synthesys is saved as 'risc\_v.json'

## Place&Route
Has to be done.

Using <b>NEXTPNR-ICE40</b>.

A file '.asc' has to be created from the '.json' file.

## BitStream Generation
Using <b>ICEPACK</b>

A file '.bin' has to be created from the '.asc' file.

## Program FPGA
Using <b>ICEPROG</b>
