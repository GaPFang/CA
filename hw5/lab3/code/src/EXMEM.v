module EXMEM
(
    rst_i,
    clk_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i,
    MemAddr_i,
    WriteData_i,
    RDaddr_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    MemAddr_o,
    WriteData_o,
    RDaddr_o
);

    input    rst_i;
    input    clk_i;
    input    RegWrite_i;
    input    MemtoReg_i;
    input    MemRead_i;
    input    MemWrite_i;
    input [31:0]  MemAddr_i;
    input [31:0]  WriteData_i;
    input [4:0]   RDaddr_i;
    output reg    RegWrite_o;
    output reg    MemtoReg_o;
    output reg    MemRead_o;
    output reg    MemWrite_o;
    output reg [31:0]  MemAddr_o;
    output reg [31:0]  WriteData_o;
    output reg [4:0]   RDaddr_o;

    initial begin
        RegWrite_o = 1'b0;
        MemtoReg_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        MemAddr_o = 32'b0;
        WriteData_o = 32'b0;
        RDaddr_o = 5'b0;
    end

    always@(posedge clk_i or negedge rst_i) begin
        if (~rst_i) begin
            RegWrite_o <= 1'b0;
            MemtoReg_o <= 1'b0;
            MemRead_o <= 1'b0;
            MemWrite_o <= 1'b0;
            MemAddr_o <= 32'b0;
            WriteData_o <= 32'b0;
            RDaddr_o <= 5'b0;
        end else begin
            RegWrite_o <= RegWrite_i;
            MemtoReg_o <= MemtoReg_i;
            MemRead_o <= MemRead_i;
            MemWrite_o <= MemWrite_i;
            MemAddr_o <= MemAddr_i;
            WriteData_o <= WriteData_i;
            RDaddr_o <= RDaddr_i;
        end
    end

endmodule