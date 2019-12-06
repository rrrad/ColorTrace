//
//  ImageCaptureViewModel.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 06.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import AVFoundation

class ImageCaptureViewModel: NSObject {
    private var sessionManager: SessionManager
    private let sessionQueue = DispatchQueue.init(label: "com.jerar.colortrace")
    private let dataOutput = AVCaptureVideoDataOutput()


    override init() {
        self.sessionManager = SessionManager.init(output: dataOutput, sessionQueue)
        super.init()
        self.sessionManager.configureSession()
        dataOutput.alwaysDiscardsLateVideoFrames = true
        dataOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
    }
    
    var session: AVCaptureSession {
        get {
            return sessionManager.session
        }
    }
    
    func startCapture() {
        sessionQueue.async {[weak self] in
            self?.addObserverSession()
            self?.session.startRunning()
        }
        
    }
    
    func stopCapture() {
        sessionQueue.async {[weak self] in
            self?.session.stopRunning()
            self?.removeObservers()
        }
    }
}

extension ImageCaptureViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
}

extension ImageCaptureViewModel {
    
    private func addObserverSession() {
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(sessionInterruption),
                                                  name: .AVCaptureSessionWasInterrupted,
                                                  object: session)
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(sessionInterruptionEnded),
                                                  name: .AVCaptureSessionInterruptionEnded,
                                                  object: session)
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(sessionRuntimeError),
                                                  name: .AVCaptureSessionRuntimeError,
                                                  object: session)
           
           
       }
       
       @objc
       func sessionInterruption() {
           print("session Interruption")
       }
       
       @objc
       func sessionInterruptionEnded() {
           print("session Interruption Ended")
       }
       
       @objc
       func sessionRuntimeError() {
           print("session Runtime Error")
       }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
