`include "spi.v"
`timescale 1ps/1ps
module spitb ();
reg clk,reset;
reg [15:0] datain;
wire spi_cs_l,spi_clk,spi_data;
wire [4:0]counter;
SPI_STATE DUT(.clk(clk),
        .reset(reset),
        .datain(datain),
        .spi_cs_l(spi_cs_l),
        .spi_clk(spi_clk),
        .spi_data(spi_data));
initial begin
    clk=1'b0;
    reset=1'b1;
    datain=16'h0;
end
initial forever begin
    #5 clk=~clk;
end
initial begin
  #10 reset =1'b0;
  #10 datain=16'd2679;
  #335 datain=16'd6876;
  #335 datain=16'd6968;
  #335 datain=16'd9800;
  #335 datain=16'd9975;
end
initial begin
    #2000 $finish;
end
initial begin
    $dumpvars;
    $dumpfile("spi.vcd");
    $monitor("%t,clk=%b,reset=%b,spiclk=%b,spicsl=%b,counter=%d,datain=%d,spidata=%d",$time,clk,reset,spi_clk,spi_cs_l,counter,datain,spi_data);
end
    
endmodule
