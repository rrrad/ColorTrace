//
//  CaptureAutorizer.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 01.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import Foundation
import AVFoundation

public final class CaptureAutorizer {
    public func CaptureAuth() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized :
                    // configureCaptureSession()
        case .notDetermined :
            AVCaptureDevice.requestAccess(for: .video) { (res) in
                if res {
                    // configureCaptureSession()
                } else {
                    // call alert about impossible to take camera
                }
            }
        case .denied :
            return // call alert about impossible to take camera
        case .restricted :
            return //  call alert about impossible to take camera
        }
    }
}
