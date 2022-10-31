//
//  ViewController.swift
//  2048
//
//  Created by Розалия Амирова on 15/05/2019.
//  Copyright © 2019 Розалия Амирова. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let persistantStorage: GameStorageProtocol = UserDefaultsStorageManager.sharedManager

    @IBOutlet weak var gameBoardView: GameBoardView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    var bestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let boardSizeConfiguration = BoardSizeParameters.init(boardSideSize: gameBoardView.frame.size.width, numberOfCellsInLine: 4, distanceBetweenCells: 15, cellCornerRadius: 10)
        
        if !persistantStorage.isLaunchedBefore() {
            gameBoardView.buildBoard(configuration: boardSizeConfiguration, values: Array(repeating: Array(repeating: 0, count: DesignSettings.numberOfCellsInLine), count: DesignSettings.numberOfCellsInLine))
            persistantStorage.setBestScore(score: 0)
            gameBoardView.insertValueAtRandomPlace(value: 2)
            gameBoardView.insertValueAtRandomPlace(value: 2)
        } else {
            gameBoardView.currentScore = persistantStorage.getCurrentScore()
            gameBoardView.buildBoard(configuration: boardSizeConfiguration, values: persistantStorage.getBoardState())
        }
        setupSwipeGestureRecognizers()
        bestScore = persistantStorage.getBestScore()
        persistantStorage.saveBoardState(board: gameBoardView.board)
        handleScores()
    }

    @IBAction func onRestartButtonTap(_ sender: Any) {
        gameBoardView.startNewGame()
        handleScores()
    }
    
    func setupSwipeGestureRecognizers() {
        for direction : UISwipeGestureRecognizer.Direction in [.left, .right, .up, .down] {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
            gesture.direction = direction
            view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func swipe(recognizer:UIGestureRecognizer?) {
        guard let recognizer = recognizer as? UISwipeGestureRecognizer else { return }
        switch recognizer.direction {
        case UISwipeGestureRecognizer.Direction.right:
            makeMove(direction: .right)
        case UISwipeGestureRecognizer.Direction.left:
            makeMove(direction: .left)
        case UISwipeGestureRecognizer.Direction.up:
            makeMove(direction: .up)
        case UISwipeGestureRecognizer.Direction.down:
            makeMove(direction: .down)
        default:
            break
        }
    }
    
    func makeMove(direction: Direction) {
        guard let gameBoardView = gameBoardView else { return }
        gameBoardView.moveCells(direction: direction)
        let gameCheckResult = checkIfGameIsOver()
        if gameCheckResult.gameIsOver {
            let alert = UIAlertController(title: gameCheckResult.messageToUser ?? "", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать игру заново", style: .default, handler: {
                action in gameBoardView.startNewGame()
            }))
            self.present(alert, animated: true)
        }
        if gameBoardView.cellsMovedAtLastTurn {
            gameBoardView.insertValueAtRandomPlace(value: 2)
        }
        handleScores()
        persistantStorage.saveBoardState(board: gameBoardView.board)
    }
    
    func checkIfGameIsOver() -> (gameIsOver: Bool, messageToUser: String?) {
        if gameBoardView.checkIfUserWon() {
            return (true, "Вы выиграли!")
        }
        if gameBoardView.checkIfUserLost() {
            return (true, "Вы проиграли")
        }
        return (false, nil)
    }
    
    func handleScores() {
        persistantStorage.setCurrentScore(score: gameBoardView.currentScore)
        scoreLabel.text = "Счёт: \(gameBoardView.currentScore)"
        bestScoreLabel.text = "Лучший результат: \(persistantStorage.getBestScore())"
        if gameBoardView.currentScore > bestScore {
            bestScoreLabel.text = "Лучший результат: \(gameBoardView.currentScore)"
            persistantStorage.setBestScore(score: gameBoardView.currentScore)
        }
    }
}

