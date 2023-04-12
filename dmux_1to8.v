module dmux_1to8(    a,
                    
                    sel,
                    out1,
                    out2
            
    );

//Parameter
parameter A=8, D=8;    // A : Adress width    D : Data width 



//wire&reg
input wire [A-1:0] a;
input wire sel;
output reg [A-1:0] out1;
output reg [A-1:0] out2;


//logic
always @ (sel)
   begin
      if(sel)
          begin
         out1<=a;
         out2<=8'b00000000;
         end
      else  
           begin           
         out1<=8'b00000000;
         out2<=a;
         end
   end        
  
endmodule