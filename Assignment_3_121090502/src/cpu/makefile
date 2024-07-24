# note :before test you should copy the machine_code into the file"CPU_instruction.bin"
#then just type in -----> make test!!
test:
	make compile
	vvp CPU

compile: cpu.v test_cpu.v
	iverilog -o CPU test_cpu.v
