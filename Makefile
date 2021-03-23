# vhdl files
TOP=risc_v_abs
STAGE1=Stage1/*.vhd
STAGE2_ALL=Stage2/*.vhd
STAGE2_CU=Stage2/ControlBlock/*.vhd
STAGE2_HD=Stage2/HazardUnit/*.vhd
STAGE2_IG=Stage2/ImmediateGen/*.vhd
STAGE2_RF=Stage2/RegisterFile/*.vhd
STAGE3_ALL=Stage3/*.vhd
STAGE3_ALU=Stage3/ALUBlock/*.vhd
STAGE3_FU=Stage3/FordwardingBlock/*.vhd
STAGE4=Stage4/*.vhd
VHDLEX = .vhd

# testbench
TESTBENCHPATH = ${TESTBENCHFILE}$(VHDLEX)
TESTBENCHFILE = $(TB)

#GHDL CONFIG
GHDL_CMD = ghdl
GHDL_FLAGS  = --ieee=synopsys
SIMDIR = sim
STOP_TIME = 500ns

# Simulation break condition
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)

# Simulation Viewer
WAVEFORM_VIEWER = gtkwave

# Synthesys YOSYS
SYNTH = yosys
SYNDIR = syn
VERILOG_FILES = to_verilog/*.v

# Place & Route
PLACEROUTE = nextpnr-ice40
PLACEROUTEDIR = placeroute

all: clean compile simulate view synth placeroute

sim: compile simulate view

syn: synth

pr: placeroute

compile:
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  registerNbit.vhd
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  ${TOP}$(VHDLEX)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(STAGE1)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE2_ALL)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE2_CU)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE2_HD)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE2_IG)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE2_RF)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE3_ALL)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE3_ALU)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE3_FU)
	@$(GHDL_CMD) -a $(GHDL_FLAGS)  $(TESTBENCHPATH) $(STAGE4)
	@$(GHDL_CMD) -a  $(GHDL_FLAGS)  ${TESTBENCHFILE}$(VHDLEX)

simulate:
	@$(GHDL_CMD) -e  $(GHDL_FLAGS)  $(TB)
	@$(GHDL_CMD) -r  $(GHDL_FLAGS)  $(TB) --vcd=$(TESTBENCHFILE).vcd $(GHDL_SIM_OPT)
	@mkdir $(SIMDIR)
	@mv $(TESTBENCHFILE).vcd $(SIMDIR)

view:
	@$(WAVEFORM_VIEWER) $(SIMDIR)/$(TESTBENCHFILE).vcd

synth:
	@$(SYNTH) synth.ys
	@mkdir $(SYNDIR)
	@mv risc_v_synth.v ./$(SYNDIR)/
	@mv risc_v_synth.json ./$(SYNDIR)/

placeroute:
	@mkdir $(PLACEROUTEDIR)
	@$(PLACEROUTE) --json ./$(SYNDIR)/risc_v_synth.json  --asc ./$(PLACEROUTEDIR)/risc_v_synth.asc --gui

clean:
	@rm -rf $(SIMDIR)
	@rm -rf $(SYNDIR)
	@rm -rf $(PLACEROUTEDIR)
