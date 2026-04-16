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

1. Locate the Bandwidth Mode "BWMode3" folder for your product in the
   FrontPanel SDK:

      <FrontPanel SDK>/FrontPanelHDL/<product_name>/BWMode3

   Copy it into the FrontPanel directory. The result should
   look like:

      ./FrontPanel/BWMode3/

2. From the Vivado TCL console, change to this project directory:
      cd <path to this directory>

3. Run the project script:
      source project.tcl

4. Generate the bitstream.


Copyright (c) 2026 Opal Kelly Incorporated
