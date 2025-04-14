//not needed anymore
module SignExtend(input[15:0] in,
		output[31:0] out);

	assign out = {{16{in[15]}}, in};

endmodule

//new!!
module ImmExtend(
    input [15:0] in,
    input ImmExtend,  // 0 = sign extend, 1 = zero extend
    output [31:0] out);
    assign out = ImmExtend ? {16'b0, in} : {{16{in[15]}}, in};
endmodule
