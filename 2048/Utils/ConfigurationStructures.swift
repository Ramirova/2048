//
//  Configurations.swift
//  2048
//
//  Created by Розалия Амирова on 15/05/2019.
//  Copyright © 2019 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

enum Direction {
    case up
    case down
    case left
    case right
}

struct BoardSizeParameters {
    let numberOfCells  = 16
    let borderSize  = CGSize(width: 10, height: 10)
    let backgroundColorProperty = UIColor.white
    let cellCornerRadius: Int
    let boardSideSize: CGFloat
    let numberOfCellsInLine: Int
    let distanceBetweenCells: CGFloat
    var cellSideSize: CGFloat
    var boardSize: CGSize
    
    init(boardSideSize: CGFloat, numberOfCellsInLine: Int, distanceBetweenCells: CGFloat, cellCornerRadius: Int) {
        self.boardSideSize = boardSideSize
        self.numberOfCellsInLine = numberOfCellsInLine
        self.distanceBetweenCells = distanceBetweenCells
        self.cellSideSize = (boardSideSize - CGFloat(numberOfCellsInLine) * (distanceBetweenCells - 1)) / CGFloat(numberOfCellsInLine)
        self.boardSize = CGSize.init(width: CGFloat(boardSideSize), height: CGFloat(boardSideSize))
        self.cellCornerRadius = cellCornerRadius
    }
    
    init() {
        self.boardSideSize = 290
        self.numberOfCellsInLine = 4
        self.distanceBetweenCells = 15
        self.cellSideSize = (boardSideSize - CGFloat(numberOfCellsInLine) * (distanceBetweenCells - 1)) / CGFloat(numberOfCellsInLine)
        self.boardSize = CGSize.init(width: CGFloat(boardSideSize), height: CGFloat(boardSideSize))
        self.cellCornerRadius = 0
    }
}

