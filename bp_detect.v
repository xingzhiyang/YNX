module bp_detect (
				 reset,
				 clk,
				 bit_in,
				 en,
				 match
				  );

 
 input      reset,clk;
 input      bit_in;
 input      en;
 output     match;
 
 reg        match;
 
 reg   [2:0]     curr_state ;
 reg   [2:0]     Next_state ;
 
  parameter	 S0  = 2'b00,				            	//IDLE 
         		 S1  = 2'b01,                    //0
             S2  = 2'b10,                    //00   
				     S3  = 2'b11;                    //001
				
 always @(posedge clk )
 begin
   if (reset)
     curr_state <= 0;
   else 
     curr_state <= Next_state;
   end  
 
always @(*)
begin
 if (en)begin
  case(curr_state)
   S0:
     if (bit_in==0)
       Next_state = S1; 
     else
       Next_state = S0;  
   S1:
     if (bit_in==0)
       Next_state = S2; 
     else
       Next_state = S0;    
   S2:
     if (bit_in==1)
       Next_state = S3; 
     else
       Next_state = S2;  
   S3:
     if (bit_in==0)
       Next_state = S1; 
     else
       Next_state = S0;         
   default:
       Next_state = S0;    
  endcase
 end
 else begin
   Next_state = curr_state ;
 end
end
 
 
always @(posedge clk )
begin
    if(reset)   
	  match <= 1'b0;
	else if((curr_state== S3) && (bit_in ==0) && en)
	  match <= 1'b1;
	else
	  match <= 1'b0;
end

endmodule	

