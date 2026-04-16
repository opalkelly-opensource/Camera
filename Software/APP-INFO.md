The [Camera](https://docs.opalkelly.com/fpsdk/samples-and-tools/camera-example-design/) app is a demonstration FrontPanel Platform App providing a full image capture pipeline and display functionality to the FrontPanel host. The app supports three camera configurations and includes image signal processing and real-time object detection. Functionality includes:

* Adjustable capture size and exposure
* Real-time red, green, and blue histograms
* Adjustable red, green, and blue color gains, and white balance
* Test Pattern Generator with multiple patterns
* YOLO-based real-time object detection with bounding boxes and class labels

# Compatibility

The camera app is compatible with the following FPGA module and camera peripheral combinations:

* [XEM8320](https://opalkelly.com/products/xem8320/)
  * [SZG-CAMERA](https://opalkelly.com/products/szg-camera/) - Port A
  * [SZG-MIPI-8320](https://opalkelly.com/products/szg-mipi-8320/) - Port A
  * No camera (Test Pattern Generator)
* [SZG-HUB1450](https://opalkelly.com/products/szg-hub1450/)
  * [SZG-CAMERA](https://opalkelly.com/products/szg-camera/) - Port A
  * [SZG-MIPI-8320](https://opalkelly.com/products/szg-mipi-8320/) - Port A
  * No camera (Test Pattern Generator)

# Usage

This application provides settings to control camera operation and display output, along with indicators to monitor the status of the frame capture process.

## Device Settings

* **Camera Mode:** Select *Image Capture* or one of the test patterns from the dropdown list.
* **Capture Size:** Select the size from the dropdown list. Available sizes depend on the camera configuration.
* **Image Size:** Select scale to fit the window or 1:1.
* **TPG Motion Speed:** Adjust the speed of animated test patterns using the slider. Only available when a test pattern is selected.

## Image Settings

* **Shutter Speed:** Select using the slider.
* **Auto White Balance:** Adjust the AWB threshold with the slider.
* **Color Gains:** Adjust the *Red*, *Green*, and *Blue* color gains using the sliders.

## Capture Status

* **Camera FPS:** Rate of unique frames captured from the camera.
* **System FPS:** Rate at which the application retrieves and displays captured images.

## Histogram

* **Real-Time Histograms:** Red, green, and blue channel histograms for evaluating image exposure and color balance.

## Object Detection

* **Object Detection:** Toggle real-time object detection overlay on the live video. Detected objects are displayed with bounding boxes and class labels with confidence scores.

## Capture Modes

* **Continuous Capture:** Enable to periodically capture frames from the camera or disable to manually capture frames using the 'Capture' button.


# Version History

* 1.0.0 (released 2026-04-14)
  * Initial public release of the Camera Example Design — AMD
    Video IP gateware with FrontPanel Platform web application
    targeting SZG-HUB1450-AU10P and XEM8320-AU25P boards with
    SZG-Camera and SZG-MIPI-8320 sensor modules.
