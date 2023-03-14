module spreg(
    clk         ,
    ce          ,
    we          ,
    addr        ,
    data        ,
    q   
);

parameter A=8,  D=8, R=256; // A : Adress width    D : Data width    R : 2^A

// input & output
input                   clk         ;
input                   ce          ;
input                   we          ; 
input       [      A-1:0] addr        ;
input       [      D-1:0] data        ;
output      [      D-1:0] q           ;

// wire & regs
reg         [      A-1:0]  mem[0:R-1]  ;
reg         [      A-1:0]  r_addr     ;


//logic
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