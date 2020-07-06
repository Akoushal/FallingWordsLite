//
//  FallingWordsLiteTests.swift
//  FallingWordsLiteTests
//
//  Created by Koushal, KumarAjitesh on 2020/07/06.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import XCTest
@testable import FallingWordsLite

class FallingWordsLiteTests: XCTestCase {
    
    var viewModel: GameViewModel?
    
    override func setUp() {
        viewModel = GameViewModel(languageFrom: .EN, languageTo: .ES)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testInitViewModelReadsCorrectlyFromJson() {
        viewModel?.setPairOfTranslations(number: 5)
        XCTAssertFalse(viewModel?.translationToPlay == nil)
        XCTAssertFalse(viewModel?.movingTranlation == nil)
    }
    
    func testAddNonOkOfPointIsIncreased() {
        XCTAssertEqual(viewModel?.incorrectAnswers, 0)
        viewModel?.addIncorrectAnswer()
        XCTAssertEqual(viewModel?.incorrectAnswers, 1)
    }
    
    func testIsCorrectTranslationTrue() {
        viewModel?.setPairOfTranslations(number: 1)
        if let correctTranslation = viewModel?.isCorrectTranslation {
            if viewModel?.translationToPlay?.text_eng == viewModel?.movingTranlation?.text_eng {
                XCTAssertTrue(correctTranslation)
            } else {
                XCTAssertFalse(correctTranslation)
            }
        }
    }
    
    func testIsCorrectTranslationFalse() {
        viewModel?.setPairOfTranslations(number: 100)
        if let correctTranslation = viewModel?.isCorrectTranslation {
            if viewModel?.translationToPlay?.text_eng == viewModel?.movingTranlation?.text_eng {
                XCTAssertTrue(correctTranslation)
            } else {
                XCTAssertFalse(correctTranslation)
            }
        }
    }
    
    func testAddOkOfPointIsIncreased() {
        XCTAssertEqual(viewModel?.correctAnswers, 0)
        viewModel?.addCorrectAnswer()
        XCTAssertEqual(viewModel?.correctAnswers, 1)
    }
    
    func testUserWonIsCorrect() {
        if let userWon = viewModel?.userWon {
            XCTAssertEqual(viewModel?.correctAnswers, 0)
            for _ in 1...10 {
                XCTAssertFalse(userWon)
                viewModel?.addCorrectAnswer()
            }
            XCTAssertEqual(viewModel?.correctAnswers, 10)
            XCTAssertTrue(userWon)
        }
    }
    
    func testUserLostIsCorrect() {
        if let userLost = viewModel?.userLost {
            XCTAssertEqual(viewModel?.incorrectAnswers, 0)
            for _ in 1...3 {
                XCTAssertFalse(userLost)
                viewModel?.addIncorrectAnswer()
            }
            XCTAssertEqual(viewModel?.incorrectAnswers, 3)
            XCTAssertTrue(userLost)
        }
    }
    
    func testRestartSetAllScoresInitial() {
        XCTAssertEqual(viewModel?.incorrectAnswers, 0)
        XCTAssertEqual(viewModel?.correctAnswers, 0)
        for _ in 1...2 {
            viewModel?.addIncorrectAnswer()
            viewModel?.addCorrectAnswer()
        }
        XCTAssertEqual(viewModel?.incorrectAnswers, 2)
        XCTAssertEqual(viewModel?.correctAnswers, 2)
        
        viewModel?.restart()
        
        XCTAssertEqual(viewModel?.incorrectAnswers, 0)
        XCTAssertEqual(viewModel?.correctAnswers, 0)
    }
    
}
