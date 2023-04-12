module search(              
              q1      ,
              q2      ,
              q5      ,
              enble             
);
               

//Parameter
parameter
              A=8     ,     // A : Adress width    D : Data width 
              D=8
;       

//wire&reg
input   wire  enble   
;

input   wire  [D-1:0]                             
              q1      ,
              q2  
;  
reg           
              q3  
;
output  wire  
              q5  
;


//logic

always@(q1,q2   )
  begin
    if(q1==q2)
        q3  <=1'b1;
    else             
        q3  <=1'b0;
  end

assign q5   = q3 & enble;


 
endmodule



