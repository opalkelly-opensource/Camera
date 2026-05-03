## Camera Example Design
- [Overview](overview.md)
- [Getting Started](getting-started.md)
- [Hardware](hardware.md)
- [Gateware](gateware.md)
- [Software (C++)](software-cpp.md)
- [Software (JS)](software-js.md)
- [Schematics and Drawings](schematics-and-drawings.md)
- **Release Notes**

Our releases for the Camera Example Design are located on GitHub at:
[opalkelly-opensource/Camera Releases](https://github.com/opalkelly-opensource/Camera/releases?q=rtl)

# Camera Example Design 2.4.0

## Supported platforms

- Windows 7, 8, 10, 11 (x32 / x64)
- Mac OS X, 10.10 or later
- Linux (Ubuntu 22.04 LTS x64)

## Supported hardware

The following table shows the image capture module and FPGA module pairings we currently provide HDL sources for. This table also shows the software support available for that pairing:

| Product | Camera Hardware | okCameraApp | okSnapApp | CameraApp-JS |
|---------|----------------|-------------|-----------|---------------|
| XEM6010 | EVB1005 | ✓ | ✓ | ✓ |
| XEM6310 | EVB1005 | ✓ | ✓ | ✓ |
| XEM7010 | EVB1005 | ✓ | ✓ | ✓ |
| XEM7310 | EVB1005 | ✓ | ✓ | ✓ |
| XEM6006 | EVB1006 | ✓ | ✓ | ✓ |
| XEM7350 | EVB1006 | ✓ | ✓ | ✓ |
| ZEM4310 | EVB1007 | ✓ | ✓ | ✓ |
| XEM7320 | SZG-CAMERA | ✓ | No | ✓ |
| XEM8320 | SZG-CAMERA | ✓ | No | No |
| XEM8320 | SZG-CAMERA (3 Camera) | ✓ | No | No |
| XEM8320 | SZG-MIPI-8320 | ✓ | No | No |
| XEM8320 | SZG-MIPI-8320 (3 Camera) | ✓ | No | No |

HDL sources have been built with Xilinx ISE 14.7 (XEM6xxx), Xilinx Vivado 2021.1.1 (XEM8xxx, XEM7xxx), and Quartus Prime 18.1 (ZEMxxxx), unless otherwise stated below.

## Release Notes

- Rename design
- Move release and sources to Github
- Update okCameraApp and okSnapApp Visual Studio project files to use PlatformToolset v143
- Windows pre-built binaries use wxWidgets-3.2.0 official binaries
- Linux pre-built binaries use the libwxgtk3.2unofficial-dev package
- Pre-built binaries use FrontPanel SDK V5.2.11

# Previous Versions

## Camera Reference Design 2.3.1

- Windows pre-built binaries use wxWidgets-3.2.0 official binaries
- Linux pre-built binaries use the libwxgtk3.2unofficial-dev package
- Pre-built binaries use FrontPanel SDK V5.2.11
- Update XEM8320-AU25P DDR4 speed to DDR4-2400 (See Xilinx DS931 for more information)
- XEM8320 with 3 SZG-MIPI-8320 camera design gets additional floor planning constraints to resolve routing
- Add note in source about MIPI CSI-2 Rx Subsystem Version 5.1 (Rev. 5) active_lanes port addition

## Camera Reference Design 2.3.0

- Add support for the XEM8320 with the following peripherals to the desktop okCameraApp application:
  - Single Camera SZG-MIPI-8320
  - Three Camera SZG-MIPI-8320
  - Three Camera SZG-CAMERA
- Update all 7-series device configurations with the TCL script build method. Sensor extclk removed from MIG, now generated in clocks module

## Camera Reference Design 2.2.1

- Add `Common.vcxproj` and `Common.vcxproj.filters` Visual Studio project files to Windows release

## Camera Reference Design 2.2.0

- Add support for the XEM8320 with the SZG-CAMERA peripheral to the desktop okCameraApp application
- Add in use of the Opal Kelly I2C controller API located at [GitHub](https://github.com/opalkelly-opensource/design-resources/tree/main/HDLComponents/I2CController)
- Windows pre-built binaries use wxWidgets-3.1.5
- Linux pre-built binaries use the `libwxgtk3.0-gtk3-dev` package
- Pre-built binaries use FrontPanel SDK V5.2.5

## Camera Reference Design 2.1.0

- Add support for the XEM7320 with the SZG-CAMERA peripheral
- Store CameraApp application settings locally
- Add a GUI menu to connect to an FPoIP server
- Additional bug fixes and improvements

## Camera Reference Design 2.0.0

- Add support for FPoIP, enabling connections to devices over TCP/IP
- Add a new WebApp based on the FPoIP WebAPI
- Implement a circular buffering scheme in HDL, maximizing memory use and allowing for significantly more frame buffers.
- Add support for the XEM7310
- Add support for High DPI displays
- Update look and feel of the camera application
- Add bitmap image support to okSnap application
- Assorted minor improvements
- Bugfixes and usability improvements
