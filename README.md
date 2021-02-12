# RISC-V Processor

- 5 Stage Pipelined Architecture

## Hardware Design

### Requirements to Compile and Simulate

```sudo apt-get install ghdl gtkwave```

### Requirements to Synthetize

Walkthrough <https://github.com/YosysHQ/yosys>

Walkthrough to convert vhdl into verilog files <https://github.com/ldoolitt/vhd2vl> (needed for synthesys with yosys)

### Requirements to Place&Route

Walkthrough <https://github.com/YosysHQ/nextpnr>

## Simulation

The 'tb_risc_abs.vhd' is the testbench of the architecture.

The simulation can be seen running ```gtkwave risc_v_abs.vcd```.

### Compile the design

Running ```tb_script``` file , files of the overall architecture will be analyzed using ```ghdl```.

By default a <b>vcd</b> file named 'risc_v_abs.vcd will be created in the main directory.

## Synthesys

The vhdl code are converted in verilog files with ```vhd2vl```.

With the verilog files the synthesys can be done with ```yosys```.

TThe target FPGA platform is <b>ICE40</b>, you can change it with ```yosys``` with the commmand: ```synth_<target_name>```.

#### Synthesys commands:
- cd to_verilog/
- yosys
- read_verilog *.v
- hierarchy -check -top risc_v_abs
- proc
- opt
- techmap
- opt
- synth_ice40
- write_json risc_v.json

The output of the synthesys is saved as 'risc\_v.json'

## Place&Route
Has to be done.

Using ```nextpnr-ice40```.

A file '.asc' has to be created from the '.json' file.

## BitStream Generation
Using ```icepack```

A file '.bin' has to be created from the '.asc' file.

## Program FPGA
Using ```iceprog```
