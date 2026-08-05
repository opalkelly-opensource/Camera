## Camera Example Design
- [Overview](overview.md)
- [Getting Started](getting-started.md)
- [Hardware](hardware.md)
- [Gateware](gateware.md)
- **Software (C++)**
- [Software (JS)](software-js.md)
- [Schematics and Drawings](schematics-and-drawings.md)
- [Release Notes](release-notes.md)

# okCCamera C++ Class

We have wrapped the basic functionality of the camera into a lightweight C++ class which should serves as the only interface to the device.  The `okCCamera` object should handle all communication with the device via the FrontPanel API.  Both the `okSnapApp` command-line application and the `okCameraApp` GUI application make use of this common class to communicate with the camera.

## Image Capture Processor Initialization

Initializing the camera for operation involves the following sequence:

1. Open a device using `OpalKelly::FrontPanelDevices`
2. Configure the FPGA with the appropriate bitfile
3. Configure the on-board PLL (for boards that support it)
4. Initialize the image sensor
5. Perform logic reset

 These five steps are performed by the `Initialize()` method.  Until this method is called successfully, the camera remains in an uninitialized state and cannot be used.

## Image Capture and Data Transfer

A single image capture cycle is initiated and read using either the `SingleCapture()` method or the `BufferedCapture()` method.  These methods performs the following sequence:

1. Waits for an available frame indicated by a WireOut
2. Trigger a readout start
3. Read the complete image data
4. Trigger readout done

## Image Buffering

Multiple frames are buffered in hardware at a time to help smooth over potential communication interruptions. The hardware constantly captures images at the maximum sensor frame rate for the set resolution and writes them to memory, providing the oldest image in memory for readout by the software. The total number of available buffers in memory can be queried using the `GetBufferedImageCount()` method.

When operating over a low bandwidth connection the hardware can build up multiple seconds worth of images in memory. This results in images returned to the software that are relatively old. To alleviate this, the total number of buffers available to the hardware can be adjusted using the `SetImageBufferDepth()` method. This function will configure the image capture processor to only allocate buffers up to the set value or the maximum number of buffers that are supported by the current devices memory. The maximum number of buffers that are supported by a devices memory can be queried with the `GetMaxDepthForResolution()` method. Increasing the resolution of captured images will decrease the maximum number of buffers available to the hardware. If a new resolution change requires a reduction in buffer depth, the buffer depth will be adjusted accordingly. Setting the depth to the `IMAGE_BUFFER_DEPTH_AUTO` constant will force the hardware to always use the maximum number of buffers available for a given resolution.

# Use of FPoIP

