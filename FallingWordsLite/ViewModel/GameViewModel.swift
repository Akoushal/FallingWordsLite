//
//  GameViewModel.swift
//  FallingWordsLite
//
//  Created by Koushal, KumarAjitesh on 2020/07/06.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class GameViewModel {
    
    private var translations: [Translation] = []
    private(set) var languageFrom: Languages!
    private(set) var languageTo: Languages!
    
    var translationToPlay: Translation?
    var movingTranlation: Translation?
    
    private(set) var correctAnswers = 0
    private(set) var incorrectAnswers = 0
    
    private(set) var winScore = 10
    private(set) var loseScore = 3
    
    var isCorrectTranslation: Bool {
        return movingTranlation?.text_eng == translationToPlay?.text_eng
    }
    
    var userLost: Bool {
        return incorrectAnswers >= loseScore
    }
    
    var userWon: Bool {
        return correctAnswers >= winScore
    }
    
    init(languageFrom: Languages, languageTo: Languages) {
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        translations = readWordsFromJson()
    }
    
    func setPairOfTranslations(number: Int) {
        setTranslationToPlay()
        setMovingTranslation(number: number)
    }
    
    func addCorrectAnswer() {
        correctAnswers += 1
    }
    
    func addIncorrectAnswer() {
        incorrectAnswers += 1
    }
    
    func restart() {
        correctAnswers = 0
        incorrectAnswers = 0
    }
    
    private func setTranslationToPlay() {
        translationToPlay = translations.randomElement()
    }
    
    private func setMovingTranslation(number: Int) {
        movingTranlation = getRandomTranslations(number).randomElement()
    }
    
    private func getRandomTranslations(_ number: Int) -> [Translation] {
        guard let translation = translationToPlay else { return [] }
        var randomTranslations = translations.filter({ $0.text_eng != translation.text_eng})[randomPick: number]
        randomTranslations.append(translation)
        return randomTranslations
    }
    
    private func readWordsFromJson() -> [Translation] {
        var translations: [Translation] = []
        
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            // TODO: remove this force try, for the shake of time we test this manually
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let myStructArray = try! JSONDecoder().decode([Translation].self, from: data)
            myStructArray.forEach { translations.append($0) }
            return translations
        }
        return translations
    }
}
