module random_generator(
  input clk,
  input enable,
  output reg [7:0] rand_num
);

  reg [7:0] seed = 8'h7F; // seed 초기값 설정
  
  always @(posedge clk) begin
    if (enable) begin
      seed = seed * 1103515245 + 12345; // 32비트 상수 LCG 계산
      rand_num = seed[7:0]; // 상위 8비트가 아닌 하위 8비트를 출력
    end
  end

endmodule