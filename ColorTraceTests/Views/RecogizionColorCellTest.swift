//
//  RecogizionColorCellTest.swift
//  ColorTraceTests
//
//  Created by Radislav Gaynanov on 11.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import XCTest
@testable import ColorTrace

class RecogizionColorCellTest: XCTestCase {
    
    var sut: RecognizedColorCell!
    
    override func setUp() {
        super .setUp()
        let controller = HistoryViewController()
        controller.loadViewIfNeeded()
        let tableView = controller.list
        let dataSource = FakeDataSours()
        tableView?.dataSource = dataSource
        
        sut = tableView?.dequeueReusableCell(withIdentifier: "cell", for: IndexPath.init(row: 0, section: 0)) as? RecognizedColorCell
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func testHasNameColorSetInCell() {
        let subview = sut.subviews.filter{$0.accessibilityIdentifier == "nameColor"}.first
        XCTAssertNotNil(subview)
    }
    
   func testHasDescriptSetInCell() {
        let subview = sut.subviews.filter{$0.accessibilityIdentifier == "descript"}.first
        XCTAssertNotNil(subview)
    }
    
    func testHasPhotoSetInCell() {
        let subview = sut.subviews.filter{$0.accessibilityIdentifier == "photo"}.first
        XCTAssertNotNil(subview)
    }
    
    func testSetRecognizedColorModelinCell() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3894", image: UIImage(named: "launch"), description: "test")
        sut.configureCell(item1)
        
        XCTAssertEqual(sut.recognizedColor, item1)
    }
    
    func testConfigureCell() {
        let item1 = RecognizedColorModel.init(nameColor: "RAL3894", image: UIImage(named: "launch"), description: "test")
        sut.configureCell(item1)
        let photoSubview = sut.subviews.filter{$0.accessibilityIdentifier == "photo"}.first as! UIImageView
        let nameSubview = sut.subviews.filter{$0.accessibilityIdentifier == "nameColor"}.first as! UILabel
        let descSubview = sut.subviews.filter{$0.accessibilityIdentifier == "descript"}.first as! UILabel
        
        XCTAssert(photoSubview.image == UIImage(named: "launch"))
        XCTAssert(nameSubview.text == "RAL3894")
        XCTAssert(descSubview.text == "test")

    }
    
    
    
    
    

    

}

extension RecogizionColorCellTest {
    class FakeDataSours: NSObject, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           return UITableViewCell()
        }
    }
}
