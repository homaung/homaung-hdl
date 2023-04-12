module counter_8bit_enable_tb;

  // DUT instantiation
  reg clk;
  reg reset;
  reg count_enb;
  wire [7:0] count;
  counter_8bit_enable dut (
    .clk(clk),
    .reset(reset),
    .count_enb(count_enb),
    .count(count)
  );
  
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // Reset assertion
  initial begin
    reset = 1;
    count_enb = 1;   
    #80 reset = 0;
    #80 reset = 1;
     count_enb = 0;
    #80 count_enb = 1;
    #80 count_enb = 0;
    #80 count_enb = 1;
    #2000 $finish;
  end
  
endmodule
