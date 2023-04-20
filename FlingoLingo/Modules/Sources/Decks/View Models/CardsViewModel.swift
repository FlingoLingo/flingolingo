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
    @Published var fetchedCards: [DomainCard] = []
    @Published var displayingCards: [DomainCard] = []
    private let deck: DomainDeck
    private let backAction: () -> Void
    private let popToRootAction: () -> Void
    var subscription: AnyCancellable?
    var results: [Int: CardSwipeDirection] = [:]
    private let provider: DecksProvider

    let notificationSubject: PassthroughSubject<CardSwipeInfo, Never> = .init()

    init(
        deck: DomainDeck,
        provider: DecksProvider,
        backAction: @escaping () -> Void,
        popToRootAction: @escaping () -> Void
    ) {
        self.deck = deck
        self.backAction = backAction
        self.popToRootAction = popToRootAction
        self.provider = provider
        fetchedCards = deck.cards
        displayingCards = fetchedCards

        subscription = $displayingCards.sink { [weak self] cards in
            guard let self = self else { return }
            if cards.count == 0 {
                let deckId = self.deck.id
                let cardIdWithDirection = self.results
                provider.setStatistics(deckId: deckId, cardIdWithDirection: cardIdWithDirection)
            }
        }
    }

    func getIndex(card: DomainCard) -> Int {
        let index = displayingCards.firstIndex(where: { currentCard in
            return card.id == currentCard.id
        }) ?? 0

        return index
    }

    func backButtonClicked() {
        backAction()

        let deckId = deck.id
        let cardIdWithDirection = results
        provider.setStatistics(deckId: deckId, cardIdWithDirection: cardIdWithDirection)
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
