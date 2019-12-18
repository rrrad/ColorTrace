//
//  HistoryListViewControllerTest.swift
//  ColorTraceTests
//
//  Created by Radislav Gaynanov on 09.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import XCTest
@testable import ColorTrace

class HistoryListViewControllerTest: XCTestCase {
    
    var sut: HistoryViewController!
    
    override func setUp() {
        super.setUp()
        sut = HistoryViewController.init()
        sut.loadViewIfNeeded()

    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTableViewNotNilWhenViewIsLoaded() {
        XCTAssertNotNil(sut.list)
    }
    
    func testWhenViewIsLoadedViewModelNotnil() {
        XCTAssertNotNil(sut.viewModel)
    }
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.list.delegate is HistoryViewController)
    }
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.list.dataSource is HistoryViewController)
    }
    func testWhenViewIsLoadedDelegateEqualsDataSource() {
        XCTAssertEqual(sut.list.delegate as? HistoryViewController, sut.list.dataSource as? HistoryViewController)
    }
    
    func testNumberOfSectionTableView() {
        let number = sut.list.numberOfSections
        XCTAssertEqual(number, 1)
    }
    
    func testNumberOfRowsInSection() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3007")
        let item2 = RecognizedColorModel.init(nameColor: "RAL3407")
        sut.viewModel.importData([ item1, item2])
        sut.list.reloadData()  // принудительный релоад
        let number = sut.list.numberOfRows(inSection: 0)
        XCTAssertEqual(number, 2)

    }
    
    func testcellForRowAtIndexPathGettingColorCell() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3007")
        sut.viewModel.importData([ item1])
        sut.list.reloadData()  // принудительный релоад
        let cell = sut.list.cellForRow(at: IndexPath.init(row: 0, section: 0))
        XCTAssertTrue(cell is RecognizedColorCell)
    }
    
    func testForCallConfigureCell() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3007")
        sut.viewModel.importData([item1])
        sut.list.reloadData()
        
        let cell = sut.list.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! RecognizedColorCell
        XCTAssertEqual(cell.recognizedColor?.nameColor, item1.nameColor)
    }
    
    func testHeightOfCell() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3007")
        sut.viewModel.importData([item1])
        sut.list.reloadData()
        let cell = sut.list.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! RecognizedColorCell
        let height = cell.frame.height
        XCTAssertTrue(height == 104)
    }
    
    func testButtonDismissNotNilWhenViewIsLoaded() {
        XCTAssertNotNil(sut.returnButton)
    }
    
    func testDeismissCurrentViewController() {
        let mockVC = MockHistoryListViewController()
        mockVC.dismissHistory()
        XCTAssertTrue(mockVC.isDismissed)
    }
    
    func testPressReturnButtonfromCurrentViewController() {
           let mockVC = MockHistoryListViewController()
        guard
            let sub = mockVC.view.subviews.filter({$0.isKind(of: UIButton.self)}).first,
            let button = sub as? UIButton
            else {
                XCTFail()
                return
        }
        button.sendActions(for: .touchUpInside)
           XCTAssertTrue(mockVC.isDismissed)
       }
}

extension HistoryListViewControllerTest{
    class MockHistoryListViewController: HistoryViewController {
        var isDismissed = false
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismissed = true
        }
    }
}
