//
//  ImageCaptureViewModelTests.swift
//  ColorTraceTests
//
//  Created by Radislav Gaynanov on 08.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import XCTest
@testable import ColorTrace

class ImageCaptureViewModelTests: XCTestCase {
    
    var sut: ImageCaptureViewModel!

    override func setUp() {
        super.setUp()
        sut = ImageCaptureViewModel()
        
    }

    override func tearDown() {
        sut = nil
    }

    func testInitialisation() {
        XCTAssertNotNil(sut.session)
    }
    
    func testStartStopCaptureSession() {
        sut.startCapture()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.sut.session.isRunning)
        }
        
        
        sut.stopCapture()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.sut.session.isRunning)
        }
        
    }

}
