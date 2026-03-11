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
clk,rst,
A00,A01,A02,A03,
A10,A11,A12,A13,
A20,A21,A22,A23,
A30,A31,A32,A33,

B00,B01,B02,B03,
B10,B11,B12,B13,
B20,B21,B22,B23,
B30,B31,B32,B33,

C00,C01,C02,C03,
C10,C11,C12,C13,
C20,C21,C22,C23,
C30,C31,C32,C33
);

initial clk=0;
always #5 clk=~clk;

initial begin

rst=1;
#10 rst=0;

// Matrix A
A00=1;A01=0;A02=0;A03=4;
A10=5;A11=6;A12=0;A13=0;
A20=0;A21=1;A22=2;A23=3;
A30=0;A31=5;A32=0;A33=0;

// Matrix B
B00=1;B01=2;B02=3;B03=4;
B10=5;B11=6;B12=7;B13=8;
B20=9;B21=1;B22=2;B23=3;
B30=4;B31=5;B32=6;B33=7;

// Store into arrays
A[0][0]=A00; A[0][1]=A01; A[0][2]=A02; A[0][3]=A03;
A[1][0]=A10; A[1][1]=A11; A[1][2]=A12; A[1][3]=A13;
A[2][0]=A20; A[2][1]=A21; A[2][2]=A22; A[2][3]=A23;
A[3][0]=A30; A[3][1]=A31; A[3][2]=A32; A[3][3]=A33;

B[0][0]=B00; B[0][1]=B01; B[0][2]=B02; B[0][3]=B03;
B[1][0]=B10; B[1][1]=B11; B[1][2]=B12; B[1][3]=B13;
B[2][0]=B20; B[2][1]=B21; B[2][2]=B22; B[2][3]=B23;
B[3][0]=B30; B[3][1]=B31; B[3][2]=B32; B[3][3]=B33;

// Reference multiplication
#100;

$display("Output Matrix C:");

$display("%d %d %d %d", C00, C01, C02, C03);
$display("%d %d %d %d", C10, C11, C12, C13);
$display("%d %d %d %d", C20, C21, C22, C23);
$display("%d %d %d %d", C30, C31, C32, C33);

// Self-check directly using matrix formula

if(C00 != (A00*B00 + A01*B10 + A02*B20 + A03*B30)) errors = errors+1;
if(C01 != (A00*B01 + A01*B11 + A02*B21 + A03*B31)) errors = errors+1;
if(C02 != (A00*B02 + A01*B12 + A02*B22 + A03*B32)) errors = errors+1;
if(C03 != (A00*B03 + A01*B13 + A02*B23 + A03*B33)) errors = errors+1;

if(C10 != (A10*B00 + A11*B10 + A12*B20 + A13*B30)) errors = errors+1;
if(C11 != (A10*B01 + A11*B11 + A12*B21 + A13*B31)) errors = errors+1;
if(C12 != (A10*B02 + A11*B12 + A12*B22 + A13*B32)) errors = errors+1;
if(C13 != (A10*B03 + A11*B13 + A12*B23 + A13*B33)) errors = errors+1;

if(C20 != (A20*B00 + A21*B10 + A22*B20 + A23*B30)) errors = errors+1;
if(C21 != (A20*B01 + A21*B11 + A22*B21 + A23*B31)) errors = errors+1;
if(C22 != (A20*B02 + A21*B12 + A22*B22 + A23*B32)) errors = errors+1;
if(C23 != (A20*B03 + A21*B13 + A22*B23 + A23*B33)) errors = errors+1;

if(C30 != (A30*B00 + A31*B10 + A32*B20 + A33*B30)) errors = errors+1;
if(C31 != (A30*B01 + A31*B11 + A32*B21 + A33*B31)) errors = errors+1;
if(C32 != (A30*B02 + A31*B12 + A32*B22 + A33*B32)) errors = errors+1;
if(C33 != (A30*B03 + A31*B13 + A32*B23 + A33*B33)) errors = errors+1;

if(errors==0)
    $display("TEST PASSED");
else
    $display("TEST FAILED with %d errors", errors);

#50 $finish;

end

endmodule
