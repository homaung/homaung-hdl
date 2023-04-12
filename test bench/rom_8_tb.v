module rom_8_tb;

  wire [7:0] a,d;
  
  reg b;
  wire [7:0] c;
  reg clk;
  reg reset;
  reg count_enb;

  //instance
  counter_8bit_enable tb_rom_8_tb (
    .clk(clk),
    .reset(reset),
    .count_enb(count_enb),
    .count(a)
  );


  rom_8 dut(.a(d), .b(b), .c(c));

  rom_9  rom_9_rom8_tb   (.a(a),                                // wire를 1bit right shift 시키는 모듈 1bit에는 0 출력 
                          .b(d) 
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
