module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

wire [31:0] pc_normal_i, pc_predict_i, PC_branch_i, pc_i, pc_o, ADD3_Src2, MUX_PC1_Src1, MUX_PC1_Src2, MUX_PC2_Src1, MUX_PC2_Src2, predictor_PC_i, MUX_PC_Src1, MUX_PC_Src2;
wire [31:0] instr_o, IFID_instr, IFID_pc_o;
wire [31:0] RS1data, RS2data;
wire [31:0] immed;
wire ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, stall, noOp, predict, zero, flush_IFID, flush_IDEX, PCWrite, predict_o, predict_PCWrite_o;
wire [1:0] ALUOp, forward_A, forward_B;
wire [2:0] ALUCtl;
wire [31:0] ALUSrc1, ALUSrc2, MUXC_Src1, ALUout, ReadData_o, WBData;

wire IDEX_RegWrite, IDEX_MemtoReg, IDEX_MemRead, IDEX_MemWrite, IDEX_ALUSrc, IDEX_Branch;
wire [1:0] IDEX_ALUOp;
wire [4:0] IDEX_RS1addr, IDEX_RS2addr, IDEX_RDaddr;
wire [31:0] IDEX_RS1data, IDEX_RS2data, IDEX_immed, IDEX_pc_o;
wire [9:0] IDEX_fun10;

wire EXMEM_RegWrite, EXMEM_MemtoReg, EXMEM_MemRead, EXMEM_MemWrite;
wire [31:0] EXMEM_ALUout, EXMEM_WriteData;
wire [4:0] EXMEM_RDaddr;

wire MEMWB_RegWrite, MEMWB_MemtoReg;
wire [31:0] MEMWB_ReadData, MEMWB_ALUout;
wire [4:0] MEMWB_RDaddr;

Adder Add1(
    pc_o,
    4,
    MUX_PC1_Src1
);

Adder Add2(
    IFID_pc_o,
    immed,
    MUX_PC1_Src2
);

Adder Add3(
    IDEX_pc_o,
    ADD3_Src2,
    MUX_PC2_Src2
);

MUX1 MUX_ADD3(
    4,
    IDEX_immed,
    flush_IDEX,
    ADD3_Src2
);

MUX1 MUX_PC1(
    MUX_PC1_Src1,
    MUX_PC1_Src2,
    predict_o & Branch,
    MUX_PC2_Src1
);

MUX1 MUX_PC2(
    MUX_PC2_Src1,
    MUX_PC2_Src2,
    predict_PCWrite_o,
    pc_i
);

PC PC(
    rst_i,
    clk_i,
    PCWrite,
    pc_i,
    pc_o
);

Instruction_Memory Instruction_Memory(
    pc_o,
    instr_o
);

IFID IF_ID(
    stall,
    flush_IFID,
    rst_i,
    clk_i,
    pc_o,
    instr_o,
    IFID_pc_o,
    IFID_instr
);

Control Control(
    NoOp,
    IFID_instr[6:0],
    ALUSrc,
    MemtoReg,
    RegWrite,
    MemRead,
    MemWrite,
    Branch,
    ALUOp
);

Registers Registers(
    rst_i,
    clk_i,
    IFID_instr[19:15],
    IFID_instr[24:20],
    MEMWB_RDaddr,
    WBData,
    MEMWB_RegWrite,
    RS1data,
    RS2data
);

Sign_Extend Sign_Extend(
    IFID_instr,
    immed
);

IDEX ID_EX(
    flush_IDEX,
    rst_i,
    clk_i,
    RegWrite,
    MemtoReg,
    MemRead,
    MemWrite,
    Branch,
    ALUOp,
    ALUSrc,
    RS1data,
    RS2data,
    immed,
    {IFID_instr[31:25], IFID_instr[14:12]},
    IFID_instr[19:15],
    IFID_instr[24:20],
    IFID_instr[11:7],
    IFID_pc_o,
    IDEX_RegWrite,
    IDEX_MemtoReg,
    IDEX_MemRead,
    IDEX_MemWrite,
    IDEX_Branch,
    IDEX_ALUOp,
    IDEX_ALUSrc,
    IDEX_RS1data,
    IDEX_RS2data,
    IDEX_immed,
    IDEX_fun10,
    IDEX_RS1addr,
    IDEX_RS2addr,
    IDEX_RDaddr,
    IDEX_pc_o
);

MUX2 MUXA(
    IDEX_RS1data,
    WBData,
    EXMEM_ALUout,
    32'b0,
    forward_A,
    ALUSrc1
);

MUX2 MUXB(
    IDEX_RS2data,
    WBData,
    EXMEM_ALUout,
    32'b0,
    forward_B,
    MUXC_Src1
);

MUX1 MUXC(
    MUXC_Src1,
    IDEX_immed,
    IDEX_ALUSrc,
    ALUSrc2
);
  
ALU_Control ALU_Control(
    IDEX_ALUOp,
    IDEX_fun10,
    ALUCtl
);

ALU ALU(
    ALUCtl,
    ALUSrc1,
    ALUSrc2,
    ALUout,
    zero
);

EXMEM EX_MEM(
    rst_i,
    clk_i,
    IDEX_RegWrite,
    IDEX_MemtoReg,
    IDEX_MemRead,
    IDEX_MemWrite,
    ALUout,
    MUXC_Src1,
    IDEX_RDaddr,
    EXMEM_RegWrite,
    EXMEM_MemtoReg,
    EXMEM_MemRead,
    EXMEM_MemWrite,
    EXMEM_ALUout,
    EXMEM_WriteData,
    EXMEM_RDaddr
);

Data_Memory Data_Memory(
    clk_i,
    EXMEM_ALUout,
    EXMEM_MemRead,
    EXMEM_MemWrite,
    EXMEM_WriteData,
    ReadData_o
);

MEMWB MEM_WB(
    rst_i,
    clk_i,
    EXMEM_RegWrite,
    EXMEM_MemtoReg,
    EXMEM_ALUout,
    ReadData_o,
    EXMEM_RDaddr,
    MEMWB_RegWrite,
    MEMWB_MemtoReg,
    MEMWB_ALUout,
    MEMWB_ReadData,
    MEMWB_RDaddr
);

MUX1 WBSrc(
    MEMWB_ALUout,
    MEMWB_ReadData,
    MEMWB_MemtoReg,
    WBData
);

Forwarding Forwarding (
    IDEX_RS1addr,
    IDEX_RS2addr,
    EXMEM_RDaddr,
    EXMEM_RegWrite,
    MEMWB_RDaddr,
    MEMWB_RegWrite,
    forward_A,
    forward_B
);

Hazard_Detection Hazard_Detection (
    IFID_instr[19:15],
    IFID_instr[24:20],
    IDEX_RDaddr,
    IDEX_MemRead,
    PCWrite,
    stall,
    NoOp
);

Predictor branch_predictor (
    clk_i,
    rst_i,
    Branch,
    IDEX_Branch,
    zero,
    flush_IFID,
    flush_IDEX,
    predict_o, 
    predict_PCWrite_o
);

endmodule