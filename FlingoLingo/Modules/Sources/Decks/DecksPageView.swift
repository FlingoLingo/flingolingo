//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DecksPageView: View {

    @ObservedObject private var viewModel: DecksViewModel

    init(viewModel: DecksViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            (SColors.background).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                DecksHeaderView(addDeckButtonClicked: viewModel.addDeckButtonCLicked)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: CommonConstants.smallSpacing) {
                        if viewModel.isLoading {
                            ForEach(0...3, id: \.self) { _ in
                                DeckCardSkeleton()
                            }
                        } else {
                            ForEach(viewModel.decks) { deck in
                                DeckCardView(deck: deck) {
                                    viewModel.deckCardClicked(id: deck.id)
                                }
                            }
                        }
                    }
                }
                .padding(.top, CommonConstants.bigSpacing)
            }
            .onAppear(perform: viewModel.reloadDecks)
            .alert("error", isPresented: $viewModel.isShowingError) {
                Button("ok", role: .cancel) { }
            }
            .alert(NSLocalizedString("addDeckTitle", comment: ""), isPresented: $viewModel.isShowingAlert, actions: {
                TextField(NSLocalizedString("deckNamePh", comment: ""), text: $viewModel.newDeckName)
                Button(NSLocalizedString("create", comment: ""), action: viewModel.createDeck)
                Button(NSLocalizedString("cancel", comment: ""), role: .cancel, action: {})
            })
            .padding(.horizontal, CommonConstants.bigSpacing)
            .cornerRadius(CommonConstants.cornerRadius)
        }
        .disabled(viewModel.isLoading)
    }
}
