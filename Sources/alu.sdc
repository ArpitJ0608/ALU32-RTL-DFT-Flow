create_clock -name clk -period 10

set_input_delay 0 -clock clk [get_ports {a b sel}]

set_output_delay 0 -clock clk [get_ports {carry_out out}]

set_input_transition 0.1 [get_ports {a b sel}]

set_load 0.05 [get_ports {carry_out out}]
set_false_path -from [get_ports rst]
