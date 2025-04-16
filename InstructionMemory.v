module InstructionMemory(input clock,
		input clear,
		input[31:0] address,
		output [31:0] instr);

	reg[31:0] content[255:0];
	integer i;
	
	always @(posedge clear, negedge clock)
		if (clear) begin

			// Reset content
			for (i = 0; i < 256; i = i + 1)
				content[i] = 0;

			// Initial values
			// content[0] = 32'h00221820;	// add $3, $1, $2  <- label 'main'
			// content[1] = 32'h00221822;	// sub $3, $1, $2
			// content[2] = 32'h00221824;	// and $3, $1, $2
			// content[3] = 32'h00221825;	// or $3, $1, $2
			// content[4] = 32'h0022182a;	// slt $3, $1, $2
			// content[5] = 32'h0041182a;	// slt $3, $2, $1
			// content[6] = 32'h1140fff9;	// beq $10, $0, main
			// content[7] = 32'h8d430000;	// lw $3, 0($10)
			// content[8] = 32'h8d430004;	// lw $3, 4($10)
			// content[9] = 32'had430008;	// sw $3, 8($10)
			// content[10] = 32'h1000fff5;	// beq $0, $0, main
			content[0] = 32'h30100001;
			content[1] = 32'h36108000;	
			content[2] = 32'h3210FFFF;


            //ok i can't tell if we're supposed to overwrite the current code
            //or???
            //
            //if we just need to overwrite we can do
            //content[0] = whatever the hex for (andi $s0, $zero, 0x1) is
            //do the same for the other 2 instructions           
		end

	// Read instruction
	assign instr = address >= 32'h400000 && address < 32'h4000400 ?
			content[(address - 32'h400000) >> 2] : 0;

	// Display current instruction
	always @(instr)
		$display("Fetch at PC %08x: instruction %08x", address, instr);
	
endmodule

