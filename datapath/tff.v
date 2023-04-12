module tff (
            clk,
            rst,
            t,
            q
  
);
input wire clk, // 클럭 입력
            rst, // 리셋 입력
            t    // T 입력
 ; 
output reg q; // 출력
  always @(posedge clk, posedge rst) begin
    if (rst) begin
      q <= 1'b0; // 리셋 시 초기화
    end else begin
      if (t) begin
        q <= ~q; // T 값에 따라 토글
      end
    end
  end

endmodule
