// File ./Stage2/ControlBlock/ControlUnit.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

module ControlUnit(
input wire [6:0] opcode,
input wire [2:0] func3,
input wire [6:0] func7,
input wire zero,
output wire beqOK,
output wire addOK,
output wire addiOK,
output wire sltOK,
output wire auipcOK,
output wire luiOK,
output wire jalOK,
output wire sraiOK,
output wire andiOK,
output wire xorOK,
output wire lwOK,
output wire swOK,
output wire absOK,
output wire branch,
output wire alu_src,
output wire [2:0] alu_op,
output wire mem_wr,
output wire mem_rd,
output wire mem_to_reg,
output wire reg_wr,
output wire controlRS1in,
output wire controlRS1out
);




wire beq_OK;
wire add_OK;
wire addi_OK;
wire slt_OK;
wire auipc_OK;
wire jal_OK;
wire lui_OK;
wire srai_OK;
wire andi_OK;
wire xor_OK;
wire lw_OK;
wire sw_OK;
wire abs_OK;

  assign beq_OK =  ~(func3[0] | func3[1] | func3[2]) & ((opcode[6] & opcode[5]) &  ~(opcode[4] | opcode[3] | opcode[2]) & (opcode[1] & opcode[0]));
  //for the branch pay attention if zero if '1' is necessary to determine the
  //next address with the previous data for the immediate generation
  assign add_OK = ( ~(func7[6] | func7[5] | func7[4] | func7[3]) & ( ~(func7[2] | func7[1] | func7[0])) & ( ~(func3[2] | func3[1] | func3[0]))) & ( ~(opcode[6] | opcode[3] | opcode[2]) & (opcode[5] & opcode[4] & opcode[1] & opcode[0]));
  assign addi_OK =  ~(func3[2] | func3[1] | func3[0]) & ( ~(opcode[6] | opcode[5] | opcode[3] | opcode[2]) & (opcode[4] & opcode[1] & opcode[0]));
  assign slt_OK = ( ~(func7[6] | func7[5] | func7[4]) &  ~(func7[3] | func7[2] | func7[1]) &  ~(func7[0] | func3[2] | func3[0])) & ( ~(opcode[6] | opcode[3] | opcode[2]) & ((func3[1]) & (opcode[5]) & (opcode[4])) & ((opcode[1]) & (opcode[0])));
  assign auipc_OK =  ~(opcode[6] | opcode[5] | opcode[3]) & ((opcode[4]) & (opcode[2]) & (opcode[1]) & (opcode[0]));
  assign lui_OK = ( ~(opcode[6]) & (opcode[5]) & (opcode[4]) &  ~(opcode[3])) & ((opcode[2]) & (opcode[1]) & (opcode[0]));
  assign srai_OK = ( ~(func7[6] | func7[4] | func7[3]) &  ~(func7[2] | func7[1] | func7[0]) &  ~(func3[1] | opcode[6] | opcode[5])) & ( ~( ~(func3[2]) | opcode[3] | opcode[2]) & (func3[0] & opcode[4] & opcode[1]) & (opcode[0]) & func7[5]);
  assign andi_OK = (func3[2] & func3[1] & func3[0]) & (opcode[4] & opcode[1] & opcode[0]) &  ~(opcode[6] | opcode[5] | opcode[3] | opcode[2]);
  assign xor_OK = ( ~(func7[6] | func7[5] | func7[4]) &  ~(func7[3] | func7[2] | func7[1])) & ( ~(func7[0] | func3[1] | func3[0]) &  ~(opcode[6] | opcode[3] | opcode[2])) & ((opcode[5] & opcode[4] & opcode[1]) & (opcode[0] & func3[2]));
  assign jal_OK = (opcode[6] & opcode[5] &  ~(opcode[4])) & (opcode[3] & opcode[2] & opcode[1] & opcode[0]);
  assign lw_OK = (func3[1] & opcode[1] & opcode[0]) &  ~(func3[2] | func3[0] | opcode[6]) &  ~(opcode[5] | opcode[4] | opcode[3] | opcode[2]);
  assign sw_OK = ( ~(func3[2] | func3[0] | opcode[6]) &  ~(opcode[4] | opcode[3] | opcode[2])) & ((func3[1] & opcode[5]) & (opcode[1] & opcode[0]));
  assign abs_OK = ( ~(func7[6] |  ~(func7[5]) | func7[4] | func7[3]) & ( ~(func7[2] | func7[1] | func7[0])) & ( ~(func3[2] | func3[1] | func3[0]))) & ( ~(opcode[6] | opcode[3] | opcode[2]) & (opcode[5] & opcode[4] & opcode[1] & opcode[0]));
  assign branch = jal_ok | (beq_OK & zero);
  assign alu_src = add_OK | xor_OK | slt_OK;
  assign alu_op[0] = xor_OK | andi_OK | abs_OK;
  assign alu_op[1] = srai_OK | xor_OK;
  assign alu_op[2] = slt_OK | abs_OK;
  assign mem_wr = sw_OK;
  assign mem_rd = lw_OK;
  assign mem_to_reg = lw_OK;
  assign reg_wr = add_OK | addi_OK | lui_OK | auipc_OK | lw_OK | jal_OK | srai_OK | andi_OK | xor_OK | slt_OK | abs_OK;
  assign controlRS1in = lui_OK;
  assign controlRS1out = jal_OK | auipc_OK;
  //en_add_pc <= (beqOK and zero) or jalOK;
  // en_ALU <= not(beq_OK);
  assign beqOK = beq_OK;
  assign addOK = add_OK;
  assign addiOK = addi_OK;
  assign sltOK = slt_OK;
  assign auipcOK = auipc_OK;
  assign luiOK = lui_OK;
  assign jalOK = jal_OK;
  assign sraiOK = srai_OK;
  assign andiOK = andi_OK;
  assign xorOK = xor_OK;
  assign lwOK = lw_OK;
  assign swOK = sw_OK;
  assign absOK = abs_OK;

endmodule
