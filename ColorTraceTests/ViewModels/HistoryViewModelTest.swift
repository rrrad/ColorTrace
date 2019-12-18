//
//  HistoryViewModelTest.swift
//  ColorTraceTests
//
//  Created by Radislav Gaynanov on 08.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import XCTest
@testable import ColorTrace

class HistoryViewModelTest: XCTestCase {
    
    var sut: HistoryViewModel!
    
    override func setUp() {
        super.setUp()
        sut = HistoryViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetCountData() {
           XCTAssertTrue(sut.countItems >= 0)
       }
    
    func testInitializeData() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3007")
        let item2 = RecognizedColorModel.init(nameColor: "RAL3002")
        let arr = [item1, item2]
        sut.importData(arr)
        let item3 = RecognizedColorModel.init(nameColor: "RAL3027")
        sut.initData(with: [item3])
        XCTAssertEqual(sut.countItems, 1)
        let res = sut.getHistoryItem(at: 0)
        XCTAssertEqual(res.date, item3.date)
    }
    
    func testAddHistoryItem() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3007")
        let item2 = RecognizedColorModel.init(nameColor: "RAL3002")
        let item3 = RecognizedColorModel.init(nameColor: "RAL3027")
        let item4 = RecognizedColorModel.init(nameColor: "RAL3002")
        let arr = [item1, item2]
        let arr2 = [item3, item4]
        sut.importData(arr)
        XCTAssertEqual(sut.countItems, 2)

        sut.importData(arr2)
        XCTAssertEqual(sut.countItems, 4)
    }
    
    func testGetDataAtIndexPath() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3027")
        sut.importData([item1])
        let res = sut.getHistoryItem(at: 0)
        XCTAssertEqual(res.date, item1.date)
    }
    
    func testRemoveDataAtIndexPath() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3007")
        let item2 = RecognizedColorModel.init(nameColor: "RAL3002")
        let arr = [item1, item2]
        sut.importData(arr)
        sut.removeData(at: 0)
        XCTAssertEqual(sut.countItems, 1)
    }

}
