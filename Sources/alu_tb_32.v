`timescale 1ns / 1ps
module alu_tb_32;

  reg clk;
  reg rst;
  reg [31:0] a;
  reg [31:0] b;
  reg [2:0] sel;
  wire carry_out;
  wire [32:0] out;

  ALU_32 uut  (
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .sel(sel),
    .carry_out(carry_out),
    .out(out)
  );

  always #5 clk = ~clk;
  initial begin
    clk=0;
    rst=1;
   $sdf_annotate("delay_sdf.sdf", uut);
    $dumpfile("alu_wv.vcd");
    $dumpvars(0,alu_tb_32);
    $monitor("Time=%f | a=%d, b=%d, sel=%b, out=%d, carry_out=%b",$realtime, a, b, sel, out, carry_out);

    
    #10;
    rst=0;

    a=0;
    b=0;
    sel=0;

    #20;
    a = 32'hFFFFFFFF;  // 15
    b = 32'h00000001;  // 1
    #1;
    sel = 3'b000;        #20;

    a = 32'h0000000F;  // 15
    b = 32'h00000001;  // 1
    #1;

    sel = 3'b001;         #20;

    a = 32'h000000F0;  // 240
    b = 32'h000000AA;  // 170
    #1;
    sel = 3'b010;
    #20;

    a = 32'h000000F0;  // 240
    b = 32'h000000AA;  // 170
    #1;
    sel = 3'b011;
    #20;

    a = 32'h000000F0;   // 240
    b = 32'h000000AA;  // 170
    #1;
    sel = 3'b100;
    #20;

    a = 32'h000000F0;  // 240
    b = 32'h000000AA;  // 170
    #1;
    sel = 3'b101;
    #20;

    a = 32'b00000000;  // 0
    b = 32'b0000;
    #1;
    sel = 3'b111;
    #20 $finish;
    end
endmodule

