
module trafficlight(HighwayTL1,HighwayTL2,FARMTL1,FARMTL2,GO,CLK,RST);
  input CLK,RST,GO;
   reg [4:0] c;
  output reg [1:0] HighwayTL1,HighwayTL2,FARMTL1,FARMTL2;  

  reg [4:0] Prstate,Nxtstate;
  parameter G=2'b00,Y=2'b01,R=2'b10,RY=2'b11; 
  parameter S0=5'b00000 , S1=5'b00001 , S2=5'b00010, S3=5'b00011 , S4=5'b00100 , S5=5'b00101 , S6=5'b00110 , S7=5'b00111  , S8=5'b01000, S9=5'b01001,
  S10=5'b01010, S11=5'b01011,  S12=5'b01100 , S13=5'b01101, S14=5'b01110, S15=5'b01111, S16=5'b10000, S17=5'b10001;	 // states declaration	
  
  
  always@(posedge CLK or negedge RST)	//Synchronous system.																   
begin	   
        if (~RST)begin  Prstate = S0;  c=0; end  // When RST =0 It returns the design to state 0, and counter to 0 
	  
   	    else 
			 
          case (Prstate) 
		 S0: if (c<1) begin   Prstate = S0;	  // if the counter doesn't reach the required delay ,the present state will not change
		 if(GO)  begin c=c+1; end end	// if (GO=1) increment the counter by 1 every time until reaches the desired delay ,if GO=0 thats mean (freeze) counter will stop counting			   
		 else begin  Prstate = S1;  c=1; end   //   if the counter reach the required delay	move to the next state
		 
		 S1: if (c<2) begin   Prstate = S1;   if(GO) begin c=c+1; end  end  else begin  Prstate = S2;   c=1; end 
		 S2: if (c<30)begin   Prstate = S2;   if(GO) begin c=c+1; end  end  else begin  Prstate = S3;   c=1; end
		 S3: if (c<2) begin   Prstate = S3;   if(GO) begin c=c+1; end  end  else begin  Prstate = S4;   c=1; end
		 S4: if (c<10)begin   Prstate = S4;   if(GO) begin c=c+1; end  end  else begin  Prstate = S5;   c=1; end
		 S5: if (c<2) begin   Prstate = S5;   if(GO) begin c=c+1; end  end  else begin  Prstate = S6;   c=1; end
		 S6: if (c<1) begin   Prstate = S6;   if(GO) begin c=c+1; end  end  else begin  Prstate = S7;   c=1; end
		 S7: if (c<2) begin   Prstate = S7;   if(GO) begin c=c+1; end  end  else begin  Prstate = S8;   c=1; end
		 S8: if (c<15)begin   Prstate = S8;   if(GO) begin c=c+1; end  end  else begin  Prstate = S9;   c=1; end
		 S9: if (c<2) begin   Prstate = S9;   if(GO) begin c=c+1; end  end  else begin  Prstate = S10;  c=1; end
		 S10:if (c<5) begin   Prstate = S10;  if(GO) begin c=c+1; end  end  else begin  Prstate = S11;  c=1; end
		 S11:if (c<2) begin   Prstate = S11;  if(GO) begin c=c+1; end  end  else begin  Prstate = S12;  c=1; end
		 S12:if (c<10)begin   Prstate = S12;  if(GO) begin c=c+1; end  end  else begin  Prstate = S13;  c=1; end
		 S13:if (c<2) begin   Prstate = S13;  if(GO) begin c=c+1; end  end  else begin  Prstate = S14;  c=1; end
		 S14:if (c<1) begin   Prstate = S14;  if(GO) begin c=c+1; end  end  else begin  Prstate = S15;  c=1; end
		 S15:if (c<2) begin   Prstate = S15;  if(GO) begin c=c+1; end  end  else begin  Prstate = S16;  c=1; end
		 S16:if (c<15)begin   Prstate = S16;  if(GO) begin c=c+1; end  end  else begin  Prstate = S17;  c=1; end
		 S17:if (c<3) begin   Prstate = S17;  if(GO) begin c=c+1; end  end  else begin  Prstate = S0;   c=1; end
         endcase   	
