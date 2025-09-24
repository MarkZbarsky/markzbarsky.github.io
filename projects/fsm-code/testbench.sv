module testbench;
    logic clk = 0;
    logic reset;
    logic N, S, E, W;
    logic WIN, DIE;
    
    // Instantiate DUT
    adventure_game dut (
        .clk(clk),
        .reset(reset), 
        .N(N), .S(S), .E(E), .W(W),
        .WIN(WIN),
        .DIE(DIE)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test vectors
    logic [3:0] vectors [0:15]; // N,S,E,W
    int i;
    
    initial begin
        $readmemb("testinputs.tv", vectors);
        
        // Initialize
        reset = 1;
        N = 0; S = 0; E = 0; W = 0;
        repeat(2) @(posedge clk);
        reset = 0;
        
        // Apply test vectors
        for (i = 0; i < 16; i++) begin
            if (vectors[i] === 4'b1111) begin
                // Reset between tests
                reset = 1;
                @(posedge clk);
                reset = 0;
                $display("=== New Test ===");
            end 
				else begin
                {N, S, E, W} = vectors[i];
                @(posedge clk);
                $display("Time %0t: N=%b S=%b E=%b W=%b WIN=%b DIE=%b", 
                         $time, N, S, E, W, WIN, DIE);
            end
            
            if (vectors[i] === 4'bxxxx) break; // End of file
        end
        $finish;
    end
endmodule