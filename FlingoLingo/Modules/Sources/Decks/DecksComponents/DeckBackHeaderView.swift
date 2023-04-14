//
//  DeckBackHeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckBackHeaderView: View {

    let deck: Deck
    let backButtonClicked: (() -> Void)
    let editButtonClicked: (() -> Void)

    var body: some View {
        HStack {
            HStack {
                Button(action: backButtonClicked,
                        label: {
                    Icons.leftArrow
                        .foregroundColor(SColors.mainText)
                })
                Text(deck.title)
                    .font(SFonts.subtitle)
                    .foregroundColor(SColors.mainText)
                    .padding(.leading, CommonConstants.smallSpacing)
                Spacer()
                Button(action: editButtonClicked,
                        label: {
                    Icons.pencil
                        .foregroundColor(SColors.mainText)
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
