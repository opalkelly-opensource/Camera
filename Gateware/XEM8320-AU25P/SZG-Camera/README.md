The HLS IP cores must be generated before the bitstream.


To generate the HLS IP cores:

1. Open a shell with the HLS tools on the PATH by sourcing the
   install's settings64 script:

      Vitis Unified (Vivado/Vitis 2023.2 or later):
         Linux:    source <Xilinx install>/Vitis/<version>/settings64.sh
         Windows:  <Xilinx install>\Vitis\<version>\settings64.bat

      Vitis HLS (Vivado/Vitis prior to 2023.2):
         Linux:    source <Xilinx install>/Vitis_HLS/<version>/settings64.sh
         Windows:  <Xilinx install>\Vitis_HLS\<version>\settings64.bat

2. From within each HLS subfolder (HLS/ISP and HLS/histogram), run
   the HLS command for your installed tool version:

      Vitis Unified (Vivado/Vitis 2023.2 or later):
         vitis-run --mode hls --tcl run_hls.tcl

      Vitis HLS (Vivado/Vitis prior to 2023.2):
         vitis_hls run_hls.tcl


Once the HLS IP cores are generated, generate the bitstream:

1. Set the `fpdir` variable to point to your FrontPanel Vivado IP Core
   distribution directory.

   From the Vivado TCL console:
      set fpdir <path_to_FrontPanel_Vivado_IP_Core>

2. Change directory to this project folder:
      cd <path to this directory>

3. Source the project creation script:
      source project.tcl

4. Generate the bitstream.


Copyright (c) 2025 Opal Kelly Incorporated
