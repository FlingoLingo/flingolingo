//
//  CardsViewModel.swift
//  Cards
//
//  Created by Alexander Muratov on 4/18/23.
//

import Foundation
import Combine

struct CardSwipeInfo {
    let id: Int
    let direction: CardSwipeDirection
}

final class CardsViewModel: ObservableObject {
    @Published var progress: Double = 0
    @Published var fetchedCards: [Card] = []
    @Published var displayingCards: [Card] = []
    private let deck: Deck
    private let backAction: () -> Void
    private let popToRootAction: () -> Void
    var subscription: AnyCancellable?
    var results: [Int: CardSwipeDirection] = [:]

    let notificationSubject: PassthroughSubject<CardSwipeInfo, Never> = .init()

    init(deck: Deck, backAction: @escaping () -> Void, popToRootAction: @escaping () -> Void) {
        self.deck = deck
        self.backAction = backAction
        self.popToRootAction = popToRootAction
        fetchedCards = deck.cards
        displayingCards = fetchedCards

        subscription = $displayingCards.sink { cards in
            if cards.count == 0 {}
        }
    }

    func getIndex(card: Card) -> Int {
        let index = displayingCards.firstIndex(where: { currentCard in
            return card.id == currentCard.id
        }) ?? 0

        return index
    }

    func backButtonClicked() {
        backAction()
    }

    func backToDecksButtonClicked() {
        popToRootAction()
    }

    func changeCardsMainSide() {}

    func doSwipe(withInfo cardsSwipeInfo: CardSwipeInfo) {
        progress += 1
        notificationSubject.send(cardsSwipeInfo)

        results[cardsSwipeInfo.id] = cardsSwipeInfo.direction
    }

    func removeFirst() {
        displayingCards.removeFirst()
    }
}