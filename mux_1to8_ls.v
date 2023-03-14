module mux_1to8_ls (a,
                    b,
                    sel,
                    out
            
    );

//Parameter
parameter A=8,  D=8, R=256; // A : Adress width    D : Data width    R : 2^A



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
