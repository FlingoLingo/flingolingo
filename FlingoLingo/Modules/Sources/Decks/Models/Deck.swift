//
//  Deck.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public struct Deck: Identifiable {
    public let id: Int
    public let title: String
    public let learnedWords: Int
    public let repetitionDate: Date
    public let cards: [Card]

    public init(id: Int, title: String, learnedWords: Int, repetitionDate: Date, cards: [Card]) {
        self.id = id
        self.title = title
        self.learnedWords = learnedWords
        self.repetitionDate = repetitionDate
        self.cards = cards
    }
}
