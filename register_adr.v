module register_adr(data,
                  reset,
                  q,
                  select,
                  clk
    );



parameter A=8,  D=8, R=256; // A : Adress width    D : Data width    R : 2^A


//wire&reg
input wire [A-1:0] data;
input wire reset;
input wire select;
input wire clk;
output reg [A-1:0] q;
reg [A-1:0] ns;




//logic
always @ (posedge clk, negedge reset)
    begin
        if (!reset)
            q <= 8'b00000000;
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