The V2 host software makes extensive use of FPoIP features, giving applications built on the okCCamera C++ Class the ability to access devices over TCP/IP connections. The use of these features is made possible through use of the `OpalKelly::FrontPanelDevices` class for managing device connections, both local and remote. FPoIP Server Side Scripting is used to significantly increase performance over high latency connections. To allow for both native and FPoIP use, the okCCamera C++ class is split into two implementations, a native, local-device-only C++ implementation and a second implementation used with remote devices that makes use of FPoIP Server Side Scripting. The server side script code can be found in the provided `camera.lua` script. Please refer to the [FrontPanel over IP](https://docs.opalkelly.com/fpsdk/frontpanel-over-ip/) documentation for more information on these features.

Connection to an FPoIP server is handled using the okFP_REALM environment variable described in [FrontPanel over IP](https://docs.opalkelly.com/fpsdk/frontpanel-over-ip/).

# okSnapApp Command Line Application

`okSnapApp` is setup to be a very simple command-line application that connects to the camera, configures the image sensor and image capture processor, then retrieves a single image with some default settings.  It is not intended to be a full-featured application but highlights the primary interface capabilities required to talk to the camera.  Using `okSnapApp` as a starting point, it is possible to expand to a more capable command-line interface.

## Command Line Usage

`okSnapApp` takes two arguments.  The first is the image sensor acquisition mode taken from the MT9P031 datasheet.  “`0`” means normal image acquisition.  “`9`” is a diagonal gradient.  The gradient and other test modes are useful for ICP testing.

```
> okSnapApp -m 0 image.bin
```

The resulting output file (`image.bin`) will be the full image acquisition output from the sensor.

# okCameraApp GUI Application

## wxWidgets

The `okCameraApp` application is built using the wxWidgets cross-platform C++ GUI class library.  More information may be found at the following site:

**[http://www.wxwidgets.org](http://www.wxwidgets.org/)**

## Threaded FrontPanel API Communication

To create a well-behaved GUI application, it is important that any long-running processing be performed in a separate thread from the application’s GUI thread.  In the case of `okCameraApp`, certain operations such as image readout can take a while.  Therefore, we have moved all camera communication (and, in effect, all communication over the FrontPanel API) into a separate thread.  This thread is abstracted in the `okCThreadCamera` class and represents a disciplined method of device communication.

## Three Camera Operation

The [XEM8320-AU25P](https://opalkelly.com/products/xem8320/) allows for 3 camera operation with the following configurations:

- 3 [SZG-CAMERAs](https://opalkelly.com/products/szg-camera/) connected to SYZYGY ports A, B, and C
- [SZG-MIPI-8320](https://opalkelly.com/products/szg-mipi-8320) connected to port A with 3 Digilent Pcam 5Cs connected to Camera connectors 1, 2, and 3

By default, the application will operate in single camera mode assuming the following configurations:

- Single SZG-CAMERA connected to port A
- SZG-MIPI-8320 connected to port A with single Digilent Pcam 5Cs connected to Camera connector 1

To use the 3 camera operation, ensure that you have the correct hardware configuration as stated above. Then select the `(3 cameras)` option from the `Device` dropdown selector.

# FreeMat 3rd-Party Software Sample

FreeMat is an open-source development environment, similar to MATLAB, designed for rapid engineering, scientific prototyping, and data processing.  It has extensive script capabilities for processing vector and matrix data (such as images) and also has the capability to interface with external (3rd-party) interfaces such as the Opal Kelly FrontPanel API.  Together, these features make it an attractive platform for a sample interface to the EVB100x.

More information about FreeMat may be found here:

**[http://freemat.sourceforge.net/](http://freemat.sourceforge.net/)**

## FrontPanel API Support

Basic FrontPanel API support has been imported into FreeMat using the import command which creates FreeMat commands from DLL entry-points.  In some cases, the preferred functional representation of the API command is not directly available with this method.  For example, `GetDeviceSerialNumber` returns a string.  FreeMat needs to be called with an empty string of the proper length in order to use this direct import.

The preferred functionality could be accomplished with a separately-defined FreeMat command that wraps the imported DLL command.  For simplicity, we simply work around these deficiencies in the example code.  To a great extent, a one-to-one mapping of the API commands has been accomplished.  The exceptions are simple to deal with and understand.

## Interfacing to the Image Capture Processor

Initial configuration and setup for the camera is easy using the imported FrontPanel methods:

```
dev = okFPConstruct;
okFPOpenBySerialX(dev, 0);
okFPLoadDefaultPLLConfiguration(dev);
okFPConfigureFPGA(dev, 'evb1005-xem6010-lx45.bit');

% Reset
okCameraFullReset(dev);
```

The okCameraFullReset function is defined using API methods as well:

```
function okCameraFullReset(dev)
  okFPSetWireInValue(dev, hex2dec('00'), hex2dec('000f'), hex2dec('000f'));
  okFPUpdateWireIns(dev);
  okFPSetWireInValue(dev, hex2dec('00'), hex2dec('0000'), hex2dec('0001'));
  okFPUpdateWireIns(dev);
  ...

  % REG_PLL_CONTROL = 0x0051
  okCameraI2CWrite(dev, hex2dec('10'), hex2dec('0051'));

  % For the XEM6010 / EVB1005
  N=5; M=72; P1=3;
  % REG_PLL_CONFIG1 = ((N-1)<<0) | (M<<8)
  okCameraI2CWrite(dev, hex2dec('11'), N-1 + M*256);
  % REG_PLL_CONFIG2 = (P1-1)<<0
  okCameraI2CWrite(dev, hex2dec('12'), P1-1);
  ...

  okCameraLogicReset(dev);
```

## Data Manipulation and Image Display

The captured image data is received as a 5 megabyte `uint8` vector which is packed one byte per pixel.  To format for display using FreeMat’s image command, the vector is manipulated into a 1296 x 944 x 3 array where each plane of the array represents the red, green, and blue pixels from the Bayer pattern.  For simplicity, the pattern is decimated to fit the array dimension.  Much more could be done to perform higher-quality de-mosaicing of the image.

```
% Read the captured image
okFPReadFromPipeOut(dev, hex2dec('a0'), imglen, imgdata);

% Format for image() display
tmp = double(reshape(img(1:x*y), x, y)).';
imgv = zeros(y/2, x/2, 3);
imgv(:,:,1) = tmp(1:2:y, 2:2:x)/256; % RED
imgv(:,:,2) = tmp(1:2:y, 1:2:x)/256; % GREEN
imgv(:,:,3) = tmp(2:2:y, 1:2:x)/256; % BLUE
image(img);
```
