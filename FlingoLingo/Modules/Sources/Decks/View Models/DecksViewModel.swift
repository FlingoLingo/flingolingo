//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public final class DecksViewModel: ObservableObject {

    @Published var decks: [Deck] = [.init(id: 1, title: "adfgiuawf", wordsCount: 3, learnedWords: 0, repetitionDate: Date.now, cards: [.init(id: 1, eng: "apple", rus: "яблоко", examples: []),
                                                                                                                                       .init(id: 2, eng: "cucumber", rus: "огурец", examples: [])])]
    @Published var isShowingAlert = false
    @Published var newDeckName = ""

    private let router: DecksRouter

    init(router: DecksRouter) {
        self.router = router
    }

    func deckCardClicked(id: Int) {
        guard let deck = decks.first(where: { $0.id == id }) else {
            return
        }
        router.viewDetails(deck: deck)
    }

    func addDeckButtonCLicked() {
        isShowingAlert = true
    }

    func createDeck() {

    }
}
