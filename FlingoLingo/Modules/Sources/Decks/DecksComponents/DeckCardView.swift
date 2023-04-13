//
//  DeckCardView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckCardView: View {
    // MARK: - Constants
    enum Constants {
        static let mainSpacing: CGFloat = 25
        static let smallSpacing: CGFloat = 15
        static let cornerRadius: CGFloat = 19
        static let deckName: String = "Колода для путешествий по миру"
        static let deckCardsNumber: String = "78 cлов"
        static let deckComplition: String = "Выучено: 68 из 78"
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 5) {
                Text(Constants.deckName)
                    .font(Font(Fonts.cardsTitle))
                    .foregroundColor(Color(ColorScheme.mainText))
                Text(Constants.deckCardsNumber)
                    .font(Font(Fonts.cardsText))
                    .foregroundColor(Color(ColorScheme.secondaryText))
                Text(Constants.deckComplition)
                    .font(Font(Fonts.cardsText))
                    .foregroundColor(Color(ColorScheme.secondaryText))
            }
            .padding(.trailing, Constants.smallSpacing)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(ColorScheme.mainText))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, Constants.smallSpacing)
        .background(Color(ColorScheme.darkBackground))
        .cornerRadius(Constants.cornerRadius)
    }
}



