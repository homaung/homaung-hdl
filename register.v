







module register ( data,
                  reset,
                  q,
                  select,
                  clk
    );
    
input wire [2:0] data;
input wire reset;
input wire select;
input wire clk;
output reg [2:0] q;

reg [2:0] ns;

always @ (posedge clk, negedge reset)
begin
    if (!reset)
      q <= 3'b000;
    else
      q <= ns;
end
always @ (select)
begin
    if(!select)
        ns <= q;
      else
        ns <= data;  
end

endmodule
