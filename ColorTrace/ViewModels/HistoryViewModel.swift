//
//  HistoryViewModel.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 08.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import Foundation

class HistoryViewModel {
    private var historyRequest = [RecognizedColorModel]()
    
    init() {
       
    }
    
    var countItems: Int {
        return historyRequest.count
    }
    
    func initData(with array: [RecognizedColorModel]) {
        historyRequest.removeAll()
        self.importData(array)
    }

   
    func importData(_ array: [RecognizedColorModel]) {
        historyRequest.append(contentsOf: array)
    }
    
    
    func getHistoryItem(at index: Int) -> RecognizedColorModel{
        return historyRequest[index]
    }
    
    func removeData(at index: Int) {
        historyRequest.remove(at: index)
    }
    
}
