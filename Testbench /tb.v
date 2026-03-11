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

// Expected output registers
reg [31:0] exp_C00,exp_C01,exp_C02,exp_C03;
reg [31:0] exp_C10,exp_C11,exp_C12,exp_C13;
reg [31:0] exp_C20,exp_C21,exp_C22,exp_C23;
reg [31:0] exp_C30,exp_C31,exp_C32,exp_C33;

// Reference matrices for multiplication
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

// Clock generation
initial clk=0;
always #5 clk=~clk;

initial
begin

rst=1;
#10 rst=0;

// Matrix A values
A00=1;A01=0;A02=0;A03=4;
A10=5;A11=6;A12=0;A13=0;
A20=0;A21=1;A22=2;A23=3;
A30=0;A31=5;A32=0;A33=0;

// Matrix B values
B00=1;B01=2;B02=3;B03=4;
B10=5;B11=6;B12=7;B13=8;
B20=9;B21=1;B22=2;B23=3;
B30=4;B31=5;B32=6;B33=7;

// Store values into arrays for reference multiplication
A[0][0]=A00; A[0][1]=A01; A[0][2]=A02; A[0][3]=A03;
A[1][0]=A10; A[1][1]=A11; A[1][2]=A12; A[1][3]=A13;
A[2][0]=A20; A[2][1]=A21; A[2][2]=A22; A[2][3]=A23;
A[3][0]=A30; A[3][1]=A31; A[3][2]=A32; A[3][3]=A33;

B[0][0]=B00; B[0][1]=B01; B[0][2]=B02; B[0][3]=B03;
B[1][0]=B10; B[1][1]=B11; B[1][2]=B12; B[1][3]=B13;
B[2][0]=B20; B[2][1]=B21; B[2][2]=B22; B[2][3]=B23;
B[3][0]=B30; B[3][1]=B31; B[3][2]=B32; B[3][3]=B33;

// Reference matrix multiplication
for(i=0;i<4;i=i+1)
begin
    for(j=0;j<4;j=j+1)
    begin
        C_exp[i][j]=0;
        for(k=0;k<4;k=k+1)
        begin
            C_exp[i][j] = C_exp[i][j] + A[i][k]*B[k][j];
        end
    end
end

// Map expected values
exp_C00=C_exp[0][0]; exp_C01=C_exp[0][1]; exp_C02=C_exp[0][2]; exp_C03=C_exp[0][3];
exp_C10=C_exp[1][0]; exp_C11=C_exp[1][1]; exp_C12=C_exp[1][2]; exp_C13=C_exp[1][3];
exp_C20=C_exp[2][0]; exp_C21=C_exp[2][1]; exp_C22=C_exp[2][2]; exp_C23=C_exp[2][3];
exp_C30=C_exp[3][0]; exp_C31=C_exp[3][1]; exp_C32=C_exp[3][2]; exp_C33=C_exp[3][3];

#100;

$display("Output Matrix C:");
$display("%d %d %d %d", C00, C01, C02, C03);
$display("%d %d %d %d", C10, C11, C12, C13);
$display("%d %d %d %d", C20, C21, C22, C23);
$display("%d %d %d %d", C30, C31, C32, C33);

// Self-checking comparisons
if(C00!==exp_C00) begin $display("Mismatch C00"); errors=errors+1; end
if(C01!==exp_C01) begin $display("Mismatch C01"); errors=errors+1; end
if(C02!==exp_C02) begin $display("Mismatch C02"); errors=errors+1; end
if(C03!==exp_C03) begin $display("Mismatch C03"); errors=errors+1; end

if(C10!==exp_C10) begin $display("Mismatch C10"); errors=errors+1; end
if(C11!==exp_C11) begin $display("Mismatch C11"); errors=errors+1; end
if(C12!==exp_C12) begin $display("Mismatch C12"); errors=errors+1; end
if(C13!==exp_C13) begin $display("Mismatch C13"); errors=errors+1; end

if(C20!==exp_C20) begin $display("Mismatch C20"); errors=errors+1; end
if(C21!==exp_C21) begin $display("Mismatch C21"); errors=errors+1; end
if(C22!==exp_C22) begin $display("Mismatch C22"); errors=errors+1; end
if(C23!==exp_C23) begin $display("Mismatch C23"); errors=errors+1; end

if(C30!==exp_C30) begin $display("Mismatch C30"); errors=errors+1; end
if(C31!==exp_C31) begin $display("Mismatch C31"); errors=errors+1; end
if(C32!==exp_C32) begin $display("Mismatch C32"); errors=errors+1; end
if(C33!==exp_C33) begin $display("Mismatch C33"); errors=errors+1; end

// Final result
if(errors==0)
    $display("TEST PASSED");
else
    $display("TEST FAILED with %d errors",errors);

#200 $finish;

end

endmodule
