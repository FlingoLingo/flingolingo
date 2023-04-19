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

    var deck: Deck
    let provider: DecksProvider
    private let router: CardsRouter
    private let backAction: () -> Void

    init(deck: Deck, provider: DecksProvider, backAction: @escaping () -> Void, router: CardsRouter) {
        self.deck = deck
        self.backAction = backAction
        self.provider = provider
        elf.router = router
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
        provider.editDeck(id: deck.id, newName: deckName, onFinish: { [weak self] result in
            switch result {
            case .success(let deck):
                self?.deck = deck
            case .failure:
                self?.isShowingError = true
            }
        })
    }

    func wordCardClicked() {

    }

    func reloadDeck() {
        provider.getDeck(id: deck.id, onFinish: { [weak self] result in
            switch result {
            case .success(let deck):
                self?.deck = deck
            case .failure:
                self?.isShowingError = true
            }
        })
    }

    func deleteDeck() {
        provider.deleteDeck(id: deck.id, onFinish: { [weak self] result in
            switch result {
            case .success:
                self?.backAction()
            case .failure:
                self?.isShowingError = true
            }
        })
    }

    func deleteWordCard(cardId: Int) {
        provider.deleteCardFromDeck(deckId: deck.id, carId: cardId, onFinish: { [weak self] isSuccess in
            if isSuccess {
                self?.reloadDeck()
            } else {
                self?.isShowingError = true
            }
        })
    }
}
