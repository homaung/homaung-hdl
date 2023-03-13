module spreg(
    clk         ,
    ce          ,
    we          ,
    addr        ,
    data           ,
    q   
);
// input & output
input                   clk         ;
input                   ce          ;
input                   we          ; 
input       [      7:0] addr        ;
input       [      2:0] data        ;
output      [      2:0] q           ;

// wire & regs
reg         [      2:0]  mem[0:7]  ;
reg         [      7:0]  r_addr     ;


always @ (posedge clk)
begin
    if (ce)  begin
        if (we) begin
            mem[addr] <= data;
        end 

        r_addr <= addr;
    end
end

assign q = mem[r_addr];

endmodule