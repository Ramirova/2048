//
//  DesignSettings.swift
//  2048
//
//  Created by Розалия Амирова on 22/05/2019.
//  Copyright © 2019 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

struct DesignSettings {
    static let colorsToNumbers = [0: UIColor.init(red: 185/255, green: 193/255, blue: 203/255, alpha: 1),
                                  2: UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1),
                                  4: UIColor.init(red: 225/255, green: 227/255, blue: 230/255, alpha: 1),
                                  8: UIColor.init(red: 167/255, green: 220/255, blue: 251/255, alpha: 1),
                                  16: UIColor.init(red: 112/255, green: 178/255, blue: 249/255, alpha: 1),
                                  32: UIColor.init(red: 63/255, green: 138/255, blue: 128/255, alpha: 1),
                                  64: UIColor.init(red: 38/255, green: 101/255, blue: 207/255, alpha: 1),
                                  128: UIColor.init(red: 24/255, green: 75/255, blue: 177/255, alpha: 1),
                                  256: UIColor.init(red: 34/255, green: 63/255, blue: 128/255, alpha: 1),
                                  512: UIColor.init(red: 17/255, green: 145/255, blue: 128/255, alpha: 1),
                                  1024: UIColor.init(red: 0/255, green: 33/255, blue: 176/255, alpha: 1),
                                  2048: UIColor.init(red: 13/255, green: 12/255, blue: 107/255, alpha: 1)]
    static let minimumNumberForWhiteFontColor = 64
    static let numberOfCellsInLine = 4
}
