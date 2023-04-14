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
    var deckCardClicked: (() -> Void)
    private let formatter: Formatter = .init()
    
    var body: some View {
        Button(action: deckCardClicked,
               label: {
            HStack {
                VStack (alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                    Text(deck.title)
                        .font(SFonts.cardsTitle)
                        .foregroundColor(SColors.mainText)
                    Text(formatter.formatWords(deck: deck))
                        .font(SFonts.mainText)
                        .foregroundColor(SColors.secondaryText)
                    Text(formatter.formatLearnedWords(deck: deck))
                        .font(SFonts.mainText)
                        .foregroundColor(SColors.secondaryText)
                }
                .padding(.trailing, CommonConstants.smallStackSpacing)
                Spacer()
                Icons.rightArrow
                    .foregroundColor(SColors.mainText)
            }
            .frame(maxWidth: .infinity)
            .padding(.all, CommonConstants.smallSpacing)
            .background(SColors.darkBackground)
            .cornerRadius(CommonConstants.cornerRadius)
        })
    }
}
