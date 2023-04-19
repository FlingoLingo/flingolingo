//
//  Formatter.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation
import SwiftUI

struct DeckFormatter {

    func formatWords(deck: Deck) -> String {
        "\(NSLocalizedString("allWordsDescription", comment: "")) " +
        "\(deck.cards.count)"
    }

    func formatLearnedWords(deck: Deck) -> String {
        "\(NSLocalizedString("learnedWordsDescription", comment: "")) " +
        "\(deck.learnedWords)"
    }

    func formatDate(deck: Deck) -> String {
        "\(NSLocalizedString("lastRepeatDescription", comment: "")) " +
        "\(deck.repetitionDate.formatted(.dateTime.day().month().year()))"
    }
}
