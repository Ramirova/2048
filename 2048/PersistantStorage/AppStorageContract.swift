//
//  AppContract.swift
//  2048
//
//  Created by Розалия Амирова on 21/05/2019.
//  Copyright © 2019 Розалия Амирова. All rights reserved.
//

import Foundation

protocol GameStorageProtocol {
    func saveBoardState(board: Dictionary<IndexPath, Cell>)
    func getBoardState() -> [[Int]]
    func isLaunchedBefore() -> Bool
    func saveToDisk()
    func setCurrentScore(score: Int)
    func getCurrentScore() -> Int
    func setBestScore(score: Int)
    func getBestScore() -> Int
}
