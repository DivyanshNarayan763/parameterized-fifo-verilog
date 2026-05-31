module FIFO_parameterized(clk, rst, din, wr_en, rd_en, dout, full, empty);
  parameter DATA_WIDTH=8;
  parameter DEPTH=16;
  localparam ADDRESS_WIDTH = $clog2(DEPTH);
  input clk,rst,wr_en,rd_en;
  input [DATA_WIDTH-1:0]din;
  output reg [DATA_WIDTH-1:0]dout;
  output full,empty;
  reg [ADDRESS_WIDTH-1:0]wr_ptr, rd_ptr;
  reg [ADDRESS_WIDTH:0]count;
  reg [DATA_WIDTH-1:0]mem[0:DEPTH-1];
  
  assign full = (count==DEPTH);
  assign empty = (count==0);
  
  wire wr_success, rd_success;
  assign wr_success = wr_en && !full;
  assign rd_success = rd_en && !empty;
  
  always @(posedge clk) begin
    if(rst)
      begin
        wr_ptr<=0;
        rd_ptr<=0;
        dout<={DATA_WIDTH{1'b0}};
        count<=0;
      end
    else begin
      
    if(wr_en && !full) begin
      mem[wr_ptr] <= din;
      wr_ptr<= (wr_ptr==DEPTH-1)?0:wr_ptr+1;
    end
     if(rd_en && !empty) begin
      dout<=mem[rd_ptr];
      rd_ptr<=(rd_ptr==DEPTH-1)?0:rd_ptr+1;
    end
  end
    case({wr_success,rd_success})
      2'b10: count<=count+1;
      2'b01: count<=count-1;
      default: count<=count;
    endcase
  end
endmodule
      
      
  
    