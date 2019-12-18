//
//  ImageCaptureViewControllerTest.swift
//  ColorTraceTests
//
//  Created by Radislav Gaynanov on 17.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import XCTest
import  AVFoundation
@testable import ColorTrace

class ImageCaptureViewControllerTest: XCTestCase {
    
    var sut:ImageCaptureViewController!
    var preview: UIView?
    var traceButton: UIButton?
    var historyButton: UIButton?
    var mock: MockImageCaptureViewModel!
    
    override func setUp() {
        super.setUp()
        mock = MockImageCaptureViewModel()
        
        sut = ImageCaptureViewController()
        sut.viewModel = mock
        sut.loadViewIfNeeded()
        
        preview = sut.view.subviews.filter { $0.accessibilityIdentifier == "preview"}.first
        traceButton = sut.view.subviews.filter { $0.accessibilityIdentifier == "traceButton"}.first as? UIButton
        historyButton = sut.view.subviews.filter { $0.accessibilityIdentifier == "historyButton"}.first as? UIButton
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSubviewIsSetInView() {
        let mask = sut.view.subviews.filter { $0.accessibilityIdentifier == "mask"}.first

        XCTAssertNotNil(preview)
        XCTAssertNotNil(mask)
        XCTAssertNotNil(traceButton)
        XCTAssertNotNil(historyButton)
    }

    func testSessionSetInPreview() {
        let pre = preview?.layer as! AVCaptureVideoPreviewLayer
        XCTAssertNotNil(pre.session)
        
    }
    
    func testViewModelInitialSetInViewController() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func testCreateMaskReturnView() {
        let createView = sut.createMask(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), x: 50, y: 50, radius: 10)
        XCTAssertNotNil(createView)
        XCTAssertTrue(createView .isKind(of: UIView.self))
        XCTAssertEqual(createView.frame.width, 100)
        XCTAssertEqual(createView.frame.height, 100)
    }
    
    func testCreateMaskContainsShapeLayer() {
        let createView = sut.createMask(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), x: 50, y: 50, radius: 10)
        let createLayer = createView.layer.mask
        XCTAssertNotNil(createLayer)
        XCTAssertTrue(createLayer is CAShapeLayer)

    }

    
    func testForCallStartCapture() {
        traceButton?.sendActions(for: .touchUpInside)
        XCTAssertTrue(mock.pressGetColor)
    }
    
    func testForCallStopCapture() {
        XCTAssertFalse(mock.pressStart)
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertTrue(mock.pressStart)
    }
    
    func testForCallGetColor() {
        XCTAssertFalse(mock.pressStop)
        sut.beginAppearanceTransition(false, animated: true)
        sut.endAppearanceTransition()
        XCTAssertTrue(mock.pressStop)
        
    }
    
    func testForCallShowHistory() {
        XCTAssertNil(sut.presentedViewController)
        guard let target = historyButton?.allTargets.first else {
            XCTFail()
            return
        }
        XCTAssertTrue(target is ImageCaptureViewController)
        
        
        historyButton?.sendActions(for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[unowned self] in
            XCTAssertNotNil(self.sut.presentedViewController)
            XCTAssertNotNil(self.sut.presentedViewController is HistoryViewController)
        }
        
        
       
        

    }
    
}

extension ImageCaptureViewControllerTest {
    
    class MockImageCaptureViewModel: ImageCaptureViewModel {
        var pressStart: Bool = false
        var pressStop: Bool = false
        var pressGetColor: Bool = false

        
        override func startCapture() {
            pressStart = true
        }
        
        override func stopCapture() {
            pressStop = true
        }
        
        override func getColor() {
            pressGetColor = true
        }
        
        
    }
}
