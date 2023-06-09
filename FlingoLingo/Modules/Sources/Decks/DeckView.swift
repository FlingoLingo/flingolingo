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
    private var isCardsEmpty: Bool {
        viewModel.deck.cards.isEmpty
    }
    private var searchResults: [DomainCard] {
        viewModel.text.isEmpty ? viewModel.deck.cards :
        viewModel.deck.cards.filter {
            return $0.eng.lowercased().contains(viewModel.text.lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines))
            || $0.rus.lowercased().contains(viewModel.text.lowercased())
        }
    }

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
                ScrollView(showsIndicators: false) {
                    VStack(spacing: CommonConstants.smallSpacing) {
                        if viewModel.isLoading {
                            ForEach(0...4, id: \.self) { _ in
                                CardSkeletonView()
                            }
                        } else {
                            ForEach(searchResults) { card in
                                WordCardView(card: card,
                                             wordCardClicked: viewModel.wordCardClicked,
                                             deleteWordCard: { viewModel.deleteWordCard(cardId: card.id) })
                            }
                        }
                    }
                }
                ButtonView(buttonText: NSLocalizedString("startButton", comment: ""),
                           buttonClicked: viewModel.startButtonClicked)
                .padding(.bottom, CommonConstants.bottomPadding)
                .disabled(isCardsEmpty)
                .opacity(isCardsEmpty ? 0.5 : 1)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
        .alert("error", isPresented: $viewModel.isShowingError) {
            Button("ok", role: .cancel) { }
        }
        .alert(NSLocalizedString("editDeckName", comment: ""), isPresented: $viewModel.isShowingAlert, actions: {
            TextField(NSLocalizedString("deckNamePh", comment: ""), text: $viewModel.deckName)
            Button(NSLocalizedString("save", comment: ""), action: viewModel.editDeckName)
            Button(NSLocalizedString("cancel", comment: ""), role: .cancel, action: {})
        })
        .onAppear(perform: viewModel.reloadDeck)
        .disabled(viewModel.isLoading)
    }
}
