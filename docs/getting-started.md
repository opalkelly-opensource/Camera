## Camera Example Design
- [Overview](overview.md)
- **Getting Started**
- [Hardware](hardware.md)
- [Gateware](gateware.md)
- [Software (C++)](software-cpp.md)
- [Software (JS)](software-js.md)
- [Schematics and Drawings](schematics-and-drawings.md)
- [Release Notes](release-notes.md)

# okCameraApp (C++)

## Resources

- Source files are available on GitHub at [Camera](https://github.com/opalkelly-opensource/Camera/tree/archive/rtl).
- Pre-built application binaries are attached to the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub as `Camera-ExampleDesign-vX.Y.Z-Applications-Windows.zip` and `Camera-ExampleDesign-vX.Y.Z-Applications-Linux.tgz`.

## Windows Platforms

### Running the Pre-built Application

1. You require a compatible board and camera. You can see which products are compatible, and with which applications, in the support matrix located in the [release notes](release-notes.md).
2. Connect Camera to Board
   - If using the XEM7320, install the SZG-CAMERA on SYZYGY Port A.
   - If using the XEM8320, install the SZG-CAMERA or SZG-MIPI-8320 on SYZYGY Port A.
   - For all other boards and camera hardware, there is only one way to connect them — simply attach the board and camera together as instructed.
3. Install [FrontPanel SDK](https://docs.opalkelly.com/fpsdk/introduction/)
4. Obtain the following from [wxWidgets 3.2.0 release Github](https://github.com/wxWidgets/wxWidgets/releases/tag/v3.2.0):
   - `wxMSW-3.2.0_vc14x_ReleaseDLL.7z` (For x32)
   - `wxMSW-3.2.0_vc14x_x64_ReleaseDLL.7z` (For x64)
5. Unzip to a common location, i.e. `C:\wxWidgets-3.2.0`
6. Depending on your build target, add the following directories to the PATH environment variable:
   - For x64 (64-bit):
     - `C:\wxWidgets-3.2.0\lib\vc14x_x64_dll`
     - `C:\Program Files\Opal Kelly\FrontPanelUSB\API\lib\x64` *(Use the location of your FrontPanel SDK install directory)*
   - For x32 (32-bit):
     - `C:\wxWidgets-3.2.0\lib\vc14x_dll`
     - `C:\Program Files\Opal Kelly\FrontPanelUSB\API\lib\Win32` *(Use the location of your FrontPanel SDK install directory)*
7. Prepare the bitfiles (two possible methods):
   - Method 1 (executable directory):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory named `Bitfiles` at the same directory level as `okCameraApp.exe`.
     - Place all the downloaded bitfiles into this `Bitfiles` directory.
     - The application will automatically look for FPGA bitfiles in this location.
   - Method 2 (custom directory and environment variable):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory with any name you choose, and place it anywhere on your system.
     - Copy the pre-built bitfiles into this directory.
     - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
     - The application will then look for FPGA bitfiles in the location you specify.
8. Run the application.

### Building the C++ Source

1. Install [FrontPanel SDK](https://docs.opalkelly.com/fpsdk/introduction/)
2. Obtain the following from [wxWidgets 3.2.0 release Github](https://github.com/wxWidgets/wxWidgets/releases/tag/v3.2.0):
   - `wxWidgets-3.2.0-headers.7z`
   - `wxMSW-3.2.0_vc14x_Dev.7z` (For x32)
   - `wxMSW-3.2.0_vc14x_x64_Dev.7z` (For x64)
3. Unzip to a common location, i.e. `c:\wxWidgets-3.2.0`
4. Set `WXWIN` environment variable to `c:\wxWidgets-3.2.0`
5. set `okFP_SDK` environment variable to the location of the SDK’s `API` folder, i.e. `C:\Program Files\Opal Kelly\FrontPanelUSB\API`
6. Open `Software\Cxx\Camera.sln` file in Visual Studio and build it.
   - Building in `Release` configuration is recommended for best performance.
   - Building in `Debug` configuration is recommended for troubleshooting. See “Debug” section below.
7. When running from the Visual Studio output directory, you will need access to bitfiles. You can use the provided pre-built bitfiles from the GitHub release:
   - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
   - Create a directory with any name you choose, and place it anywhere on your system.
   - Copy the pre-built bitfiles into this directory.
   - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
   - The application will then look for FPGA bitfiles in the location you specify.

#### Note

`Camera.sln` uses Visual Studio 2022 toolset by default, but should also be usable with both older and newer versions. See the Visual Studio documentation and communities for additional information.

## Linux Platforms

### Install wxWidgets

The latest Camera Example Design includes pre-built applications that were built using Ubuntu 22.04 and wxWidgets 3.2. To install wxWidgets 3.2, execute the following sequence of commands:

1. `sudo apt install ca-certificates`
2. `sudo apt-key adv --fetch-keys https://repos.codelite.org/CodeLite.asc`
3. `sudo apt-add-repository 'deb https://repos.codelite.org/wx3.2.0/ubuntu/ jammy universe'`
4. `sudo apt update`
5. `sudo apt install libudev-dev libwxgtk3.2unofficial-dev`

### Running the Pre-built Application (Ubuntu 22.04)

1. You require a compatible board and camera. You can see which products are compatible, and with which applications, in the support matrix located in the [release notes](release-notes.md).
2. Connect Camera to Board
3. Install wxWidgets (see above)
4. Install [FrontPanel SDK](https://docs.opalkelly.com/fpsdk/introduction/)
5. Prepare the bitfiles (two possible methods):
   - Method 1 (executable directory):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory named `Bitfiles` at the same directory level as the `okCameraApp` application.
     - Place all the downloaded bitfiles into this `Bitfiles` directory.
     - The application will automatically look for FPGA bitfiles in this location.
   - Method 2 (custom directory and environment variable):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory with any name you choose, and place it anywhere on your system.
     - Copy the pre-built bitfiles into this directory.
     - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
     - The application will then look for FPGA bitfiles in the location you specify.
6. Run the application.

### Building the C++ Source

1. Install wxWidgets (see above).
2. Install [FrontPanel SDK](https://docs.opalkelly.com/fpsdk/introduction/)
3. Run the provided makefile.
   - `cd Software/Cxx`
   - `make`
   - `DEBUG=1` on make command line is recommended for troubleshooting. See “Debug” section below.
4. When running from the build output directory, you will need access to bitfiles. You can use the provided pre-built bitfiles from the GitHub release:
   - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
   - Create a directory with any name you choose, and place it anywhere on your system.
   - Copy the pre-built bitfiles into this directory.
   - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
   - The application will then look for FPGA bitfiles in the location you specify.

## Debug

When building okCameraApp for debugging, the program needs to find the `resource.xrc` file during execution. If it is not found in the default location, `okCAMERA_RESOURCES_DIR` environment variable can be used to specify its directory, e.g.

    `okCAMERA_RESOURCES_DIR=`pwd`/okCameraApp ./bin/okCameraApp`

Note that in release/production builds, the resource file is embedded directly into the application executable (or application bundle under macOS) and this environment variable is not used.

# Building the Gateware

All 7-Series and UltraScale devices provide a TCL script build method to generate the required IPs and import the required source files for the Vivado project mode work flow. These brief instructions presume you already have familiarity with the [FrontPanel SDK](https://docs.opalkelly.com/fpsdk/introduction/) and Vivado.

1. Open Vivado GUI and use the TCL console to `cd` to the gateware folder for your target integration configuration: `cd <Camera Example Design Installation Directory>/Gateware/Boards/XEM8320/SZG-Camera`
2. Run the provide TCL script. If the product is offered in multiple device densities then use the TCL script with the correct suffix that applies for your product:`source project.tcl`
3. Import FrontPanel HDL for your product into the project. These sources are located within the FrontPanel SDK installation. Files are located at the following:`<FrontPanel SDK Installation Directory>/FrontPanelHDL/XEM8320-AU25P/Vivado-2021` (e.g. `C:\Program Files\Opal Kelly\FrontPanelUSB\FrontPanelHDL\XEM8320-AU25P\Vivado-2021`)
4. Generate Bitstream.
