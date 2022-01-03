module InputBuffer(
	//Specify each port as input or output
	input clk,u1,u2,u3,d2,d3,d4,done,
	output reg [5:0] button_out,
	output qEmpty
	
); 

	//Specify primary datatype in Verilog for parameter inputbuffer which is 6 bits
	reg [5:0] inputbuffer; 

   //Initialize parameters in this module
	initial begin
		button_out<=3'b0;
		inputbuffer<=6'b0;
	end 
	
	always @ (posedge clk) begin
		//Reset the inputbuffer parameters at positive clk edge if last request has been processed
		case (button_out)
			6'b000001:	inputbuffer[0]=0;
			6'b000010:	inputbuffer[1]=0;
			6'b000100:	inputbuffer[2]=0;
			6'b001000:	inputbuffer[3]=0;
			6'b010000:	inputbuffer[4]=0;
			6'b100000:	inputbuffer[5]=0;		
		endcase
				
		//Record all the inputs in this clock cycle according to the button
		if(u1) inputbuffer[0]=1; 
		if(u2) inputbuffer[1]=1; 
		if(u3) inputbuffer[2]=1; 
		if(d2) inputbuffer[3]=1; 
		if(d3) inputbuffer[4]=1; 
		if(d4) inputbuffer[5]=1; 

		//Deliver input request to LiftFSM module in order of priority:1U, 2U, 3U, 2D, 3D, 4D
		if(done) begin		
			if(inputbuffer[0])      button_out=6'b000001;
			else if(inputbuffer[1]) button_out=6'b000010;
			else if(inputbuffer[2]) button_out=6'b000100;
			else if(inputbuffer[3]) button_out=6'b001000;
			else if(inputbuffer[4]) button_out=6'b010000;
			else if(inputbuffer[5]) button_out=6'b100000;
		end				
	end
	
	//Set value of qEmpty as 1 if there are no further input requests to be processed
	assign qEmpty=	(!inputbuffer[0])&&(!inputbuffer[1])&&(!inputbuffer[2])&&
						(!inputbuffer[3])&&(!inputbuffer[4])&&(!inputbuffer[5]);	
						
endmodule