end	



	
always @(Prstate ) //Evaluate output
	   begin  
		   		// using Karnaugh map implemantation 
		  HighwayTL1={(Prstate[3]|~Prstate[2]&~Prstate[1]|Prstate[2]&Prstate[1]),(~Prstate[4]&~Prstate[3]&~Prstate[1]&Prstate[0])};	
		  
		  HighwayTL2={(Prstate[2]|Prstate[3]|~Prstate[1]&~Prstate[4]),(~Prstate[3]&~Prstate[2]&Prstate[0]|Prstate[3]&Prstate[2]&Prstate[1]&Prstate[0])};
		  
		  FARMTL1={(~Prstate[3])|Prstate[2],(~Prstate[3]&Prstate[2]&Prstate[1]&Prstate[0]|Prstate[3]&~Prstate[2]&Prstate[1]&Prstate[0])};		
		  
		  FARMTL2={(~Prstate[3]|Prstate[1]),(Prstate[3]&~Prstate[2]&Prstate[0]
		  |Prstate[3]&~Prstate[1]&Prstate[0]|~Prstate[3]&Prstate[2]&Prstate[1]&Prstate[0])};	  
	   end		
	   
	   //  /Evaluate the outputs directly from the given table of all states  
	   /*	   
	        case (Prstate)								  						
		    S0: begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=R ; FARMTL2=R;end 
	    	S1: begin HighwayTL1=RY; HighwayTL2= RY; FARMTL1=R ; FARMTL2=R;end 
            S2: begin HighwayTL1=G ; HighwayTL2= G ; FARMTL1=R ; FARMTL2=R;end   
            S3: begin HighwayTL1=G ; HighwayTL2= Y ; FARMTL1=R ; FARMTL2=R;end
	        S4: begin HighwayTL1=G ; HighwayTL2= R ; FARMTL1=R ; FARMTL2=R;end	 
			S5: begin HighwayTL1=Y ; HighwayTL2= R ; FARMTL1=R ; FARMTL2=R;end 
			S6: begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=R ; FARMTL2=R;end 
			S7: begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=RY; FARMTL2=RY;end 
			S8: begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=G ; FARMTL2=G;end 
			S9: begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=G ; FARMTL2=Y;end 
			S10:begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=G ; FARMTL2=R;end 
			S11:begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=Y ; FARMTL2=RY;end 
			S12:begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=R ; FARMTL2=G;end 
			S13:begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=R ; FARMTL2=Y;end 
			S14:begin HighwayTL1=R ; HighwayTL2= R ; FARMTL1=R ; FARMTL2=R;end 				
			S15:begin HighwayTL1=R ; HighwayTL2= RY; FARMTL1=R ; FARMTL2=R;end 
			S16:begin HighwayTL1=R ; HighwayTL2= G ; FARMTL1=R ; FARMTL2=R;end 				
			S17:begin HighwayTL1=R ; HighwayTL2= Y ; FARMTL1=R ; FARMTL2=R;end  
	   */;
	   		 
endmodule


//////////////////////////////////////////////
module analyzer(CLK,My_Result,Correct_Result); 	// To do Design Verification by comparing the correct output and the actual  output
	input CLK;
	
	input [7:0]  Correct_Result,My_Result;	 // My_Result -> the result from the previous fuctions , correctreslt -> from the testgenerator

	   
   		   always @	 (posedge CLK)
	 	if(Correct_Result != My_Result)
			$display("ERORR!!!  WRONG RESULTS");
			
			else	 	$display("PERFECT!!!  MATCHING RESULTS");
			 
		 endmodule	
		 
		 
