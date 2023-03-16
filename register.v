module register ( data,
                  reset,
                  q,
                  select,
                  clk
    );


//Parameter
parameter A=8, D=8;     // A : Adress width    D : Data width  

//wire&reg
input wire [D-1:0] data;
input wire reset;
input wire select;
input wire clk;
output reg [D-1:0] q;

reg [D-1:0] ns;



//logic
always @ (posedge clk, negedge reset)
    begin
        if (!reset)
            q <= 7'b00000000;
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