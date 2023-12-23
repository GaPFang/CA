module ALU (ALUCtl, a, b, data_o, zero);

    input [2:0] ALUCtl;
    input signed [31:0] a;
    input signed [31:0] b;
    output reg [31:0] data_o;
    output reg zero;

    initial begin
        data_o = 0;
    end

    always @(*) begin
        zero = 0;
        case (ALUCtl)
            // and
            3'b000: begin
                data_o = a & b;
            end
            // xor
            3'b001: begin
                data_o = a ^ b;
            end
            // add
            3'b010: begin
                data_o = a + b;
            end
            // sll
            3'b011: begin
                data_o = a << b;
            end
            // mul
            3'b101: begin
                data_o = a * b;
            end
            // sub
            3'b110: begin
                data_o = a - b;
                if (data_o == 0) begin
                    zero = 1;
                end
            end
            // srai
            3'b111: begin
                data_o = a >>> b[4:0];
            end
        endcase
    end

endmodule