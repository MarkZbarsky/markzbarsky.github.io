//Sword_module
module sword_fsm(
	input logic clk, reset,
	input logic [2:0] curr_room, 
	output logic has_sword
);
typedef enum logic {
NO_SWORD = 1'b0,
HAS_SWORD = 1'b1
} sword_state;

sword_state state, next_state;

//flip flop logic
always_ff @(posedge clk, posedge reset) begin
	if (reset)
		state <= NO_SWORD;
	else
		state <= next_state;
end

//next state logic
always_comb begin
	case (state)
		NO_SWORD: begin
			if (curr_room == 3'b011) //secret stash room
				next_state = HAS_SWORD;
			
			else 
				next_state = NO_SWORD;
		end	
		HAS_SWORD: next_state = HAS_SWORD;
		default: next_state = NO_SWORD;
	endcase
end

assign has_sword = (state == HAS_SWORD);

endmodule