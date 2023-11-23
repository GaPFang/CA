module ALU (ALUCtl, a, b, out);

    input [2:0] ALUCtl;
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] out;

    initial begin
        out = 0;
    end

    always @(*) begin
        case (ALUCtl)
            // and
            3'b000: begin
                out = a & b;
            end
            // xor
            3'b001: begin
                out = a ^ b;
            end
            // add
            3'b010: begin
                out = a + b;
            end
            // sll
            3'b011: begin
                out = a << b;
            end
            // mul
            3'b101: begin
                out = a * b;
            end
            // sub
            3'b110: begin
                out = a - b;
            end
            // srai
            3'b111: begin
                out = a >>> b[4:0];
            end
        endcase
    end

endmodule