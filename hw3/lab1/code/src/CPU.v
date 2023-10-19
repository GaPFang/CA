module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

wire [31:0] pc_i, pc_o;
wire [31:0] addr, instr;
wire [31:0] RS1data, RS2data;
wire [31:0] immed;
wire [31:0] MUXtoALU;
wire ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
wire [1:0] ALUOp;
wire [2:0] ALUCtl;
wire [31:0] ALUout;


Control Control(
    clk_i,
    instr[6:0],
    ALUSrc,
    MemtoReg,
    RegWrite,
    MemRead,
    MemWrite,
    Branch,
    ALUOp
);

Adder Add_PC(
    pc_0,
    {28'b0, 4'b0100},
    pc_i
);

PC PC(
    clk_i,
    rst_i,
    pc_i,
    pc_o
);

Instruction_Memory Instruction_Memory(
    addr,
    instr
);

Registers Registers(
    rst_i,
    clk_i
    instr[19:15],
    instr[24:20],
    instr[11:7],
    ALUout,
    RegWrite,
    RS1data,
    RS2data
);

MUX32 MUX_ALUSrc(
    immed,
    RS2data,
    ALUSrc,
    MUXtoALU
);

Sign_Extend Sign_Extend(
    instr[31:20],
    immed
);
  
ALU ALU(
    ALUCtl,
    RS1data,
    MUXtoALU,
    ALUout
);

ALU_Control ALU_Control(
    ALUOp,
    {instr[31:25], instr[14:12]},
    ALUCtl
);

endmodule

