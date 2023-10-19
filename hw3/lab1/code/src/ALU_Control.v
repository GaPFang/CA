module ALU_Control (
    input [1:0] ALUOp,
    input [9:0] I,
    output [2:0] ALUCtl
);
    always @(*) begin
        if (ALUOp = 2'b01) begin
            case (I) 
                // addi
                {10'b0000001000}: begin
                    ALUCtl = 3'b011;
                end
                // srai
                {10'b0100000101}: begin
                    ALUCtl = 3'b110;
                end
            endcase
        // end else if (ALUOp = 2'b00) begin
        //     ALUCtl = 3'b010;
        end else begin
            case (I) 
                // and
                {7'b0, 3'b111}: begin
                    ALUCtl = 3'b000;
                end
                // xor
                {7'b0, 3'b100}: begin
                    ALUCtl = 3'b001;
                end
                // sll
                {7'b0, 3'b001}: begin
                    ALUCtl = 3'b010;
                end
                // add
                10'b0: begin
                    ALUCtl = 3'b011
                end
                // sub
                {10'b0100000000}: begin
                    ALUCtl = 3'b100;
                end
                // mul
                {10'b0000001000}: begin
                    ALUCtl = 3'b101;
                end
            endcase
        end
    end



endmodule