module Forwarding (
    IDEX_RS1,
    IDEX_RS2,
    EXMEM_RD,
    EXMEM_RegWrite,
    MEMWB_RD,
    MEMWB_RegWrite,
    A,
    B
);

    input [4:0] IDEX_RS1;
    input [4:0] IDEX_RS2;
    input [4:0] EXMEM_RD;
    input EXMEM_RegWrite;
    input [4:0] MEMWB_RD;
    input MEMWB_RegWrite;
    output reg [1:0] A;
    output reg [1:0] B;

    initial begin
        A = 2'b00;
        B = 2'b00;
    end

    always @(*) begin
        // EX hazard
        if (EXMEM_RegWrite == 1'b1) begin
            if (EXMEM_RD != 0) begin
                if (EXMEM_RD == IDEX_RS1) begin
                    A = 2'b10;
                end else begin
                    A = 2'b00;
                end
                if (EXMEM_RD == IDEX_RS2) begin
                    B = 2'b10;
                end else begin
                    B = 2'b00;
                end
            end
        end else begin
            A = 2'b00;
            B = 2'b00;
        end
        // MEM hazard
        if (MEMWB_RegWrite == 1'b1) begin
            if (MEMWB_RD != 0) begin
                if (MEMWB_RD == IDEX_RS1 && A != 2'b10) begin
                    A = 2'b01;
                end
                if (MEMWB_RD == IDEX_RS2 && B != 2'b10) begin
                    B = 2'b01;
                end
            end
        end
    end

endmodule