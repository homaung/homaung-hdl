module single_port_ram
(
	input [2:0] data,
	input [7:0] addr,
	input we, clk,
	output [2:0] q
);

	// Declare the RAM variable
	reg [2:0] ram[7:0];
	
	// Variable to hold the registered read address
	reg [7:0] addr_reg;
	
	always @ (posedge clk)
	begin
	// Write
		if (we)
			ram[addr] <= data;
    		addr_reg <= addr;
		
	end
		
	assign q = ram[addr_reg];
	
endmodule 