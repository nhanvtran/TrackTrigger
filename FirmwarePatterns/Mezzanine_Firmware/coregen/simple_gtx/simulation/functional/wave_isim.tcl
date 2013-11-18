###############################################################################
##
## (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
## 
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.



wcfg new
wave add /simple_gtx_TB/simple_gtx_exdes_i/gt0_frame_check/begin_r
wave add /simple_gtx_TB/simple_gtx_exdes_i/gt0_frame_check/track_data_r
wave add /simple_gtx_TB/simple_gtx_exdes_i/gt0_frame_check/data_error_detected_r
wave add /simple_gtx_TB/simple_gtx_exdes_i/gt0_frame_check/start_of_packet_detected_r
wave add /simple_gtx_TB/simple_gtx_exdes_i/gt0_frame_check/RX_DATA_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/gt0_frame_check/ERROR_COUNT_OUT
divider add "CPLL Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/CPLLFBCLKLOST_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/CPLLLOCK_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/CPLLLOCKDETCLK_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/CPLLREFCLKLOST_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/CPLLRESET_IN
divider add "Channel - Clocking Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/GTREFCLK0_IN
divider add "Channel - DRP Ports "
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/DRPADDR_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/DRPCLK_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/DRPDI_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/DRPDO_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/DRPEN_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/DRPRDY_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/DRPWE_IN
divider add "Clocking Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/QPLLCLK_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/QPLLREFCLK_IN
divider add "RX Initialization and Reset Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXUSERRDY_IN
divider add "RX Margin Analysis Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/EYESCANDATAERROR_OUT
divider add "Receive Ports - CDR Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXCDRLOCK_OUT
divider add "Receive Ports - FPGA RX Interface Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXUSRCLK_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXUSRCLK2_IN
divider add "Receive Ports - FPGA RX interface Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXDATA_OUT
divider add "Receive Ports - RX 8B/10B Decoder Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXDISPERR_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXNOTINTABLE_OUT
divider add "Receive Ports - RX AFE"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/GTXRXP_IN
divider add "Receive Ports - RX AFE Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/GTXRXN_IN
divider add "Receive Ports - RX Buffer Bypass Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXBUFSTATUS_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXDLYEN_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXDLYSRESET_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXDLYSRESETDONE_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXPHALIGN_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXPHALIGNDONE_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXPHALIGNEN_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXPHDLYRESET_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXPHMONITOR_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXPHSLIPMONITOR_OUT
divider add "Receive Ports - RX Equalizer Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXDFEAGCHOLD_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXDFELPMRESET_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXMONITOROUT_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXMONITORSEL_IN
divider add "Receive Ports - RX Fabric Output Control Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXOUTCLK_OUT
divider add "Receive Ports - RX Initialization and Reset Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/GTRXRESET_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXPMARESET_IN
divider add "Receive Ports - RX8B/10B Decoder Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXCHARISK_OUT
divider add "Receive Ports -RX Initialization and Reset Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/RXRESETDONE_OUT
divider add "TX Initialization and Reset Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/GTTXRESET_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXUSERRDY_IN
divider add "Transmit Ports - FPGA TX Interface Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXUSRCLK_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXUSRCLK2_IN
divider add "Transmit Ports - TX Buffer Bypass Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXDLYEN_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXDLYSRESET_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXDLYSRESETDONE_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXPHALIGN_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXPHALIGNDONE_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXPHALIGNEN_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXPHDLYRESET_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXPHINIT_IN
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXPHINITDONE_OUT
divider add "Transmit Ports - TX Buffer Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXBUFSTATUS_OUT
divider add "Transmit Ports - TX Data Path interface"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXDATA_IN
divider add "Transmit Ports - TX Driver and OOB signaling"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/GTXTXN_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/GTXTXP_OUT
divider add "Transmit Ports - TX Fabric Clock Output Control Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXOUTCLK_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXOUTCLKFABRIC_OUT
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXOUTCLKPCS_OUT
divider add "Transmit Ports - TX Gearbox Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXCHARISK_IN
divider add "Transmit Ports - TX Initialization and Reset Ports"
wave add /simple_gtx_TB/simple_gtx_exdes_i/simple_gtx_init_i/simple_gtx_i/gt0_simple_gtx_i/TXRESETDONE_OUT

run 639 us
quit



