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
                                   editButtonClicked: viewModel.editButtonClicked,
                                   deleteButtonClicked: viewModel.deleteDeck)
                DeckInfoView(deck: viewModel.deck)
                SearchView(text: $viewModel.text)
                if viewModel.isLoading {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(SColors.mainText)
                        Spacer()
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: CommonConstants.smallSpacing) {
                            ForEach(viewModel.deck.cards) { card in
                                WordCardView(card: card,
                                             wordCardClicked: { viewModel.wordCardClicked() },
                                             deleteWordCard: { viewModel.deleteWordCard(cardId: card.id) })
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
            .alert("error", isPresented: $viewModel.isShowingError) {
                Button("ok", role: .cancel) { }
            }
            .onAppear(perform: viewModel.reloadDeck)
        }
    }
}
