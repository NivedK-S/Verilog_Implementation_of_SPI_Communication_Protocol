module SPI_STATE (
    input clk,
    input reset,
    input [15:0]datain,
    output spi_cs_l,
    output spi_clk,
    output spi_data,
    output [4:0] counter
);
reg [15:0] MOSI;
reg [4:0] count;
reg cs_l;
reg sclk;
reg [2:0]state;
always@(posedge clk or posedge reset)
if(reset)
begin
  MOSI<=16'd0;
  count<=5'd16;
  cs_l<=1'b1;
  sclk<=1'b0;
end
else
begin
  case(state)
  0:begin
    sclk<=1'b0;
    cs_l<=1'b1;
    state<=1;
  end
  1:begin
    sclk<=1'b1;
    cs_l<=1'b0;
    MOSI<=datain[count-1];
    count<=count-1;
    state<=2;
  end
  2:begin
    sclk<=1'b0;
    cs_l<=1'b1;
    if(count>0)
    state<=1;
    else
    begin
      count<=5'd16;
      state<=0;
    end
  end
  default:state<=0;
  endcase
end
assign spi_cs_l=cs_l;
assign spi_clk=sclk;
assign spi_data=MOSI;
assign counter=count;
    
endmodule