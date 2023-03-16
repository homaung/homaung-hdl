module search (data1,
               data2,
               reset1,
               reset2,
               clk,
               select1,
               select2,
               q4,
               q5             
               );
               

//Parameter
parameter A=8,  D=8;    // A : Adress width    D : Data width    

//wire&reg
input wire [D-1:0] data1;
input wire [D-1:0] data2;
    
input wire reset1;
input wire reset2;
input wire clk;

wire [A-1:0] q1;  
wire [A-1:0] q2;  
reg q3;
output wire q4;
output wire q5;

input wire select1;
input wire select2;



//Instance
register_8bits search_reg1(.data(data1), .reset(reset1),.q(q1), .select(select1), .clk(clk));
register_8bits search_reg2(.data(data2), .reset(reset2),.q(q2), .select(select2), .clk(clk)); 




//logic
always@(q1,q2)
  begin
    if(q1==q2)
        q3<=1'b1;
    else             
        q3<=1'b0;
    end                                                 
                                                    
assign q4 = ~q3;            
assign q5 = q3;    

 
endmodule

