//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation
import SwiftUI

final class DeckViewModel: ObservableObject {

    @Published var text = ""
    @Published var deckName = ""
    @Published var isShowingAlert = false

    let deck: Deck
    private let backAction: () -> Void

    init(deck: Deck, backAction: @escaping () -> Void) {
        self.deck = deck
        self.backAction = backAction
    }

    func startButtonClicked() {

    }

    func backButtonClicked() {
        backAction()
    }

    func editButtonClicked() {
        deckName = deck.title
        isShowingAlert = true
    }

    func editDeckName() {

    }

    func wordCardClicked() {

    }

    func deleteDeck() {
        backAction()
    }
}
