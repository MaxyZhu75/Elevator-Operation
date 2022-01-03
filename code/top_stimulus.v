module top_stimulus(input clk,d2,d3,d4,u1,u2,u3,output [1:0] out);

//Specify control signals and their primary datatype and make connection between LiftFSM and Inputbuffer
wire done;
wire qEmpty;
wire [5:0] button;

//Instantiate the first module LiftFSM
LiftFSM uut_LiftFSM(
	.clk			   (clk   ),
	.button_in		(button),
	.qEmpty			(qEmpty),
	.out		   	(out   ),
	.done		   	(done  )
);

//Instantiate the second module InputBuffer
InputBuffer uut_InputBuffer(
	.clk			   (clk   ),	
	.u1				(u1    ),
	.u2				(u2    ),
	.u3				(u3    ),
	.d2				(d2    ),
	.d3				(d3    ),
	.d4				(d4    ),
	.done		    	(done  ),
	.button_out	   (button),
	.qEmpty			(qEmpty)
);

endmodule