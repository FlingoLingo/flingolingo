//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public final class DecksViewModel: ObservableObject {

    @Published var decks: [DomainDeck] = []
    @Published var isLoading = true
    @Published var isShowingAlert = false
    @Published var isShowingError = false
    @Published var newDeckName = ""

    private let provider: DecksProvider
    private let router: DecksRouter

    private let defaults = UserDefaults.standard

    init(router: DecksRouter, provider: DecksProvider) {
        self.router = router
        self.provider = provider

        reloadDecks()
    }

    func reloadDecks() {
        provider.getAllDecks { [weak self] result in
            switch result {
            case .success(let decks):
                self?.decks = decks
                self?.saveAllWordsLearned()
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
        newDeckName = ""
        isShowingAlert = true
    }

    func createDeck() {
        isLoading = true
        provider.createNewDeck(name: newDeckName, onFinish: { [weak self] result in
            switch result {
            case .success(let deck):
                self?.decks.append(deck)
                self?.saveAllWordsLearned()
            case .failure:
                self?.isShowingError = true
            }
            self?.isLoading = false
        })
    }

    func saveAllWordsLearned() {
        var wordsCount = 0
        var decksCount = 0
        for elem in decks {
            decksCount += 1
            let cardsIdsFromUserDefaults = UserDefaults.standard.stringArray(forKey: "\(elem.id)") ?? []
            wordsCount += cardsIdsFromUserDefaults.count
        }

        defaults.set(wordsCount, forKey: "wordsLearned")
        defaults.set(decksCount, forKey: "decksCount")
    }
}
