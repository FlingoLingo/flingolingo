//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DecksPageView: View {

    private let viewModel: DecksViewModel

    init(viewModel: DecksViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            (SColors.background).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                DecksHeaderView(addDeckButtonClicked: viewModel.addDeckButtonCLicked)
                ScrollView {
                    VStack(spacing: CommonConstants.smallSpacing) {
                        ForEach(viewModel.decks) { deck in
                            DeckCardView(deck: deck) {
                                viewModel.deckCardClicked(id: deck.id)
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
    static let viewModel = {
        let viewModel = DecksViewModel()
        viewModel.decks = Array(repeating: Deck(id: 1,
                                                title: "Для путешествий",
                                                wordsCount: 100,
                                                learnedWords: 32,
                                                repetitionDate: Date.now,
                                                cards: []),
                                count: 5)
        return viewModel
    }()

    static var previews: some View {
        DecksPageView(viewModel: viewModel)
    }
}
