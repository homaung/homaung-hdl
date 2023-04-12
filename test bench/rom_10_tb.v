module rom_main10_tb;

  wire [7:0] a;
  wire [2:0] b;
  reg clk;
  reg reset;
  reg count_enb;

  rom_main2 dut(.a(a), .b(b));
  
counter_8bit_enable tb_rom_2_tb (
    .clk(clk),
    .reset(reset),
    .count_enb(count_enb),
    .count(a)
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
    #2000 $finish;
  end
  

endmodule