/**
 * Copyright (c) 2024-2025 Opal Kelly Incorporated
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

/** Discriminant for the camera operating mode. */
export type CameraMode = "szgcam" | "pcam" | "tpg";

/**
 * Interface for matrix row and column dimensions.
 */
export interface IMatrixDimensions {
    rowCount: number;
    columnCount: number;
}

/**
 * Type representing the configuration for a frame capture operation. The configuration
 * specifies the row and column dimensions of the frame to capture and skips specifies
 * the number of rows and columns of the sensor to skip for each pixel.
 */
export type FrameConfiguration = {
    dimensions: MatrixDimensions;
    skips: MatrixDimensions;
};

/**
 * Enumeration for the different test modes that can be enabled on the camera.
 */
export enum TestMode {
    ColorField,
    Classic,
    Walking1s,
    VerticalColorBars,
    // TPG patterns (for TPG mode)
    HorizontalRamp,
    VerticalRamp,
    TemporalRamp,
    SolidRed,
    SolidGreen,
    SolidBlue,
    SolidBlack,
    SolidWhite,
    CombinedRamp,
    Pseudorandom,
    DPColorRamp,
    DPBWVertical,
    DPColorSquare,
}

/**
 * Type representing a camera exposure value. Units are sensor-specific:
 * OV5640 (PCAM): AEC luminance target (0–247, unitless brightness scale).
 * AR0330 (SYZYGY): exposure duration in milliseconds.
 */
export type CameraExposure = number;

export type RedGain = number;

export type GreenGain = number;

export type BlueGain = number;

export type AWB = number;

/**
 * Type representing the row and column dimensions of a matrix.
 */
export type MatrixDimensions = IMatrixDimensions;

/**
 * Calculate effective frame dimensions after applying skip (binning) factors.
 * frameDimension = ceil(size / (2 * (skips + 1))) * 2
 */
export function calculateFrameDimensions(
    size: MatrixDimensions,
    skips: MatrixDimensions
): MatrixDimensions {
    return {
        columnCount: 2 * Math.ceil(size.columnCount / (2 * (skips.columnCount + 1))),
        rowCount: 2 * Math.ceil(size.rowCount / (2 * (skips.rowCount + 1)))
    };
}

