#########################################################################################
# CLOCK:
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk_i} ];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_i}];
#########################################################################################
# RESET:
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {rst_i} ];
#########################################################################################
# RS232:
set_property -dict { PACKAGE_PIN C4 IOSTANDARD LVCMOS33 } [get_ports {RXD_i} ];
set_property -dict { PACKAGE_PIN D4 IOSTANDARD LVCMOS33 } [get_ports {TXD_o} ];
#########################################################################################
# DEBUG SIGNALS:
 #set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[0] }];
#set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[1] }];
#set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[2] }];
#set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[3] }];
#set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[4] }];
#set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[5] }];
#set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[6] }];
#set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { tx_dbg_o[7] }];
#set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[0] }];
#set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[1] }];
#set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[2] }];
#set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[3] }];
#set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[4] }];
#set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[5] }];
#set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[6] }];
#set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [get_ports { rx_dbg_o[7] }];
#########################################################################################