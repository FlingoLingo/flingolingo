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
        static let word: String = "apple"
        static let translation: String = "яблоко"
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                Text(Constants.word)
                    .font(Font(Fonts.cardsTitle))
                    .foregroundColor(Color(ColorScheme.mainText))
                Text(Constants.translation)
                    .font(Font(Fonts.cardsText))
                    .foregroundColor(Color(ColorScheme.secondaryText))
            }
            .padding(.trailing, CommonConstants.smallSpacing)
            Spacer()
            Button(action: {
                // TODO: add action
            }, label: {
                Icons.xmark
                    .foregroundColor(Color(ColorScheme.mainText))
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, CommonConstants.smallSpacing)
        .background(Color(ColorScheme.darkBackground))
        .cornerRadius(CommonConstants.cornerRadius)
    }
}
