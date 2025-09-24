module room_fsm (
	input logic clk, reset,
	input logic N, S, E, W,
	input logic has_sword,
	output logic [2:0] curr_room,
	output logic WIN, DIE
);

typedef enum logic [2:0] {
CAVE_CACOPHONY = 3'b000,
TWISTY_TUNNEL = 3'b001,
RAPID_RIVER = 3'b010,
SECRET_SWORD = 3'b011,
DRAGON_DEN = 3'b100,
GREVIOUS_GRAVEYARD = 3'b101,
VICTORY_VAULT = 3'b110
} room_state;

room_state state, next_state;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= CAVE_CACOPHONY;
		else
			state <= next_state;
	end
	
	always_comb begin
	
		case (state)
			CAVE_CACOPHONY: begin
				if (E) next_state = TWISTY_TUNNEL;
				else next_state = CAVE_CACOPHONY;
			end
			TWISTY_TUNNEL: begin
				if (W) next_state = CAVE_CACOPHONY;
				else if (S) next_state = RAPID_RIVER;
				else next_state = TWISTY_TUNNEL;
			end
			RAPID_RIVER: begin
				if (W) next_state = SECRET_SWORD;
				else if (N) next_state = TWISTY_TUNNEL;
				else if (E) next_state = DRAGON_DEN;
				else next_state = RAPID_RIVER;
			end
			SECRET_SWORD: begin
				if (E) next_state = RAPID_RIVER;
				else next_state = SECRET_SWORD;
			end
			DRAGON_DEN: begin
				if (E) begin
					if (has_sword) next_state = VICTORY_VAULT;
					else next_state = GREVIOUS_GRAVEYARD;
				end
				else next_state = DRAGON_DEN;
			end
			GREVIOUS_GRAVEYARD: next_state = GREVIOUS_GRAVEYARD;		
			VICTORY_VAULT: next_state = VICTORY_VAULT;
	
			default: next_state = CAVE_CACOPHONY;
		endcase
	end
	
	
	assign curr_room = state;
	assign WIN = (state == VICTORY_VAULT);
	assign DIE = (state == GREVIOUS_GRAVEYARD);
endmodule