//
//  DeckCardView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckCardView: View {
    
    var deck: Deck
    var deckCardClicked: (() -> Void)?
    private let formatter: Formatter = .init()
    
    var body: some View {
        Button(action: {
            deckCardClicked?()
        }, label: {
            HStack {
                VStack (alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                    Text(deck.title)
                        .font(Font(Fonts.cardsTitle))
                        .foregroundColor(Color(ColorScheme.mainText))
                    Text(formatter.formatWords(deck: deck))
                        .font(Font(Fonts.mainText))
                        .foregroundColor(Color(ColorScheme.secondaryText))
                    Text(formatter.formatLearnedWords(deck: deck))
                        .font(Font(Fonts.mainText))
                        .foregroundColor(Color(ColorScheme.secondaryText))
                }
                .padding(.trailing, CommonConstants.smallStackSpacing)
                Spacer()
                Icons.rightArrow
                    .foregroundColor(Color(ColorScheme.mainText))
            }
            .frame(maxWidth: .infinity)
            .padding(.all, CommonConstants.smallSpacing)
            .background(Color(ColorScheme.darkBackground))
            .cornerRadius(CommonConstants.cornerRadius)
        })
    }
}
