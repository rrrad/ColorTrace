//
//  PreviewView.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 03.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewView: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            
        }
        return layer
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

}
