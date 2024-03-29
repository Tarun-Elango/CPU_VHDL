add wave resetMain
add wave clk
add wave -radix unsigned pc_out
add wave -radix unsigned rs_out
add wave -radix unsigned rt_out
add wave -radix signed insts

force resetMain 1
force clk 0
run 2
force resetMain 0
run 2

force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2
force clk 1
run 2
force clk 0
run 2

