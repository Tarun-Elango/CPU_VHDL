set_property CLOCK_DEDICATED_ROUTE FALSE [ get_nets clk ]
set_property -dict { PACKAGE_PIN V10 IOSTANDARD LVCMOS33 } [ get_ports { resetMain }];
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [ get_ports { clk }];

set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [ get_ports { rs_out[0] }];
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [ get_ports { rs_out[1] }];
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [ get_ports { rs_out[2] }];
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [ get_ports { rs_out[3] }];

set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [ get_ports { rt_out[0] }];
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [ get_ports { rt_out[1] }];
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [ get_ports { rt_out[2] }];
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [ get_ports { rt_out[3] }];

set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [ get_ports { pc_out[0] }];
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [ get_ports { pc_out[1] }];
set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [ get_ports { pc_out[2] }];
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [ get_ports { pc_out[3] }];

set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [ get_ports { overflowMain }];
set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [ get_ports { zeroMain }];


