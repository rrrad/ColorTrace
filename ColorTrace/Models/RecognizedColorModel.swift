//
//  GetColorModel.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 07.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import UIKit

struct RecognizedColorModel: Equatable {
    let nameColor: String
    private(set) var date: Date
    let image: UIImage?
    var description: String
    
    init(nameColor: String, image: UIImage? = nil, description: String? = nil) {
        self.nameColor = nameColor
        self.image = image
        self.description = description ?? ""
        self.date = Date()
    }
}
