//
//  GameBoardView.swift
//  2048
//
//  Created by Розалия Амирова on 15/05/2019.
//  Copyright © 2019 Розалия Амирова. All rights reserved.
//

import Foundation
import UIKit

class GameBoardView: UIView {
    
    var board = Dictionary<IndexPath, Cell>() //row - x, section - y
    var configuration = BoardSizeParameters.init()
    var currentScore = 0
    var cellsMovedAtLastTurn = false
    
    func buildBoard(configuration: BoardSizeParameters, values: [[Int]]) {
        self.configuration = configuration
        for i in 0..<configuration.numberOfCellsInLine {
            for j in 0..<configuration.numberOfCellsInLine {
                let x = configuration.distanceBetweenCells + CGFloat(i)*(configuration.cellSideSize + configuration.distanceBetweenCells)
                let y = configuration.distanceBetweenCells + CGFloat(j)*(configuration.cellSideSize + configuration.distanceBetweenCells)
                let cell = Cell.init(position: CGPoint(x: x, y: y), width: CGFloat(configuration.cellSideSize), radius: CGFloat(configuration.cellCornerRadius), value: values[i][j])
                layer.frame = CGRect(origin: pointAt(x: i, y: j), size: CGSize.init(width: configuration.cellSideSize, height: configuration.cellSideSize))
                layer.addSublayer(cell.layer)
                board[IndexPath.init(row: i, section: j)] = cell
            }
        }
    }
    
    func startNewGame() {
        currentScore = 0
        for cell in board {
            cell.value.changeValue(newValue: 0)
        }
        insertValueAtRandomPlace(value: 2)
        insertValueAtRandomPlace(value: 2)
    }
    
    func insertValueAtRandomPlace(value: Int) {
        let emptyCells = getEmptyCells()
        if emptyCells.isEmpty {
            return
        }
        let randomIndex = Int(arc4random_uniform(UInt32(emptyCells.count-1)))
        let randomIndexPath = emptyCells[randomIndex]
        changeValue(at: randomIndexPath, to: value)
    }
    
    func getEmptyCells() -> [IndexPath] {
        var result = [IndexPath]()
        for cell in board {
            if cell.value.value == 0 {
                result.append(cell.key)
            }
        }
        return result
    }
    
    func pointAt(x:Int, y:Int) -> CGPoint {
        let offsetX = configuration.borderSize.width
        let offsetY = configuration.borderSize.height
        let width = configuration.cellSideSize + configuration.borderSize.width
        let height = configuration.cellSideSize + configuration.borderSize.height
        return CGPoint(x: offsetX + width * CGFloat(x), y: offsetY + height * CGFloat(y))
    }
    
    func changeValue(at: IndexPath, to: Int) {
        board[at]?.changeValue(newValue: to)
    }
    
    func moveCells(direction: Direction) {
        cellsMovedAtLastTurn = false
        switch direction {
        case .down:
            for i in (0..<configuration.numberOfCellsInLine) {
                for j in (0..<configuration.numberOfCellsInLine-1).reversed() {
                    moveValueIfPossible(cellIndexPath: IndexPath.init(row: i, section: j), direction: direction)
                }
            }
        case .up:
            for i in 0..<configuration.numberOfCellsInLine {
                for j in 1..<configuration.numberOfCellsInLine {
                    moveValueIfPossible(cellIndexPath: IndexPath.init(row: i, section: j), direction: direction)
                }
            }
        case .left:
            for i in 1..<configuration.numberOfCellsInLine {
                for j in 0..<configuration.numberOfCellsInLine {
                    moveValueIfPossible(cellIndexPath: IndexPath.init(row: i, section: j), direction: direction)
                }
            }
        case .right:
            for i in (0..<configuration.numberOfCellsInLine-1).reversed() {
                for j in 0..<configuration.numberOfCellsInLine {
                    moveValueIfPossible(cellIndexPath: IndexPath.init(row: i, section: j), direction: direction)
                }
            }
        }
    }
    
    func checkGameState() {
        
    }
    
    func checkIfUserWon() -> Bool {
        for cell in board.values {
            if cell.value == 2048 {
                return true
            }
        }
        return false
    }
    
    func checkIfUserLost() -> Bool {
        return getEmptyCells().isEmpty
    }
    
    func moveValueIfPossible(cellIndexPath: IndexPath, direction: Direction) {
        var cellIndexPath = cellIndexPath
        if board[cellIndexPath] != nil && board[cellIndexPath]?.value != 0 {
            while valueOfNearCell(currentCellIndexPath: cellIndexPath, direction: direction) == 0 {
                if let nearCellIndexPath = nearCellIndexPath(currentCellIndexPath: cellIndexPath, direction: direction) {
                    board[nearCellIndexPath]?.changeValue(newValue: board[cellIndexPath]?.value ?? 0)
                    board[cellIndexPath]?.changeValue(newValue: 0)
                    cellIndexPath = nearCellIndexPath
                    cellsMovedAtLastTurn = true
                }
            }
            if board[cellIndexPath]?.value == valueOfNearCell(currentCellIndexPath: cellIndexPath, direction: direction) {
                if let nearCellIndexPath = nearCellIndexPath(currentCellIndexPath: cellIndexPath, direction: direction) {
                    if let value = board[cellIndexPath]?.value {
                        board[nearCellIndexPath]?.changeValue(newValue: 2 * value)
                        currentScore += 2 * value
                        board[cellIndexPath]?.changeValue(newValue: 0)
                    }
                }
            }
        }
    }
    
    func valueOfNearCell(currentCellIndexPath: IndexPath, direction: Direction) -> Int? {
        if let nearCellIndexPath = nearCellIndexPath(currentCellIndexPath: currentCellIndexPath, direction: direction) {
            return board[nearCellIndexPath]?.value
        }
        return nil
    }
    
    func nearCellIndexPath(currentCellIndexPath: IndexPath, direction: Direction) -> IndexPath? {
        switch direction {
        case .up:
            if currentCellIndexPath.section - 1 >= 0 {
                return IndexPath.init(row: currentCellIndexPath.row, section: currentCellIndexPath.section - 1)
            }
        case .down:
            if currentCellIndexPath.section + 1 >= 0 {
                return IndexPath.init(row: currentCellIndexPath.row, section: currentCellIndexPath.section + 1)
            }
        case .left:
            if currentCellIndexPath.row - 1 >= 0 {
                return IndexPath.init(row: currentCellIndexPath.row - 1, section: currentCellIndexPath.section)
            }
        case .right:
            if currentCellIndexPath.row + 1 >= 0 {
                return IndexPath.init(row: currentCellIndexPath.row + 1, section: currentCellIndexPath.section)
            }
        }
        return nil
    }
}
