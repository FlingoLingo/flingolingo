//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckView: View {

    @State private var text: String = ""
    private let viewModel = DeckViewModel()
    var deck: Deck

    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack(spacing: CommonConstants.bigSpacing) {
                DeckBackHeaderView(deck: deck,
                                   backButtonClicked: viewModel.backButtonClicked,
                                   editButtonClicked: viewModel.editButtonClicked)
                DeckInfoView(deck: deck)
                SearchView(text: $text)
                ScrollView {
                    VStack(spacing: CommonConstants.smallSpacing) {
                        ForEach(deck.cards) { card in
                            WordCardView(card: card) {
                                viewModel.wordCardClicked()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
            VStack {
                Spacer()
                ButtonView(buttonText: NSLocalizedString("startButton", comment: ""),
                           buttonClicked: viewModel.startButtonClicked)
                .padding(.bottom, CommonConstants.bottomPadding)
                .padding(.horizontal, CommonConstants.bigSpacing)
            }
        }
    }
}

struct DeckViewPr: PreviewProvider {
    static var previews: some View {
        DeckView(deck: Deck(
            id: 1,
            title: "Для путешествий",
            wordsCount: 27,
            learnedWords: 12,
            repetitionDate: Date.now,
            cards: Array(repeating: Card(id: 1, eng: "apple", rus: "яблоко", examples: []), count: 4)))
    }
}
