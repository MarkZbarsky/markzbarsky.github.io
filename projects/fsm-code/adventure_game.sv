module adventure_game(
	input logic clk, reset,
	input logic N, S, E, W,
	output logic WIN, DIE
	);
	
	logic [2:0] curr_room;
	logic has_sword;
	
	room_fsm room (
		.clk(clk),
		.reset(reset),
		.N(N), .S(S), .E(E), .W(W),
		.has_sword(has_sword),
		.curr_room(curr_room),
		.WIN(WIN),
		.DIE(DIE)
	);
	sword_fsm sword (
		.clk(clk),
		.reset(reset),
		.curr_room(curr_room),
		.has_sword(has_sword)
	);
	
endmodule