//
//  WordCardView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct WordCardView: View {
    // MARK: - Constants
    enum Constants {
        static let mainSpacing: CGFloat = 25
        static let smallSpacing: CGFloat = 15
        static let cornerRadius: CGFloat = 19
        static let word: String = "apple"
        static let translation: String = "яблоко"
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 5) {
                Text(Constants.word)
                    .font(Font(Fonts.cardsTitle))
                    .foregroundColor(Color(ColorScheme.mainText))
                Text(Constants.translation)
                    .font(Font(Fonts.cardsText))
                    .foregroundColor(Color(ColorScheme.secondaryText))
            }
            .padding(.trailing, Constants.smallSpacing)
            Spacer()
            Image(systemName: "xmark")
                .foregroundColor(Color(ColorScheme.mainText))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, Constants.smallSpacing)
        .background(Color(ColorScheme.darkBackground))
        .cornerRadius(Constants.cornerRadius)
    }
}
