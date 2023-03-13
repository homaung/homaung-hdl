





always @ (posedge clk, negedge reset)
    begin
    if (!reset)
         ps <= S0;
    else
         ps <= ns;
    end

always @ ()
   case()
      S0 : if()
              begin
                                
              end
           else
              begin
                                                                    
              end
      S1 : if()
              begin
                                            
              end
           else
              begin
                                        
              end
      S2 : if()
              begin
                                   
              end
           else
              begin
                                    
              end
      S3 : if()
              begin
                                   
              end
           else
              begin
                                    
              end
   endcase





always @ (sel)
   begin
      if(sel)
         q1<=a;
      else             
         q1<=b;
   end        
