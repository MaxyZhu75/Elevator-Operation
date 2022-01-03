`timescale 1 ns/ 1 ns

module Stimulus();

//Specify the clock signal, input signals and their primary datatype
reg clk;
reg d2;
reg d3;
reg d4;
reg u1;
reg u2;
reg u3;

//Specify output signals and its primary datatype
wire [1:0] out;

//Specify control signals and their primary datatype and make connection between LiftFSM and Inputbuffer
wire done;
wire qEmpty;
wire [5:0] button;

//Declare clock cycle
parameter CYCLE = 2;

//Instantiate the first module LiftFSM
LiftFSM uut_LiftFSM(
	.clk		   	(clk   ),
	.button_in		(button),
	.qEmpty			(qEmpty),
	.out		    	(out   ),
	.done		   	(done  )
);

//Instantiate the second module InputBuffer
InputBuffer uut_InputBuffer(
	.clk		   	(clk   ),	
	.u1				(u1    ),
	.u2				(u2    ),
	.u3				(u3    ),
	.d2				(d2    ),
	.d3				(d3    ),
	.d4				(d4    ),
	.done		   	(done  ),
	.button_out	  	(button),
	.qEmpty			(qEmpty)
);

//Generate and initialize the clock signal
initial begin
	clk = 0;
	forever
	#(CYCLE/2)
	clk=~clk;
end

//Initialize input signals for the simulation
initial begin                                                  
	#1	   u2=1;
	#1 	u2=0;
	#3	   u3=1;
	#1 	u3=0;
	#3 	u1=1;
			d2=1;
			d3=1;
	#1 	u1=0;
			d2=0;
			d3=0;
	#1	   d3=1;
	#1	   d3=0;
	#3	   d4=1;
	#1	   d4=0;
$display("Stimulus has already finished.");                       
end 

endmodule