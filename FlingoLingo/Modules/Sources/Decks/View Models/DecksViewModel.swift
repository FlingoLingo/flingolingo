//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public final class DecksViewModel: ObservableObject {

    @Published var decks: [Deck] = []
    @Published var isLoading = true
    @Published var isShowingAlert = false
    @Published var isShowingError = false
    @Published var newDeckName = ""

    let provider: DecksProvider
    private let router: DecksRouter

    init(router: DecksRouter, provider: DecksProvider) {
        self.router = router
        self.provider = provider

        provider.getAllDecks { [weak self] result in
            switch result {
            case .success(let decks):
                self?.decks = decks
            case .failure:
                self?.isShowingError = true
            }
            self?.isLoading = false
        }
    }

    func deckCardClicked(id: Int) {
        guard let deck = decks.first(where: { $0.id == id }) else {
            return
        }
        router.viewDetails(deck: deck, provider: provider)
    }

    func addDeckButtonCLicked() {
        isShowingAlert = true
    }

    func createDeck() {
        isLoading = true
        provider.createNewDeck(name: newDeckName, onFinish: { [weak self] result in
            switch result {
            case .success(let deck):
                self?.decks.append(deck)
            case .failure:
                self?.isShowingError = true
            }
            self?.isLoading = false
        })
    }
}
