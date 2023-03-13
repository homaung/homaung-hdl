

module ram(
    clk,
    rw,
    addr,
    data,
    q
    );
input  clk,
       rw;
input  [4:0] addr ;
input  [2:0] data;
output [2:0] q;

// wire & regs
reg         [      2:0]  mem[0:4]  ;
reg         [      4:0]  r_addr     ;


always @ (posedge clk)
begin
    if (rw)
     begin    
       mem[addr] <= data;
     end 
    else
     begin
      r_addr <= addr;
     end 
end
assign q = mem[r_addr];

endmodule 