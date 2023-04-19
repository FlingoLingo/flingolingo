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
                if viewModel.isLoading {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(SColors.mainText)
                            .scaleEffect(1.5)
                        Spacer()
                    }
                    Spacer()
                } else {
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
