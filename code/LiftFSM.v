module LiftFSM(
	//Specify each port as input or output
	input clk,
	input [5:0] button_in,
	input qEmpty,
	output reg [1:0] out,
	output reg done
	
);
	
	//Specify primary datatype in Verilog for present state and next state which are both 4 bits
	reg [3:0] ps;	
	reg [3:0] ns;
	
	//Define module parameters for each state in this FSM
	localparam s1=4'b0000;
	localparam s2=4'b0001;
	localparam s3=4'b0010;
	localparam s4=4'b0011;
	localparam s12=4'b0100;
	localparam s23=4'b0101;
	localparam s34=4'b0110;
	localparam s21=4'b1000;
	localparam s32=4'b1001;
	localparam s43=4'b1010;

	//Define module parameters for output in this FSM
	localparam STAY=2'b00;
	localparam UP=2'b01;
	localparam DOWN=2'b10;
	
   //Initialize parameters in this module
	initial begin
		ps=s1;
		ns=s1;
		out=STAY;		
	end

	always @ (qEmpty or ps or button_in) begin
		//Stay in the same state when stystem is idle and no further input requests
		if(qEmpty && done) begin		
			ns=ps;
			out<=STAY;
		end
		else begin
			case (ps)
			//Describe the behavior according to the state diagram
			s1: begin
				case (button_in)
				6'b000001: begin	//button 1U
					ns=s2;	
					out=UP;		
					done=1;
				end
				6'b000010: begin	//button 2U
					ns=s23;	
					out=UP;		
					done=0;
				end
				6'b000100: begin	//button 3U
					ns=s34;	
					out=UP;		
					done=0;
				end
				6'b001000: begin	//button 2D
					ns=s21;
					out=UP;	
					done=0;
				end
				6'b010000: begin	//button 3D
					ns=s32;
					out=UP;	
					done=0;
				end
				6'b100000: begin	//button 4D
					ns=s43;
					out=UP;	
					done=0;
				end
				default: begin  	//other invalid input request
					ns=s1;	
					out=STAY;
					done=1;	
				end
				endcase
			end
			s2: begin
				case (button_in)
				6'b000001: begin	//button 1U
					ns=s12;	
					out=DOWN;	
					done=0;
				end
				6'b000010: begin	//button 2U
					ns=s3;	
					out=UP;		
					done=1;
				end
				6'b000100: begin	//button 3U
					ns=s34;
					out=UP;		
					done=0;
				end
				6'b001000: begin	//button 2D
					ns=s1;	
					out=DOWN;	
					done=1;
				end
				6'b010000: begin	//button 3D
					ns=s32;	
					out=UP;		
					done=0;
				end
				6'b100000: begin	//button 4D
					ns=s43;	
					out=UP;	
					done=0;
				end
				default: begin	   //other invalid input request
					ns=s2;	
					out=STAY;	
					done=1;
				end
				endcase
			end
			s3: begin
				case (button_in)
				6'b000001: begin	//button 1U
					ns=s12;	
					out=DOWN;
					done=0;
				end
				6'b000010: begin	//button 2U
					ns=s23;	
					out=DOWN;
					done=0;
				end
				6'b000100: begin	//button 3U
					ns=s4;	
					out=UP;		
					done=1;
				end
				6'b001000: begin	//button 2D
					ns=s21;
					out=DOWN;
					done=0;
				end
				6'b010000: begin	//button 3D
					ns=s2;
					out=DOWN;
					done=1;
				end
				6'b100000: begin	//button 4D
					ns=s43;	
					out=UP;	
					done=0;
				end
				default: begin	   //other invalid input request
					ns=s3;	
					out=STAY;	
					done=1;
				end
				endcase
			end
			s4: begin
				case (button_in)
				6'b000001: begin	//button 1U
					ns=s12;	
					out=DOWN;	
					done=0;
				end
				6'b000010: begin	//button 2U
					ns=s23;	
					out=DOWN;
					done=0;
				end
				6'b000100: begin	//button 3U
					ns=s34;
					out=DOWN;	
					done=0;
				end
				6'b001000: begin	//button 2D
					ns=s21;	
					out=DOWN;
					done=0;
				end
				6'b010000: begin	//button 3D
					ns=s32;	
					out=DOWN;	
					done=0;
				end
				6'b100000: begin	//button 4D
					ns=s3;	
					out=DOWN;
					done=1;
				end
				default: begin	   //other invalid input request
					ns=s4;	
					out=STAY;
					done=1;
				end
				endcase
			end
			s12: begin //state in first clk cycle for button 1U
				ns=s2;
				out=UP;	
				done=1;
			end
			s23: begin //state in first clk cycle for button 2U
				ns=s3;	
				out=UP;		
				done=1;
			end
			s34: begin //state in first clk cycle for button 3U
				ns=s4;	
				out=UP;	
				done=1;
			end
			s21: begin //state in first clk cycle for button 2D
				ns=s1;
				out=DOWN;	
				done=1;
			end
			s32: begin //state in first clk cycle for button 3D
				ns=s2;	
				out=DOWN;	
				done=1;
			end
			s43: begin //state in first clk cycle for button 4D
				ns=s3;	
				out=DOWN;
				done=1;
			end
			endcase
		end
	end
	
	always @ (posedge clk) begin
		ps<=ns;
	end
		
endmodule
