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
    input [7:0] a,
    input [7:0] b,
    input [31:0] sum_in,
    output reg [31:0] sum_out
);
wire compute_enable;

assign compute_enable = (a != 0) && (b != 0);

always @(posedge clk or posedge rst) begin
    if(rst)
        sum_out <= 0;

    else if(compute_enable)
        sum_out <= sum_in + (a * b);

    else
        sum_out <= sum_in;
end
endmodule


