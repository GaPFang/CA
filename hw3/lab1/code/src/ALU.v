module ALU (ALUCtl, a, b, out);

    input [2:0] ALUCtl;
    input [31:0] a;
    input [31:0] b;
    output [31:0] out;

    reg [31:0] result;
    always @(*) begin
        case (ALUCtl)
            // and
            3'b000: begin
                result = a & b;
            end
            // xor
            3'b001: begin
                result = a ^ b;
            end
            // sll
            3'b010: begin
                result = a << b;
            end
            // add
            3'b011: begin
                result = a + b;
            end
            // sub
            3'b100: begin
                result = a - b;
            end
            // mul
            3'b101: begin
                result = a * b;
            end
            // srai
            3'b110: begin
                result = a >>> b;
            end
        endcase
    end

    assign out = result;

endmodule