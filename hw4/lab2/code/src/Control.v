module Control (NoOp, opcode, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch_o, ALUOp);

    input NoOp;
    input [6:0] opcode;
    output reg ALUSrc;
    output reg MemtoReg;
    output reg RegWrite;
    output reg MemRead;
    output reg MemWrite;
    output reg Branch_o;
    output reg [1:0] ALUOp;

    initial begin
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        RegWrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        Branch_o = 1'b0;
        ALUOp = 2'b00;
    end

    always @(*) begin
        if (NoOp == 1'b1) begin
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            RegWrite = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch_o = 1'b0;
            ALUOp = 2'b00;
        end else begin
            case (opcode)
                // R-type
                7'b0110011: begin
                    ALUSrc = 1'b0;
                    MemtoReg = 1'b0;
                    RegWrite = 1'b1;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    Branch_o = 1'b0;
                    ALUOp = 2'b10;
                end
                //addi
                7'b0010011: begin
                    ALUSrc = 1'b1;
                    MemtoReg = 1'b0;
                    RegWrite = 1'b1;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    Branch_o = 1'b0;
                    ALUOp = 2'b01;
                end
                //lw
                7'b0000011: begin
                    ALUSrc = 1'b1;
                    MemtoReg = 1'b1;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemWrite = 1'b0;
                    Branch_o = 1'b0;
                    ALUOp = 2'b00;
                end
                //sd
                7'b0100011: begin
                    ALUSrc = 1'b1;
                    MemtoReg = 1'b0;
                    RegWrite = 1'b0;
                    MemRead = 1'b0;
                    MemWrite = 1'b1;
                    Branch_o = 1'b0;
                    ALUOp = 2'b00;
                end
                //beq
                7'b1100011: begin
                    ALUSrc = 1'b0;
                    MemtoReg = 1'b0;
                    RegWrite = 1'b0;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    Branch_o = 1'b1;
                    ALUOp = 2'b01;
                end
                default: begin
                    ALUSrc = 1'b0;
                    MemtoReg = 1'b0;
                    RegWrite = 1'b0;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    Branch_o = 1'b0;
                    ALUOp = 2'b00;
                end
            endcase
        end
    end

endmodule