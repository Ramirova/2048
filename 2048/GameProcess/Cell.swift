//
//  Cell.swift
//  2048
//
//  Created by Розалия Амирова on 15/05/2019.
//  Copyright © 2019 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

class Cell: UIView {
    var value: Int
    let numberLabel : UILabel
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(position: CGPoint, width: CGFloat, radius: CGFloat, value: Int) {
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        numberLabel.textAlignment = NSTextAlignment.center
        numberLabel.minimumScaleFactor = 0.5
        self.value = value
        super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
        self.backgroundColor = DesignSettings.colorsToNumbers[value]
        addSubview(numberLabel)
        numberLabel.font = UIFont(name: "Avenir-Black", size: 28)
        layer.cornerRadius = radius
        changeValue(newValue: value)
    }
    
    func isEmpty() -> Bool {
        return value == 0
    }
    
    func changeValue(newValue: Int) {
        self.value = newValue
        self.backgroundColor = DesignSettings.colorsToNumbers[value]
        if newValue != 0 {
            numberLabel.text = "\(value)"
            if newValue >= DesignSettings.minimumNumberForWhiteFontColor {
                numberLabel.textColor = UIColor.white
            } else {
                numberLabel.textColor = UIColor.black
            }
        } else {
            numberLabel.text = ""
        }
    }
}
