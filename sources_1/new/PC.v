//*****
//  Author       : magicwenli
//  Date         : 2021-01-05 13:58:41
//  LastEditTime : 2021-01-05 14:03:38
//  Description  : pc
//*****

module PC(
           input CLOCK,
           input WE,
           input [63: 0] PCIn,
           output [63: 0] PCOut
       );

always @(posedge CLOCK) begin
    if (WE) begin
        if (PCIn === 64'bx) begin
            PCOut <= 0;
        end
        else begin
            PCOut <= PCIn;
        end
    end
end

endmodule
