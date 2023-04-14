//
//  DeckBackHeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckBackHeaderView: View {
    
    var deck: Deck
    var backButtonClicked: (() -> Void)?
    var editButtonClicked: (() -> Void)?
    
    var body: some View {
        HStack {
            HStack {
                Button (action: {
                    backButtonClicked?()
                }, label: {
                    Icons.leftArrow
                        .foregroundColor(Color(ColorScheme.mainText))
                })
                Text(deck.title)
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(Color(ColorScheme.mainText))
                    .padding(.leading, CommonConstants.smallSpacing)
                Spacer()
                Button (action: {
                    editButtonClicked?()
                }, label: {
                    Icons.pencil
                        .foregroundColor(Color(ColorScheme.mainText))
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
