//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckView: View {

    @ObservedObject private var viewModel: DeckViewModel

    init(viewModel: DeckViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            (SColors.background).edgesIgnoringSafeArea(.all)
            VStack(spacing: CommonConstants.bigSpacing) {
                DeckBackHeaderView(title: viewModel.deck.title,
                                   backButtonClicked: viewModel.backButtonClicked,
                                   editButtonClicked: viewModel.editButtonClicked)
                DeckInfoView(deck: viewModel.deck)
                SearchView(text: $viewModel.text)
                ScrollView {
                    VStack(spacing: CommonConstants.smallSpacing) {
                        ForEach(viewModel.deck.cards) { card in
                            WordCardView(card: card) {
                                viewModel.wordCardClicked()
                            }
                        }
                    }
                }
            }
            .alert(NSLocalizedString("editDeckName", comment: ""), isPresented: $viewModel.isShowingAlert, actions: {
                TextField(NSLocalizedString("deckNamePh", comment: ""), text: $viewModel.deckName)
                Button(NSLocalizedString("save", comment: ""), action: viewModel.editDeckName)
                Button(NSLocalizedString("cancel", comment: ""), role: .cancel, action: {})
            })
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
