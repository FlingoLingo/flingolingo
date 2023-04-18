//
//  DeckCardView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckCardView: View {

    private let deck: Deck
    private let deckCardClicked: (() -> Void)
    private let formatter: DeckFormatter = .init()
    private var progress: Double {
        Double(deck.learnedWords) / Double(deck.wordsCount)
    }

    init(deck: Deck, deckCardClicked: @escaping () -> Void) {
        self.deck = deck
        self.deckCardClicked = deckCardClicked
    }

    var body: some View {
        Button(action: deckCardClicked) {
            HStack {
                VStack(alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                    Text(deck.title)
                        .font(SFonts.cardsTitle)
                        .foregroundColor(SColors.mainText)
                    Text(formatter.formatWords(deck: deck))
                        .font(SFonts.mainText)
                        .foregroundColor(SColors.secondaryText)
                    Text(formatter.formatLearnedWords(deck: deck))
                        .font(SFonts.mainText)
                        .foregroundColor(SColors.secondaryText)
                    ProgressView(value: progress)
                        .padding(.top, CommonConstants.smallStackSpacing)
                        .tint(SColors.accent)
                }
                .padding(.trailing, CommonConstants.smallStackSpacing)
                Spacer()
                Icons.rightArrow
                    .foregroundColor(SColors.mainText)
            }
            .frame(maxWidth: .infinity)
            .padding([.vertical, .leading], CommonConstants.smallSpacing)
            .padding(.trailing, CommonConstants.bigSpacing)
            .background(SColors.darkBackground)
            .cornerRadius(CommonConstants.cornerRadius)
        }
    }
}
