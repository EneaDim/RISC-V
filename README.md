# RISC-V Processor

- 5 Stage Pipelined Architecture

General overview of the architecture:

<img src="https://github.com/EneaDim/RISC-V/blob/main/riscvArch.png">

## Hardware Design

The design implementation, and the walkthrough on <b>Modelsim, Synopsys and Cadence Innovus</b> can be seen in the 'riscv_report.pdf'

In this repository, the data memory and the instruction memory are missed due to a work in progress in order to include cache L1 for both data and instructions.

## OpenSource Analysis

I've reviewed the project and change it in order to make it compatible with OpenSource tools for the synthesys, the place&route and the bitstream generation to program an FPGA.

### Requirements to Compile and Simulate

Walkthrough <https://github.com/ghdl/ghdl>

Walkthrough <https://github.com/gtkwave/gtkwave>

### Requirements to Synthetize

Walkthrough <https://github.com/YosysHQ/yosys>

Walkthrough to convert vhdl into verilog files <https://github.com/ldoolitt/vhd2vl> (needed to convert vhdl's to verilog files for yosys)

### Requirements to Place&Route

Walktrhough <https://github.com/steveicarus/iverilog>

Walktrhough <https://github.com/ddm/icetools>

Walkthrough <https://github.com/YosysHQ/nextpnr>

Build it with the GUI.

### Compile the design

Running ```make compile``` , files of the overall architecture will be analyzed using ```ghdl```.

## Simulation

The 'tb_risc_abs.vhd' is the testbench of the architecture.

The simulation can be seen running ```make sim```.

By default a <b>vcd</b> file named 'risc_v_abs.vcd' will be created in the sim directory.

## Synthesys

The vhdl code are converted in verilog files with ```vhd2vl```.

With the verilog files the synthesys can be done with ```yosys```.

TThe target FPGA platform is <b>ICE40</b>, you can change it with ```yosys``` with the commmand: ```synth_<target_name>```.

#### Synthesys commands:

They can be seen in the <b>synth.ys</b> file.

The output of the synthesys is saved as 'risc\_v.json'

Running ```make syn```

## Place&Route

Running ```make pr``` the place and route will start with a gui using <b>nextpnr-ice40</b>

A file '.asc' has to be created from the '.json' file.

## BitStream Generation
Using ```icepack```

A file '.bin' has to be created from the '.asc' file.

## Program FPGA
Using ```iceprog```
