//
//  Deck.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation
import NetworkLayer

public struct DomainDeck: Identifiable {
    public let id: Int
    public let title: String
    public var learnedWords: Int {
        let learnedCardsIds = UserDefaults.standard.stringArray(forKey: "\(id)") ?? []
        return learnedCardsIds.count
    }
    public let repetitionDate: Date?
    public let cards: [DomainCard]

    public init(deckResponse: DeckResponse) {
        self.id = deckResponse.id
        self.title = deckResponse.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = deckResponse.lastRepeated {
            self.repetitionDate = dateFormatter.date(from: date)
        } else {
            self.repetitionDate = nil
        }
        let decodedCards = deckResponse.cards.map({ card in
            let decodedCard = DomainCard(card: card)
            return decodedCard
        })
        self.cards = decodedCards
    }
}
