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
    private let captureOutput = CaptureOutputManager()
    private let sessionQueue = DispatchQueue.init(label: "com.jerar.colortrace")
    private let dataOutput = AVCaptureVideoDataOutput()
    private var nextOutputGet: Bool = false
    
    private var keyObserver = [NSKeyValueObservation]()

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
    
    func getColor() {
        nextOutputGet = true
    }
}

extension ImageCaptureViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if nextOutputGet {
            captureOutput.prpareImage(buffer: sampleBuffer)
            nextOutputGet = false
        }
        
    }
}

extension ImageCaptureViewModel {
    
    private func addObserverSession() {
        let valueObservation = session.observe(\.isRunning, options: .new) { (_, change) in
            // реакция на изменение статуса работы сессии
        }
        
        keyObserver.append(valueObservation)
        
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
    func sessionInterruption(notifikation: NSNotification) {
        if let userInfoValue = notifikation.userInfo?[AVCaptureSessionInterruptionReasonKey] as AnyObject?,
            let resonIntegerValue = userInfoValue.integerValue,
            let rason = AVCaptureSession.InterruptionReason.init(rawValue: resonIntegerValue) {
            var showResumeButton = false
            if rason == .audioDeviceInUseByAnotherClient || rason == .videoDeviceInUseByAnotherClient {
                showResumeButton = true
            } else if rason == .videoDeviceNotAvailableWithMultipleForegroundApps {
                showResumeButton = true
            }
            
            if showResumeButton {
                //MYTODO: - если надо изменить UI запретить реакцию на кнопку взять цвет, показать возможность перезапустить сессию
            }
        }
    }
    
    @objc
    func sessionInterruptionEnded(notifikation: NSNotification) {
        //MYTODO: - если надо изменить UI позволить реагировать на кнопку
    }
    
    @objc
    func sessionRuntimeError(notifikation: NSNotification) {
        guard let error = notifikation.userInfo?[AVCaptureSessionErrorKey] as? AVError else { return }
        //MYTODO: - реакция кнопки если нужна
        if error.code == .mediaServicesWereReset {
            sessionQueue.async {[weak self] in
                self?.session.startRunning()
            }
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        for item in keyObserver {
            item.invalidate()
        }
    }
}
#if DEBUG
extension ImageCaptureViewModel {
    func forTestAddObserver() {
        addObserverSession()
    }
}
#endif
