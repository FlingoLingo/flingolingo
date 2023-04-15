//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 14.04.2023.
//

import Foundation
import SwiftUI

final class DeckViewModel: ObservableObject {

    @Published var text: String = ""
    let deck: Deck

    init(deck: Deck) {
        self.deck = deck
    }

    func startButtonClicked() {

    }

    func backButtonClicked() {

    }

    func editButtonClicked() {

    }

    func wordCardClicked() {

    }
}
