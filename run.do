# compilation
    vlog dff_mux_tb.v -l comp.log
# elaboration
  vsim -voptargs=+acc dff_tb  
# addwave
  add wave sim:/dff_tb/dut/*
# run
  run -all
