`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2026 12:49:21
// Design Name: 
// Module Name: tb
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

// Self-checking Testbench for 4x4 Systolic Array

module tb;

reg clk;
reg rst;

reg [7:0] A00,A01,A02,A03;
reg [7:0] A10,A11,A12,A13;
reg [7:0] A20,A21,A22,A23;
reg [7:0] A30,A31,A32,A33;

reg [7:0] B00,B01,B02,B03;
reg [7:0] B10,B11,B12,B13;
reg [7:0] B20,B21,B22,B23;
reg [7:0] B30,B31,B32,B33;

wire [31:0] C00,C01,C02,C03;
wire [31:0] C10,C11,C12,C13;
wire [31:0] C20,C21,C22,C23;
wire [31:0] C30,C31,C32,C33;

reg [7:0] A [0:3][0:3];
reg [7:0] B [0:3][0:3];
reg [31:0] C_exp [0:3][0:3];

integer i,j,k;
integer errors=0;

systolic_array_4x4 uut(

.clk(clk),
.rst(rst),

.A00(A00), .A01(A01), .A02(A02), .A03(A03),
.A10(A10), .A11(A11), .A12(A12), .A13(A13),
.A20(A20), .A21(A21), .A22(A22), .A23(A23),
.A30(A30), .A31(A31), .A32(A32), .A33(A33),

.B00(B00), .B01(B01), .B02(B02), .B03(B03),
.B10(B10), .B11(B11), .B12(B12), .B13(B13),
.B20(B20), .B21(B21), .B22(B22), .B23(B23),
.B30(B30), .B31(B31), .B32(B32), .B33(B33),

.C00(C00), .C01(C01), .C02(C02), .C03(C03),
.C10(C10), .C11(C11), .C12(C12), .C13(C13),
.C20(C20), .C21(C21), .C22(C22), .C23(C23),
.C30(C30), .C31(C31), .C32(C32), .C33(C33)

);

initial clk=0;
always #5 clk=~clk;

initial begin

rst=1;
#10 rst=0;

// Matrix A
A00 = 8'd1; A01 = 8'd0; A02 = 8'd0; A03 = 8'd4;
A10 = 8'd5; A11 = 8'd6; A12 = 8'd0; A13 = 8'd0;
A20 = 8'd0; A21 = 8'd1; A22 = 8'd2; A23 = 8'd3;
A30 = 8'd0; A31 = 8'd5; A32 = 8'd0; A33 = 8'd0;

// Matrix B
B00 = 8'd1; B01 = 8'd2; B02 = 8'd0; B03 = 8'd0;
B10 = 8'd0; B11 = 8'd6; B12 = 8'd0; B13 = 8'd8;
B20 = 8'd9; B21 = 8'd0; B22 = 8'd2; B23 = 8'd0;
B30 = 8'd0; B31 = 8'd5; B32 = 8'd0; B33 = 8'd7;

// Store matrices in arrays
A[0][0]=A00; A[0][1]=A01; A[0][2]=A02; A[0][3]=A03;
A[1][0]=A10; A[1][1]=A11; A[1][2]=A12; A[1][3]=A13;
A[2][0]=A20; A[2][1]=A21; A[2][2]=A22; A[2][3]=A23;
A[3][0]=A30; A[3][1]=A31; A[3][2]=A32; A[3][3]=A33;

B[0][0]=B00; B[0][1]=B01; B[0][2]=B02; B[0][3]=B03;
B[1][0]=B10; B[1][1]=B11; B[1][2]=B12; B[1][3]=B13;
B[2][0]=B20; B[2][1]=B21; B[2][2]=B22; B[2][3]=B23;
B[3][0]=B30; B[3][1]=B31; B[3][2]=B32; B[3][3]=B33;

// Reference multiplication
for(i=0;i<4;i=i+1)
for(j=0;j<4;j=j+1) begin
    C_exp[i][j]=0;
    for(k=0;k<4;k=k+1)
        C_exp[i][j] = C_exp[i][j] + A[i][k]*B[k][j];
end

#100;

$display("Output Matrix C:");
$display("%d %d %d %d",C00,C01,C02,C03);
$display("%d %d %d %d",C10,C11,C12,C13);
$display("%d %d %d %d",C20,C21,C22,C23);
$display("%d %d %d %d",C30,C31,C32,C33);

// Verification
if(C00!=C_exp[0][0]) errors=errors+1;
if(C01!=C_exp[0][1]) errors=errors+1;
if(C02!=C_exp[0][2]) errors=errors+1;
if(C03!=C_exp[0][3]) errors=errors+1;

if(C10!=C_exp[1][0]) errors=errors+1;
if(C11!=C_exp[1][1]) errors=errors+1;
if(C12!=C_exp[1][2]) errors=errors+1;
if(C13!=C_exp[1][3]) errors=errors+1;

if(C20!=C_exp[2][0]) errors=errors+1;
if(C21!=C_exp[2][1]) errors=errors+1;
if(C22!=C_exp[2][2]) errors=errors+1;
if(C23!=C_exp[2][3]) errors=errors+1;

if(C30!=C_exp[3][0]) errors=errors+1;
if(C31!=C_exp[3][1]) errors=errors+1;
if(C32!=C_exp[3][2]) errors=errors+1;
if(C33!=C_exp[3][3]) errors=errors+1;

if(errors==0)
    $display("TEST PASSED");
else
    $display("TEST FAILED with %d errors",errors);

#50 $finish;

end

endmodule
