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
2. Download the application. Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub, download `Camera-ExampleDesign-vX.Y.Z-Applications-Windows.zip`, and extract it. It contains `okCameraApp`, `okSnapApp` and `camera.lua`. Keep `camera.lua` beside the executables; it is loaded when the application opens a **remote** device over FrontPanel-over-IP, and is not needed for a locally attached board.
3. Connect Camera to Board
   - If using the XEM7320, install the SZG-CAMERA on SYZYGY Port A.
   - If using the XEM8320, install the SZG-CAMERA or SZG-MIPI-8320 on SYZYGY Port A.
   - For all other boards and camera hardware, there is only one way to connect them: simply attach the board and camera together as instructed.
4. Install [FrontPanel Platform](https://pins.opalkelly.com/downloads) for the USB driver, then open it and export the **FrontPanel SDK**, which contains the runtime library. Extract the SDK somewhere convenient (for 6.1.0 it extracts as `FrontPanel-DevKit-6.1.0`). The SDK is platform-specific, so export the Windows one.
5. Obtain the following from [wxWidgets 3.2.0 release Github](https://github.com/wxWidgets/wxWidgets/releases/tag/v3.2.0):
   - `wxMSW-3.2.0_vc14x_x64_ReleaseDLL.7z`
6. Unzip to a common location, i.e. `C:\wxWidgets-3.2.0`. These are `.7z` archives, which Windows Explorer and `Expand-Archive` cannot open; use [7-Zip](https://www.7-zip.org/) or another tool that supports the format.
7. Add the following directories to the PATH environment variable:
   - `C:\wxWidgets-3.2.0\lib\vc14x_x64_dll`
   - the extracted FrontPanel SDK’s `API` folder, e.g. `C:\path\to\FrontPanel-DevKit-6.1.0\API` *(this is where `okFrontPanel.dll` lives)*

   > Installing FrontPanel Platform alone is not enough: from 6.1.0 the runtime library ships in the SDK, which you export from inside FrontPanel Platform, and installing Platform does not unpack it, so no `API` directory is created under `C:\Program Files\Opal Kelly\FrontPanel-Platform`. Alternatively, copy `okFrontPanel.dll` next to the executables instead of adding the SDK's `API` folder to `PATH`. The wxWidgets entry is still required for `okCameraApp`, which also loads `wxbase32u_vc14x_x64.dll`, `wxmsw32u_core_vc14x_x64.dll`, `wxmsw32u_xrc_vc14x_x64.dll` and `wxmsw32u_gl_vc14x_x64.dll`. `okSnapApp` needs only `okFrontPanel.dll`.
8. Prepare the bitfiles (two possible methods):
   - Method 1 (executable directory):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory named `Bitfiles` inside the folder holding the executables. The shipped files are named `okCameraApp-x64.exe` and `okSnapApp-x64.exe`.
     - Place all the downloaded bitfiles into this `Bitfiles` directory.
     - The application will automatically look for FPGA bitfiles in this location.
   - Method 2 (custom directory and environment variable):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory with any name you choose, and place it anywhere on your system.
     - Copy the pre-built bitfiles into this directory.
     - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
     - The application will then look for FPGA bitfiles in the location you specify.
9. Run `okCameraApp-x64.exe`.

The archive also contains `okSnapApp`, a command-line tool that captures a single frame to a
file: `okSnapApp-x64.exe [-m test_mode] [-d directory] [-f raw|bmp] outfile`. It does not use
either bitfile method above; pass its bitfile directory with `-d`.

### Building the C++ Source

1. Install [FrontPanel Platform](https://pins.opalkelly.com/downloads) and export the **FrontPanel SDK** from inside it
2. Obtain the following from [wxWidgets 3.2.0 release Github](https://github.com/wxWidgets/wxWidgets/releases/tag/v3.2.0):
   - `wxWidgets-3.2.0-headers.7z`
   - `wxMSW-3.2.0_vc14x_x64_Dev.7z`
3. Unzip to a common location, i.e. `c:\wxWidgets-3.2.0`. These are `.7z` archives; use [7-Zip](https://www.7-zip.org/) or similar.
4. Set `WXWIN` environment variable to `c:\wxWidgets-3.2.0`. If `WXWIN` is already set to something else it takes precedence and the build fails part-way: `Common` and `okSnapApp` link, and only `okCameraApp` fails. Check the existing value before setting it.
5. set `okFP_SDK` environment variable to the extracted FrontPanel SDK’s `API` folder, i.e. `C:\path\to\FrontPanel-DevKit-6.1.0\API`
6. Check where you unpacked the source before building. The resource build step passes the
   project path to `wxrc` unquoted, so **a path containing a space fails**, and a deeply nested
   path can exceed the Windows path limit and fail too. Somewhere short like `C:\Camera` is safe;
   `My Projects`, or a OneDrive-redirected `Documents`, is not.
7. Open `Software\Cxx\Camera.sln` file in Visual Studio and build it.
   - Building in `Release` configuration is recommended for best performance.
   - Building in `Debug` configuration is recommended for troubleshooting. See “Debug” section below.
8. When running from the Visual Studio output directory, you will need access to bitfiles. You can use the provided pre-built bitfiles from the GitHub release:
   - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
   - Create a directory with any name you choose, and place it anywhere on your system.
   - Copy the pre-built bitfiles into this directory.
   - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
   - The application will then look for FPGA bitfiles in the location you specify.

9. Copy `Software\Common\camera.lua` beside the built executables. The build does not place it
   there, and it is needed for FrontPanel-over-IP.
10. Before running what you built, put the wxWidgets DLL directory on your `PATH`, for
   example `c:\wxWidgets-3.2.0\lib\vc14x_x64_dll`. The build stages the FrontPanel DLLs
   beside the executable for you, but not the wxWidgets ones, so `okCameraApp` builds
   successfully and then fails to start without them. `okSnapApp` is unaffected; it does not
   use wxWidgets.

#### Troubleshooting a build where only `okCameraApp` fails

`Common` and `okSnapApp` building while `okCameraApp` alone fails has two common causes, and
they look alike. Check the source path first, since it is quicker to rule out:

- The source path contains a space, or is too deeply nested (step 6). The error names
  `resource.xrc` or `resource_xrc.cpp`.
- `WXWIN` points somewhere unexpected (step 4). The error names `WXWIN` and the directory.

#### Note

`Camera.sln` uses Visual Studio 2022 toolset by default, but should also be usable with both older and newer versions. See the Visual Studio documentation and communities for additional information.

## Linux Platforms

### Install wxWidgets

The latest Camera Example Design includes pre-built applications that were built using Ubuntu 22.04 and wxWidgets 3.2. To install wxWidgets 3.2, execute the following sequence of commands:

1. `sudo apt install ca-certificates software-properties-common`
2. `sudo curl -fsSL https://repos.codelite.org/CodeLite.asc -o /etc/apt/trusted.gpg.d/codelite.asc`
3. `sudo apt-add-repository -y 'deb https://repos.codelite.org/wx3.2.0/ubuntu/ jammy universe'`
4. `sudo apt update`
5. `sudo apt install libwxgtk3.2unofficial-dev`

Step 2 places the repository key in `/etc/apt/trusted.gpg.d/` rather than using `apt-key`,
which is deprecated and makes every subsequent `apt update` emit a warning.

### Running the Pre-built Application (Ubuntu 22.04)

1. You require a compatible board and camera. You can see which products are compatible, and with which applications, in the support matrix located in the [release notes](release-notes.md).
2. Download the application. Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub, download `Camera-ExampleDesign-vX.Y.Z-Applications-Linux.tgz`, and extract it. It contains `okCameraApp`, `okSnapApp` and `camera.lua`. Keep `camera.lua` beside the executables; it is loaded when the application opens a **remote** device over FrontPanel-over-IP, and is not needed for a locally attached board.
3. Connect Camera to Board
   - If using the XEM7320, install the SZG-CAMERA on SYZYGY Port A.
   - If using the XEM8320, install the SZG-CAMERA or SZG-MIPI-8320 on SYZYGY Port A.
   - For all other boards and camera hardware, attach the board and camera together as instructed.
4. Install wxWidgets (see above)
5. Install [FrontPanel Platform](https://pins.opalkelly.com/downloads) for the USB driver, then export and extract the **FrontPanel SDK** from inside it. Make its `API` folder available to the applications: either add it to `LD_LIBRARY_PATH`, or copy `libokFrontPanel.so.2` next to the executables. Neither `okCameraApp` nor `okSnapApp` starts without it. `libokFrontPanel.so.2` is the name recorded in the executables and the only one needed to run; `libokFrontPanel.so` is the linker name and is needed only when building from source.

   > **Take the FrontPanel Platform that matches your distribution.** The SDK export inherits it, the Ubuntu 22.04 and 24.04 builds are not interchangeable, and the generic "Ubuntu" download is the 24.04 one. These applications are built for Ubuntu 22.04; the 24.04 library needs `GLIBC_2.38`, which 22.04 does not provide, so it fails to load.

   > Installing FrontPanel Platform alone is not enough: from 6.1.0 the runtime library ships in the SDK, which you export from inside FrontPanel Platform, and installing Platform does not unpack it. Under FrontPanel 5 the Linux installer placed the library on the system library path for you, so an upgrade from 2.4.0 had nothing to do here.
6. Prepare the bitfiles (two possible methods):
   - Method 1 (executable directory):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory named `Bitfiles` inside the folder holding the `okCameraApp` executable.
     - Place all the downloaded bitfiles into this `Bitfiles` directory.
     - The application will automatically look for FPGA bitfiles in this location.
   - Method 2 (custom directory and environment variable):
     - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
     - Create a directory with any name you choose, and place it anywhere on your system.
     - Copy the pre-built bitfiles into this directory.
     - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
     - The application will then look for FPGA bitfiles in the location you specify.
7. Run `./okCameraApp`. The archive also contains `okSnapApp`, a command-line single-frame capture tool; it does not use either bitfile method above. Pass its bitfile directory with `-d`.

### Building the C++ Source

1. Install the build toolchain and wxWidgets:
   - `sudo apt install build-essential`
   - then wxWidgets, as described above. A stock Ubuntu image ships no C++ compiler.
2. Install [FrontPanel Platform](https://pins.opalkelly.com/downloads) and export the **FrontPanel SDK** from inside it.
   - **Match the FrontPanel Platform to your distribution.** The SDK export inherits it,
     and the Ubuntu 22.04 and 24.04 builds are not interchangeable: the 24.04 library needs
     `GLIBC_2.38`, which 22.04 does not have, and linking against the wrong one fails with
     `undefined reference to ...@GLIBC_2.38`. This line targets Ubuntu 22.04.
3. Run the provided makefile, pointing it at the extracted SDK.
   - `cd Software/Cxx`
   - `make okFP_SDK_INC=/path/to/FrontPanel-DevKit-6.1.0/API okFP_SDK_LIB=/path/to/FrontPanel-DevKit-6.1.0/API`
   - Both variables are required, and they fail differently. Without `okFP_SDK_INC` the
     compile fails at `fatal error: okFrontPanelDLL.h: No such file or directory`. With
     `okFP_SDK_INC` set but `okFP_SDK_LIB` missing, the compile succeeds and the **link**
     fails at `/usr/bin/ld: cannot find -lokFrontPanel`.
   - This builds both applications, `okCameraApp` and `okSnapApp`, into `Software/Cxx/bin/`.
   - Copy `Software/Common/camera.lua` into `bin/` as well; the makefile does not place it there.
     It is loaded when the application opens a **remote** device over FrontPanel-over-IP.
   - `DEBUG=1` on make command line is recommended for troubleshooting. See “Debug” section below.
   - Before running what you built, make the FrontPanel runtime library available, or neither
     application starts: `error while loading shared libraries: libokFrontPanel.so.2`. Either
     copy `libokFrontPanel.so.2` from the SDK's `API` folder into `bin/`, which works because
     the binaries carry an `$ORIGIN` RPATH, or add that `API` folder to `LD_LIBRARY_PATH`.
4. When running from the build output directory, you will need access to bitfiles. You can use the provided pre-built bitfiles from the GitHub release:
   - Locate the [RTL Camera Example Design vX.Y.Z release (`rtl-vX.Y.Z`)](https://github.com/opalkelly-opensource/Camera/releases?q=rtl) on GitHub and download `Camera-ExampleDesign-vX.Y.Z-Bitfiles.zip` (Windows) or `Camera-ExampleDesign-vX.Y.Z-Bitfiles.tgz` (Linux), then extract its contents.
   - Create a directory with any name you choose, and place it anywhere on your system.
   - Copy the pre-built bitfiles into this directory.
   - Set the environment variable `okCAMERA_BITFILES_DIR` to point to this directory.
   - The application will then look for FPGA bitfiles in the location you specify.

## Debug

When building okCameraApp for debugging, the program needs to find the `resource.xrc` file during execution. Release builds embed it in the executable; Debug builds do not, so a Debug build that cannot find it fails at startup. If it is not found in the default location, the `okCAMERA_RESOURCES_DIR` environment variable can be used to specify its directory:

    `okCAMERA_RESOURCES_DIR=`pwd`/okCameraApp ./bin/okCameraApp`

On Windows the default location is the directory holding the executable, so copy `resource.xrc` from `Software\Cxx\okCameraApp\` next to the Debug build, or set the variable:

    set okCAMERA_RESOURCES_DIR=C:\path\to\Software\Cxx\okCameraApp

Note that in release/production builds the resource file is embedded directly into the application executable and this environment variable is not used.

# Building the Gateware

All 7-Series and UltraScale devices provide a TCL script build method to generate the required IPs and import the required source files for the Vivado project mode work flow. These brief instructions presume you already have familiarity with the [FrontPanel SDK](https://docs.opalkelly.com/fpsdk/introduction/) and Vivado.

1. Open Vivado GUI and use the TCL console to `cd` to the gateware folder for your target integration configuration: `cd <Camera Example Design Installation Directory>/Gateware/Boards/XEM8320/SZG-Camera`
2. Run the provide TCL script. If the product is offered in multiple device densities then use the TCL script with the correct suffix that applies for your product:`source project.tcl`
3. Import FrontPanel HDL for your product into the project. These sources are located within the extracted FrontPanel SDK. Files are located at the following: `C:\path\to\FrontPanel-DevKit-6.1.0\FrontPanelHDL\XEM8320-AU25P\Vivado-2021`
4. Generate Bitstream.
