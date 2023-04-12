module mux_1to8_ls (a,
                    b,
                    sel,
                    out
            
    );

//Parameter
parameter A=8, D=8;    // A : Adress width    D : Data width 



//wire&reg
input wire [A-1:0] a;
input wire [A-1:0] b;
input wire sel;
output reg [A-1:0] out;



//logic
always @ (sel)
   begin
      if(sel)
         out<=a;
      else             
         out<=b;
   end        
  
endmodule
