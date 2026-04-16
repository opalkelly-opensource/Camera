/**
 * Copyright (c) 2024-2025 Opal Kelly Incorporated
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import "./CameraSettingsView.css";

import SliderComponent from "./SliderComponent";
import SelectSliderComponent, { SelectSliderOption } from "./SelectSliderComponent";

const exposureOptions: SelectSliderOption[] = [
    { label: "8000", value: 0.125 },
    { label: "6400", value: 0.15625 },
    { label: "5000", value: 0.2 },
    { label: "4000", value: 0.25 },
    { label: "3200", value: 0.3125 },
    { label: "2500", value: 0.4 },
    { label: "2000", value: 0.5 },
    { label: "1600", value: 0.625 },
    { label: "1250", value: 0.8 },
    { label: "1000", value: 1 },
    { label: "800", value: 1.25 },
    { label: "640", value: 1.5625 },
    { label: "500", value: 2 },
    { label: "400", value: 2.5 },
    { label: "320", value: 3.125 },
    { label: "250", value: 4 },
    { label: "200", value: 5 },
    { label: "160", value: 6.25 },
    { label: "125", value: 8 },
    { label: "100", value: 10 },
    { label: "80", value: 12.5 },
    { label: "60", value: 16.6667 },
    { label: "50", value: 20 },
    { label: "40", value: 25 },
    { label: "30", value: 33.3333 },
    { label: "25", value: 40 },
    { label: "20", value: 50 },
    { label: "15", value: 66.6667 },
    { label: "13", value: 76.9231 },
    { label: "10", value: 100 },
    { label: "8", value: 125 },
    { label: "6", value: 166.6667 },
    { label: "5", value: 200 },
    { label: "4", value: 250 },
    { label: "0\"3", value: 333.3333 },
    { label: "0\"5", value: 500 }
];

export interface CameraSettingsViewProps {
    exposure: number;
    redGain: number;
    greenGain: number;
    blueGain: number;
    autoWhiteBalance: number;

    onExposureChange?: (value: number) => void;
    onAutoWhiteBalanceChange?: (value: number) => void;

    onRedGainChange?: (value: number) => void;
    onGreenGainChange?: (value: number) => void;
    onBlueGainChange?: (value: number) => void;
}

function CameraSettingsView(props: CameraSettingsViewProps) {

    // Event Handlers
    const onExposureChange = (value: number) => {
        props.onExposureChange?.(value);
    }

    const onAutoWhiteBalanceChange = (value: number) => {
        props.onAutoWhiteBalanceChange?.(value);
    }

    const onRedColorGainChange = (value: number) => {
        props.onRedGainChange?.(value);
    }

    const onGreenColorGainChange = (value: number) => {
        props.onGreenGainChange?.(value);
    }

    const onBlueColorGainChange = (value: number) => {
        props.onBlueGainChange?.(value);
    }

    return (
        <div className="okCameraSettingsPanel">
            <SelectSliderComponent
                label="Exposure"
                color="#FFFFFF"
                value={props.exposure}
                options={exposureOptions}
                onValueChange={onExposureChange}
            />
            <SliderComponent
                label="Auto White Balance"
                color="#FFFFFF"
                value={props.autoWhiteBalance}
                maximumValue={255}
                minimumValue={0}
                stepValue={1}
                onValueChange={onAutoWhiteBalanceChange}
            />
            <SliderComponent
                label="Red Gain"
                color="#EB5757"
                value={props.redGain}
                maximumValue={255}
                minimumValue={0}
                stepValue={1}
                onValueChange={onRedColorGainChange}
            />
            <SliderComponent
                label="Green Gain"
                color="#44BD84"
                value={props.greenGain}
                maximumValue={255}
                minimumValue={0}
                stepValue={1}
                onValueChange={onGreenColorGainChange}
            />
            <SliderComponent
                label="Blue Gain"
                color="#3B62DA"
                value={props.blueGain}
                maximumValue={255}
                minimumValue={0}
                stepValue={1}
                onValueChange={onBlueColorGainChange}
            />
        </div>
    )
}

export default CameraSettingsView;
