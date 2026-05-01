
puts "Fault Chain"
exec fault chain --skip-synth --liberty /home/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib --clock clk --reset rst -s scan_config.yaml --output alu_scanned.v alu_netlist.v >@ stdout

puts "Scan ff"
exec python3 replace_scan_ff.py

puts "Fault cut"
exec fault cut --dff dfcrq1,sdnrq1 --clock clk --reset rst --output comb.v alu_netlist.v >@ stdout


puts "Fault ATPG"
exec fault atpg --cell-model /home/coe-10/Desktop/Technology_PDKs/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/verilog/vcs_sim_model/tsl18fs120_scl.v --clock clk --reset rst -m 90.0 -v 500 --output test_vector.json comb.v >@ stdout

puts "Fault ASM - Assembling test vectors..."
exec fault asm \
    --output        alu_test_vectors.bin \
    --golden-output alu_golden_output.bin \
    test_vector.json \
    alu_scanned_final.v >@ stdout

puts "Done!"
puts "Generated files:"
