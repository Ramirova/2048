//
//  PersistantStorage.swift
//  2048
//
//  Created by Розалия Амирова on 21/05/2019.
//  Copyright © 2019 Розалия Амирова. All rights reserved.
//

import Foundation

class UserDefaultsStorageManager: GameStorageProtocol {
    
    let boardUserDefaultsAlias = "2048GameBoard"
    let launchedBeforeUserDefaultsAlias = "2048launchedBefore"
    let bestScoreDefaultsAlias = "bestScore"
    let currentScoreDefaultsAlias = "currentScore"
    let storage = UserDefaults.standard
    static let sharedManager = UserDefaultsStorageManager()
    
    private init() {}
    
    func saveBoardState(board: Dictionary<IndexPath, Cell>) {
        var savingArray =  Array(repeating: Array(repeating: 0, count: DesignSettings.numberOfCellsInLine), count: DesignSettings.numberOfCellsInLine)
        for i in 0..<DesignSettings.numberOfCellsInLine {
            for j in 0..<DesignSettings.numberOfCellsInLine {
                guard let cell = board[IndexPath.init(row: i, section: j)] else { return }
                savingArray[i][j] = cell.value
            }
        }
        storage.set(savingArray, forKey: "2048GameBoard")
    }
    
    func getBoardState() -> [[Int]] {
        if isLaunchedBefore() {
            return storage.array(forKey: "2048GameBoard") as! [[Int]]
        }
        return Array(repeating: Array(repeating: 0, count: DesignSettings.numberOfCellsInLine), count: DesignSettings.numberOfCellsInLine)
    }
    
    func isLaunchedBefore() -> Bool {
        let isLaunchedBefore = storage.bool(forKey: launchedBeforeUserDefaultsAlias)
        if !isLaunchedBefore {
            storage.set(true, forKey: launchedBeforeUserDefaultsAlias)
        }
        return isLaunchedBefore
    }
    
    func saveToDisk() {
        storage.synchronize()
    }
    
    func setCurrentScore(score: Int) {
        storage.set(score, forKey: currentScoreDefaultsAlias)
    }
    
    func getCurrentScore() -> Int {
        return storage.integer(forKey: currentScoreDefaultsAlias)
    }
    
    func setBestScore(score: Int) {
        storage.set(score, forKey: bestScoreDefaultsAlias)
    }
    
    func getBestScore() -> Int {
        return storage.integer(forKey: bestScoreDefaultsAlias)
    }
}
