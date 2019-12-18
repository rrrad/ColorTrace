//
//  ExtensionUIButton.swift
//  ColorTrace
//
//  Created by Radislav Gaynanov on 07.12.2019.
//  Copyright © 2019 Radislav Gaynanov. All rights reserved.
//

import UIKit

extension UIButton {
    func wave() {
        let finalColor = UIColor.clear
        let animation = CAKeyframeAnimation.init(keyPath: #keyPath(CALayer.backgroundColor))
        animation.values = [UIColor.clear.cgColor, UIColor.white.cgColor, finalColor.cgColor]
        animation.keyTimes = [0, 0.2, 1]
        animation.duration = 0.5
        layer.add(animation, forKey: nil)
    }
    
}
