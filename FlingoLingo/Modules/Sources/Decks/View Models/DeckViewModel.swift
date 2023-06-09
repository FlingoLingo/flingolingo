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
        router.startLearning(deck: deck, provider: provider)
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
                self?.deck = deck
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
                self?.deck = deck
            case .failure:
                self?.isShowingError = true
            }
            self?.isLoading = false
        })
    }

    func deleteDeck() {
        isLoading = true
        provider.deleteDeck(id: deck.id, onFinish: { [weak self] success in
            if success {
                self?.backAction()
            } else {
                self?.isShowingError = true
            }
            self?.isLoading = false
        })
    }

    func deleteWordCard(cardId: Int) {
        isLoading = true
        provider.deleteCardFromDeck(deckId: deck.id, carId: cardId, onFinish: { [weak self] success in
            if success {
                self?.reloadDeck()
            } else {
                self?.isShowingError = true
            }
        })
        removeCardIdFromUserDefaults(cardId: cardId)
    }

    private func removeCardIdFromUserDefaults(cardId: Int) {
        var cardIds = UserDefaults.standard.stringArray(forKey: "\(deck.id)")
        cardIds = cardIds?.filter { $0 != "\(cardId)" }
        UserDefaults.standard.set(cardIds, forKey: "\(deck.id)")
    }
}
