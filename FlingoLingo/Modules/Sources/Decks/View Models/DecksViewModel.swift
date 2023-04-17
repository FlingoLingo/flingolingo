//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation

public final class DecksViewModel: ObservableObject {

    @Published var decks: [Deck] = []
    private let router: DecksRouter

    init(router: DecksRouter) {
        self.router = router
    }

    func deckCardClicked(id: Int) {
        guard let deck = decks.first(where: { $0.id == id}) else {
            return
        }
        router.viewDetails(deck: deck)
    }

    func addDeckButtonCLicked() {

    }
}
