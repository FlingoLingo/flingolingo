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
    @State private var isShowingContextMenu = false

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
            .alert(NSLocalizedString("addDeckTitle", comment: ""), isPresented: $viewModel.isShowingAlert, actions: {
                TextField(NSLocalizedString("deckNamePh", comment: ""), text: $viewModel.newDeckName)
                Button(NSLocalizedString("create", comment: ""), action: viewModel.createDeck)
                Button(NSLocalizedString("cancel", comment: ""), role: .cancel, action: {})
            })
            .padding(.horizontal, CommonConstants.bigSpacing)
            .cornerRadius(CommonConstants.cornerRadius)
        }
    }
}
