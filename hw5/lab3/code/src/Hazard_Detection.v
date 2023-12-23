module Hazard_Detection (
    RS1,
    RS2,
    RD,
    MemRead,
    PCWrite,
    Stall_o,
    NoOp
);

    input [4:0] RS1;
    input [4:0] RS2;
    input [4:0] RD;
    input MemRead;
    output reg PCWrite;
    output reg Stall_o;
    output reg NoOp;

    initial begin
        PCWrite = 1'b1;
        Stall_o = 1'b0;
        NoOp = 1'b0;
    end

    always @(*) begin
        if (MemRead == 1'b1) begin
            if (RS1 == RD || RS2 == RD) begin
                Stall_o = 1'b1;
                NoOp = 1'b1;
            end else begin
                Stall_o = 1'b0;
                NoOp = 1'b0;
            end
        end else begin
            Stall_o = 1'b0;
            NoOp = 1'b0;
        end
    end

    always @(*) begin
        if (Stall_o == 1'b1) begin
            PCWrite = 1'b0;
        end else begin
            PCWrite = 1'b1;
        end
    end


endmodule