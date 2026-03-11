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

module systolic_array_4x4(
    input clk,
    input rst,

    input [7:0] A00,A01,A02,A03,
    input [7:0] A10,A11,A12,A13,
    input [7:0] A20,A21,A22,A23,
    input [7:0] A30,A31,A32,A33,

    input [7:0] B00,B01,B02,B03,
    input [7:0] B10,B11,B12,B13,
    input [7:0] B20,B21,B22,B23,
    input [7:0] B30,B31,B32,B33,

    output [31:0] C00,C01,C02,C03,
    output [31:0] C10,C11,C12,C13,
    output [31:0] C20,C21,C22,C23,
    output [31:0] C30,C31,C32,C33
);

wire [7:0] A[0:3][0:3];
wire [7:0] B[0:3][0:3];
wire [31:0] sum[0:3][0:3];


// Assign matrix inputs
assign A[0][0]=A00; assign A[0][1]=A01; assign A[0][2]=A02; assign A[0][3]=A03;
assign A[1][0]=A10; assign A[1][1]=A11; assign A[1][2]=A12; assign A[1][3]=A13;
assign A[2][0]=A20; assign A[2][1]=A21; assign A[2][2]=A22; assign A[2][3]=A23;
assign A[3][0]=A30; assign A[3][1]=A31; assign A[3][2]=A32; assign A[3][3]=A33;

assign B[0][0]=B00; assign B[0][1]=B01; assign B[0][2]=B02; assign B[0][3]=B03;
assign B[1][0]=B10; assign B[1][1]=B11; assign B[1][2]=B12; assign B[1][3]=B13;
assign B[2][0]=B20; assign B[2][1]=B21; assign B[2][2]=B22; assign B[2][3]=B23;
assign B[3][0]=B30; assign B[3][1]=B31; assign B[3][2]=B32; assign B[3][3]=B33;


genvar i,j;

generate
for(i=0;i<4;i=i+1) begin: row
    for(j=0;j<4;j=j+1) begin: col

        PE pe_inst(
            .clk(clk),
            .rst(rst),

            .a0(A[i][0]),
            .a1(A[i][1]),
            .a2(A[i][2]),
            .a3(A[i][3]),

            .b0(B[0][j]),
            .b1(B[1][j]),
            .b2(B[2][j]),
            .b3(B[3][j]),

            .sum(sum[i][j])
        );

    end
end
endgenerate


assign C00=sum[0][0];
assign C01=sum[0][1];
assign C02=sum[0][2];
assign C03=sum[0][3];

assign C10=sum[1][0];
assign C11=sum[1][1];
assign C12=sum[1][2];
assign C13=sum[1][3];

assign C20=sum[2][0];
assign C21=sum[2][1];
assign C22=sum[2][2];
assign C23=sum[2][3];

assign C30=sum[3][0];
assign C31=sum[3][1];
assign C32=sum[3][2];
assign C33=sum[3][3];

endmodule

