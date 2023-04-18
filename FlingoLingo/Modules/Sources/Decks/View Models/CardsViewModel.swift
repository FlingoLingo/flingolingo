//
//  CardsViewModel.swift
//  Cards
//
//  Created by Alexander Muratov on 4/18/23.
//

import Foundation

class CardsViewModel: ObservableObject {
    @Published var progress: Double = 0
    @Published var fetchedCards: [Card] = []
    @Published var displayingCards: [Card] = []
    let deck: Deck
    private let backAction: () -> Void
    private let popToRootAction: () -> Void

    init(deck: Deck, backAction: @escaping () -> Void, popToRootAction: @escaping () -> Void) {
        self.deck = deck
        self.backAction = backAction
        self.popToRootAction = popToRootAction
        fetchedCards = deck.cards
        displayingCards = fetchedCards
    }

    func getIndex(card: Card) -> Int {
        let index = displayingCards.firstIndex(where: { currentCard in
            return card.id == currentCard.id
        }) ?? 0

        return index
    }

    func getCardsCount() -> Int {
        return fetchedCards.count
    }

    func backButtonClicked() {
        backAction()
    }

    func backToDecksButtonClicked() {
        popToRootAction()
    }
}
