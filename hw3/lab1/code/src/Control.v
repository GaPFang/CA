module Control (clk, opcode, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);

    input clk;
    input [6:0] opcode;
    output reg ALUSrc;
    output reg MemtoReg;
    output reg RegWrite;
    output reg MemRead;
    output reg MemWrite;
    output reg Branch;
    output reg [1:0] ALUOp;

    always @(*) begin
        if (opcode[5]) begin
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            RegWrite = 1'b1;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b0;
            ALUOp = 2'b10;
        end else begin
            ALUSrc = 1'b1;
            MemtoReg = 1'b0;
            RegWrite = 1'b1;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b0;
            ALUOp = 2'b01;
        end
    end


endmodule