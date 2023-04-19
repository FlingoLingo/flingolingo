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
    @Published var isShowingError = false
    @Published var isLoading = false

    var deck: DomainDeck
    let provider: DecksProvider
    private let router: CardsRouter
    private let backAction: () -> Void

    init(deck: DomainDeck, provider: DecksProvider, backAction: @escaping () -> Void, router: CardsRouter) {
        self.deck = deck
        self.backAction = backAction
        self.provider = provider
        self.router = router
    }

    func startButtonClicked() {
        router.startLearning(deck: deck)
    }

    func backButtonClicked() {
        backAction()
    }

    func editButtonClicked() {
        deckName = deck.title
        isShowingAlert = true
    }

    func editDeckName() {
        isLoading = true
        provider.editDeck(id: deck.id, newName: deckName, onFinish: { [weak self] result in
            switch result {
            case .success(let deck):
                self?.deck = DomainDeck(deckResponse: deck)
            case .failure:
                self?.isShowingError = true
            }
            self?.isLoading = false
        })
    }

    func wordCardClicked() {

    }

    func reloadDeck() {
        isLoading = true
        provider.getDeck(id: deck.id, onFinish: { [weak self] result in
            switch result {
            case .success(let deck):
                self?.deck = DomainDeck(deckResponse: deck)
            case .failure:
                self?.isShowingError = true
            }
            self?.isLoading = false
        })
    }

    func deleteDeck() {
        isLoading = true
        provider.deleteDeck(id: deck.id, onFinish: { [weak self] result in
            switch result {
            case .success:
                self?.backAction()
            case .failure:
                self?.isShowingError = true
            }
            self?.isLoading = false
        })
    }

    func deleteWordCard(cardId: Int) {
        isLoading = true
        provider.deleteCardFromDeck(deckId: deck.id, carId: cardId, onFinish: { [weak self] result in
            switch result {
            case .success:
                self?.reloadDeck()
            case .failure:
                self?.isShowingError = true
            }
        })
    }
}
