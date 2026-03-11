`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 12:45:47
// Design Name: 
// Module Name: PE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Low-power Processing Element with clock gating for zero detection
module PE(
input clk,
input rst,

input [7:0] a0,a1,a2,a3,
input [7:0] b0,b1,b2,b3,

output reg [31:0] sum
);

reg [31:0] temp;

always @(*) begin
    temp = 0;

    // Zero-sparsity checks
    if(a0 != 0 && b0 != 0)
        temp = temp + a0*b0;

    if(a1 != 0 && b1 != 0)
        temp = temp + a1*b1;

    if(a2 != 0 && b2 != 0)
        temp = temp + a2*b2;

    if(a3 != 0 && b3 != 0)
        temp = temp + a3*b3;
end


always @(posedge clk or posedge rst)
begin
    if(rst)
        sum <= 0;
    else
        sum <= temp;
end

endmodule





