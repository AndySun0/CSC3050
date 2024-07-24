# just type ----> make test

test:
	make compile
	vvp ALU

compile: alu.v test_alu.v
	iverilog -o ALU test_alu.v
