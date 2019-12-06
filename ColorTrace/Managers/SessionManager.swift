//
//  SessionManager.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 01.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import Foundation
import AVFoundation

enum SesionManagerError {
    case notDetermined
    case success
    case configurationFailed
    case noInputDevice
    case noOutputDevice
}

final class SessionManager {
    
    let session = AVCaptureSession()
    
    private var configResult: SesionManagerError  = .notDetermined
    private let sessionQueue: DispatchQueue 
    private let dataOutput: AVCaptureOutput

    init(output: AVCaptureOutput, _ queue: DispatchQueue) {
        self.sessionQueue = queue
        self.dataOutput = output
    }

        //MYTODO: - определить жизненый цикл для ассинхронных вызовов методов менеджера
    func configureSession() {
        sessionQueue.async {[weak self] in
            guard let self = self else {return}
            self.session.beginConfiguration()
            self.session.sessionPreset = .photo
            
            do {
                var defaultVideoDevice: AVCaptureDevice?
                
                if let dualCameraDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                    defaultVideoDevice = dualCameraDevice
                } else if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                    defaultVideoDevice = backCameraDevice
                } else {
                    self.configResult = .noInputDevice
                    self.session.commitConfiguration()
                    return
                }
                
                let captureVideoDevice = try AVCaptureDeviceInput.init(device: defaultVideoDevice!)
                if self.session.canAddInput(captureVideoDevice) {
                    self.session.addInput(captureVideoDevice)
                } else {
                    self.configResult = .noInputDevice
                    self.session.commitConfiguration()
                    return
                }
                
            } catch {
                self.configResult = .configurationFailed
                self.session.commitConfiguration()
                return
            }
            
            
            if self.session.canAddOutput(self.dataOutput) {
                self.session.addOutput(self.dataOutput)
            } else {
                self.configResult = .noOutputDevice
                self.session.commitConfiguration()
                return
            }
            
            self.session.commitConfiguration()
        }
    }
    
    
    //MYTODO: - добавить обработку прерываний
   
    
}
