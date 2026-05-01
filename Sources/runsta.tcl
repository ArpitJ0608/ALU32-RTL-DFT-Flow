read_liberty /home/coe-10/Desktop/Technology_PDKs/osu018/osu018_stdcells.lib
read_verilog alu_netlist.v 
link_design ALU_32

read_sdc alu.sdc
report_checks -path_delay max
report_checks -path_delay min 
report_worst_slack
report_tns

write_sdf delay_sdf.sdf
