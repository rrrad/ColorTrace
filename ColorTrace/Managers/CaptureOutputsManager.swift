//
//  CaptureOutputsMenager.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 07.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureOutputManager {
    private let context = CIContext()

    func prpareImage(buffer: CMSampleBuffer) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else {
            print("невозможно преобразовать CMSimplePuffer")
            return
        }
        
        let ciImage = CIImage.init(cvPixelBuffer: pixelBuffer)
        
        let imageRect = CGRect.init(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
        
        if let image = context.createCGImage(ciImage, from: imageRect) {
            print("IMAGE GET")
        }
        
    }
    
    
}
