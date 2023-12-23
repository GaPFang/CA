module ALU_Control (ALUOp, I, ALUCtl);

    input [1:0] ALUOp;
    input [9:0] I;
    output reg [2:0] ALUCtl;

    initial begin
        ALUCtl = 3'b000;
    end

    always @(*) begin
        case (ALUOp)
            2'b10: begin
                case (I)
                    10'b0000000111: ALUCtl = 3'b000; //and
                    10'b0000000100: ALUCtl = 3'b001; //xor
                    10'b0000000000: ALUCtl = 3'b010; //add
                    10'b0000000001: ALUCtl = 3'b011; //sll
                    10'b0000001000: ALUCtl = 3'b101; //mul
                    10'b0100000000: ALUCtl = 3'b110; //sub
                endcase
            end
            2'b01: begin
                case (I[2:0])
                    3'b000: ALUCtl = 3'b010; //addi
                    3'b101: ALUCtl = 3'b111; //srai
                endcase
            end
            2'b00: begin
                ALUCtl = 3'b010; //lw, sw
            end
            2'b11: begin
                ALUCtl = 3'b110; //beq
            end
        endcase
    end


endmodule