//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DecksPageView: View {
    
    @StateObject private var viewModel = DecksViewModel(decks: Array(repeating: Deck(id: 1, title: "Для путешествий", wordsCount: 100, learnedWords: 32, repetitionDate: Date.now, cards: []), count: 5))
    
    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                DecksHeaderView()
                ScrollView {
                    VStack(spacing: CommonConstants.smallSpacing) {
                        ForEach (viewModel.decks) { deck in
                            DeckCardView(deck: deck) {
                                viewModel.deckCardCLicked(id: deck.id)
                            }
                        }
                    }
                }
                .padding(.top, CommonConstants.bigSpacing)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
            .cornerRadius(CommonConstants.cornerRadius)
        }
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        DecksPageView()
    }
}
