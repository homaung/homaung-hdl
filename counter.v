module counter(clk,
               reset,
               count_enble,
               count
);

input wire clk;         
input wire reset;
input wire count_enble;       
output reg [5:0] count;
reg [5:0] q = 6'b111111;
reg [5:0] q1;
    
always @(posedge clk,negedge reset)
    begin
       if (!reset) 
          begin
             count <= 6'b000000; 
          end 
       else
          begin
             if(count_enble==1'b0)
                begin
                   count <= count;
                end              
             else
                begin
                   if (q1) 
                      begin
                         count <= 6'b000000; 
                      end 
                   else 
                      begin
                         count <= count + 1;
                      end
                end       
           end
    end
   

always @(count,q)
   begin
      if(count==q)
            if(count_enble==1'b1)
               q1<=1'b1;
            else             
               q1<=1'b0;
         
   end        

endmodule