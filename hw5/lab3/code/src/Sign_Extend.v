module Sign_Extend (instr, immed);

    input [31:0] instr;
    output reg [31:0] immed;

    initial begin
        immed = 32'b0;
    end

    always @(*) begin
        if (instr[6:0] == 7'b0010011 || instr[6:0] == 7'b0000011) begin
            if (instr[31] == 1'b0) begin
                immed = {20'b0, instr[31:20]};
            end else begin
                immed = {{20{1'b1}}, instr[31:20]};
            end
        end else if (instr[6:0] == 7'b0100011) begin
            if (instr[31] == 1'b0) begin
                immed = {20'b0, instr[31:25], instr[11:7]};
            end else begin
                immed = {{20{1'b1}}, instr[31:25], instr[11:7]};
            end
        end else if (instr[6:0] == 7'b1100011) begin
            if (instr[31] == 1'b0) begin
                immed = {19'b0, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            end else begin
                immed = {{19{1'b1}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            end
        end else begin
            immed = 32'b0;
        end
    end

endmodule