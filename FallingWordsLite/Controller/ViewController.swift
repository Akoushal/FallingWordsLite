//
//  ViewController.swift
//  FallingWordsLite
//
//  Created by Koushal, KumarAjitesh on 2020/07/06.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordToTranslateLabel: UILabel!
    @IBOutlet weak var newWordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scoreOk: UILabel!
    @IBOutlet weak var scoreNotOk: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var isWordMoving = false
    var userHasAnswered = false
    
    // MARK: - Injection
    
    private var viewModel: GameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GameViewModel(languageFrom: .ES, languageTo: .EN)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNewCombination()
    }
    
    func showNewCombination() {
        self.view.layoutIfNeeded()
        viewModel?.setPairOfTranslations(number: 5)
        
        wordToTranslateLabel.text = viewModel?.translationToPlay?.get(language: viewModel?.languageFrom)
        newWordLabel.text = viewModel?.movingTranlation?.get(language: self.viewModel?.languageTo)
        
        moveWordDown {
            self.isWordMoving = false
            
            if !self.userHasAnswered {
                self.viewModel?.addIncorrectAnswer()
                self.updateScore()
            }
            self.userHasAnswered = false
        }
    }

    func moveWordDown(completion: @escaping () -> Void) {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.isWordMoving = true
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.maxY + 10)
        }, completion: { finished in
            self.isWordMoving = false
            completion()
        })
    }
    
    func resetInitialPosition() {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.minY)
        }, completion: { finished in
        })
    }
    
    func updateScore() {
        userHasAnswered = true
        isWordMoving = false
        if let correctAnswers = viewModel?.correctAnswers, let score = viewModel?.winScore {
            scoreOk.text = "\(correctAnswers)/\(score)"
        }
        if let noncorrectAnswers = viewModel?.incorrectAnswers, let score = viewModel?.loseScore {
            scoreNotOk.text = "\(noncorrectAnswers)/\(score)"
        }
        resetInitialPosition()
        handleWinLoss()
    }
    
    func handleWinLoss() {
        if let win = viewModel?.userWon, let loss = viewModel?.userLost {
            if win {
                showResult(with: "👏 👌\n You win!")
            } else if loss {
                showResult(with: "😭 🤷‍♀️\n You lose!")
            } else {
                showNewCombination()
            }
        } else {
            showNewCombination()
        }
    }
    
    private func showResult(with message: String) {
        resultLabel.text = message
        resultLabel.isHidden = false
        resetButton.isHidden = false
    }

    @IBAction func okPressed(_ sender: Any) {
        if let correctTranslation = viewModel?.isCorrectTranslation {
            correctTranslation ? viewModel?.addCorrectAnswer() : viewModel?.addIncorrectAnswer()
            updateScore()
        }
    }
    
    @IBAction func notOkPressed(_ sender: Any) {
        if let correctTranslation = viewModel?.isCorrectTranslation {
            correctTranslation ? viewModel?.addCorrectAnswer() : viewModel?.addIncorrectAnswer()
            updateScore()
        }
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        resultLabel.isHidden = true
        resetButton.isHidden = true
        viewModel?.restart()
        updateScore()
    }
}
