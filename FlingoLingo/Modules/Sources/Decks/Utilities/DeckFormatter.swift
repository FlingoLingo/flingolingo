//
//  Formatter.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation
import SwiftUI

struct DeckFormatter {

    func formatWords(deck: DomainDeck) -> String {
        "\(NSLocalizedString("allWordsDescription", comment: "")) " +
        "\(deck.cards.count)"
    }

    func formatLearnedWords(deck: DomainDeck) -> String {
        "\(NSLocalizedString("learnedWordsDescription", comment: "")) " +
        "\(deck.learnedWords)"
    }

    func formatDate(deck: DomainDeck) -> String {
        "\(NSLocalizedString("lastRepeatDescription", comment: "")) " +
        "\(deck.repetitionDate.formatted(.dateTime.day().month().year()))"
    }
}
