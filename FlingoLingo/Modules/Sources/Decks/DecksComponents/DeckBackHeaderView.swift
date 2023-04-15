//
//  DeckBackHeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckBackHeaderView: View {

    private let deck: Deck
    private let backButtonClicked: (() -> Void)
    private let editButtonClicked: (() -> Void)

    init(deck: Deck, backButtonClicked: @escaping () -> Void, editButtonClicked: @escaping () -> Void) {
        self.deck = deck
        self.backButtonClicked = backButtonClicked
        self.editButtonClicked = editButtonClicked
    }

    var body: some View {
        HStack {
            HStack {
                Button(action: backButtonClicked) {
                    Icons.leftArrow
                        .foregroundColor(SColors.mainText)
                }
                Text(deck.title)
                    .font(SFonts.subtitle)
                    .foregroundColor(SColors.mainText)
                    .padding(.leading, CommonConstants.smallSpacing)
                Spacer()
                Button(action: editButtonClicked) {
                    Icons.pencil
                        .foregroundColor(SColors.mainText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
