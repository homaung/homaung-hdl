module rom_7_tb;

  wire [7:0] a;
  reg b;
  wire [7:0] c;
  reg clk;
  reg reset;
  reg count_enb;

  //instance
  counter_8bit_enable tb_rom_7_tb (
    .clk(clk),
    .reset(reset),
    .count_enb(count_enb),
    .count(a)
  );

  rom_7 dut(.a(a), .b(b), .c(c));
  

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // Reset assertion
  initial begin
    reset = 1;
    count_enb = 1;   
    b = 0;
    #80 reset = 0;
    #80 reset = 1;
        count_enb = 0;
    #80 count_enb = 1;
    #80 count_enb = 0;
    #80 count_enb = 1;
        b = 0;
   #240 count_enb = 1;
        b = 1;
    #2000 $finish;
  end
  
endmodule
