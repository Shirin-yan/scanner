//
//  UIImage.swift
//  Scanner
//
//  Created by Shirin-Yan on 26.08.2024.
//

import UIKit
import CoreImage

extension UIImage {
    
    func applyWhiteBlackFilter(intensity: CGFloat) -> UIImage {
        guard let ciImage = CIImage(image: self) else { return self }

        let context = CIContext(options: nil)
        guard let grayscaleFilter = CIFilter(name: "CIColorControls") else { return self }
        grayscaleFilter.setValue(ciImage, forKey: kCIInputImageKey)
        grayscaleFilter.setValue(0.0, forKey: kCIInputSaturationKey)  // Convert to grayscale
        grayscaleFilter.setValue(0.0, forKey: kCIInputBrightnessKey)  // No change in brightness
        grayscaleFilter.setValue(1.1, forKey: kCIInputContrastKey)    // Slightly increase contrast

        guard let grayscaleImage = grayscaleFilter.outputImage else { return self }
        guard let exposureFilter = CIFilter(name: "CIExposureAdjust") else { return self }
        exposureFilter.setValue(grayscaleImage, forKey: kCIInputImageKey)
        exposureFilter.setValue(intensity, forKey: kCIInputEVKey)  // Adjust exposure for intensity

        guard let outputImage = exposureFilter.outputImage else { return self }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return self
    }
}
