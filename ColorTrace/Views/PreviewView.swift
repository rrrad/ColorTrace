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
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        return layer
    }
    
    var session: AVCaptureSession? {
        get {
            return previewLayer.session
        }
        set {
            previewLayer.session = newValue
        }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

}