///////////////////////////////////////////////		 
module test_generator(c,CLK,RST,Correct_Result);	//Calculate the correct output 
	input CLK,RST	;	  
	input [8:0] c;
	  parameter G=2'b00,Y=2'b01,R=2'b10,RY=2'b11;
	output reg[7:0] Correct_Result;	 
	
	
	always@(posedge CLK or c) begin 	   // Loop all possible outputs 
										  
      if(c<=1)        Correct_Result={R,R,R,R};	 
	  if(c>1 & c<3)   Correct_Result={RY,RY,R,R};
      if(c>3 & c<33)  Correct_Result={G,G,R,R};
      if(c>33 & c<35) Correct_Result={G,Y,R,R}; 
	  if(c>35& c<45)  Correct_Result={G,R,R,R};
  	  if(c>45 & c<47) Correct_Result={Y,R,R,R};  
      if(c>47 & c<48) Correct_Result={R,R,R,R}; 
      if(c>48 & c<50) Correct_Result={R,R,RY,RY}; 
	  if(c>50 & c<65) Correct_Result={R,R,G,G};
	  if(c>65 & c<67) Correct_Result={R,R,G,Y};
	  if(c>67 & c<72) Correct_Result={R,R,G,R};
	  if(c>72 & c<74) Correct_Result={R,R,Y,RY};
      if(c>74 & c<84) Correct_Result={R,R,R,G};
      if(c>84 & c<86) Correct_Result={R,R,R,Y};
	  if(c>86 & c<87) Correct_Result={R,R,R,R};
	  if(c>87 & c<89) Correct_Result={R,RY,R,R};
	  if(c>89 & c<104)Correct_Result={R,G,R,R};
	  if(c>104 & c<107)Correct_Result={R,Y,R,R};
	  
	
		 	end
	endmodule
			
//////////////////////////////////////////////////////////////



module test_circuit;	// testbench  for applying stimulus to the design in order to test it and observe its response during simulation.

  reg CLK,RST,GO;
  wire[1:0] HighwayTL1,HighwayTL2,FARMTL1,FARMTL2;

  
  trafficlight dd(.HighwayTL1(HighwayTL1),.HighwayTL2(HighwayTL2),.FARMTL1(FARMTL1),.FARMTL2(FARMTL2),.GO(GO),.CLK(CLK),.RST(RST));

  
  initial begin
   RST = 0; CLK = 0 ;GO=0; ;
   #5ns RST = 1 ;
   #20ns GO=1;
  
   repeat (450)	 
   #1ns CLK = ~CLK;    	
 
  end
  
   initial begin
      repeat (7)
   #20ns GO = ~GO; 
   end	
   
   initial begin
       #330ns RST=0;
	   #10ns RST =1;
    end 
		  	  
endmodule	   



///////////////////////////////////////	



module test_with_analyzer;	// code verfiction using analyzer 
	reg CLK,RST,GO ;
	reg[8:0] c; 
  reg[7:0]   Correct_Result,My_Result;	
  wire[1:0] HighwayTL1,HighwayTL2,FARMTL1,FARMTL2;

  
  trafficlight dd(.HighwayTL1(HighwayTL1),.HighwayTL2(HighwayTL2),.FARMTL1(FARMTL1),.FARMTL2(FARMTL2),.GO(GO),.CLK(CLK),.RST(RST));
   test_generator dd3(.c(c),.CLK(CLK),.RST(RST),.Correct_Result(Correct_Result));
   analyzer dd2(.CLK(CLK),.My_Result(My_Result),.Correct_Result(Correct_Result));
   
      
   	  initial begin
       c=0;	
   repeat (200)
	
	   #2ns c=c+1;			 // test for all cases (states). 
   end	
    initial begin
   RST = 0; CLK = 0 ;GO=1;
		   #1ns RST=1;

   repeat (350)begin	

	   #1ns CLK = ~CLK;		
   	#0ns My_Result={HighwayTL1,HighwayTL2,FARMTL1,FARMTL2}; // set the 4 traffic outputs as 8 bit value to make it easier to compare with the correct results
   end	
   end	 
	endmodule