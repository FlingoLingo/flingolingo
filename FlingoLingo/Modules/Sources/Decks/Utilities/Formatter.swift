//
//  Formatter.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

struct Formatter {

    func formatWords(deck: Deck) -> String {
        "Всего слов: \(deck.wordsCount)"
    }

    func formatLearnedWords(deck: Deck) -> String {
        "Выучено: \(deck.learnedWords)"
    }

    func formatDate(deck: Deck) -> String {
        "Последний раз повторяли: \(deck.repetitionDate.formatted(.dateTime.day().month().year()))"
    }
}
