//
//  CapturePreviewViewTest.swift
//  ColorTraceTests
//
//  Created by Radislav Gaynanov on 18.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import XCTest
import AVFoundation
@testable import ColorTrace

class CapturePreviewViewTest: XCTestCase {
    
    
    var sut:PreviewView!
    
    override func setUp() {
        super .setUp()
        sut = PreviewView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()   }
    
    func testViewIsAVCaptureVideoPreviewLayer() {
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut.layer.isKind(of: AVCaptureVideoPreviewLayer.self))
    }
    
    func testViewContainedPropertyPreviewLayer() {
        XCTAssertNotNil(sut.previewLayer)
        XCTAssertTrue(sut.previewLayer.isKind(of: AVCaptureVideoPreviewLayer.self))
    }
    
    func testSetSessionInView() {
        XCTAssertNil(sut.session)
        let s = AVCaptureSession()
        sut.session = s
        XCTAssertNotNil(sut.session)
        XCTAssertEqual(sut.session, s)
    }

   

}
