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
        var date = ""
        if let dateValue = deck.repetitionDate {
            date = "\(NSLocalizedString("lastRepeatDescription", comment: "")) " +
            "\(dateValue.formatted(.dateTime.day().month().year()))"
        } else {
            date = "\(NSLocalizedString("lastRepeatDescription", comment: "")) " +
            "\(NSLocalizedString("noRepeated", comment: ""))"
        }
        return date
    }
}
