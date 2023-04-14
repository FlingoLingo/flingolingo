//
//  WordCardView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct WordCardView: View {
    
    var card: Card
    var wordCardClicked: (() -> Void)?
    
    var body: some View {
        Button(action: {
            wordCardClicked?()
        }, label: {
            HStack {
                VStack (alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                    Text(card.eng)
                        .font(Font(Fonts.cardsTitle))
                        .foregroundColor(Color(ColorScheme.mainText))
                    Text(card.rus)
                        .font(Font(Fonts.cardsText))
                        .foregroundColor(Color(ColorScheme.secondaryText))
                }
                .padding(.trailing, CommonConstants.smallSpacing)
                Spacer()
                Button(action: {
                    wordCardClicked?()
                }, label: {
                    Icons.xmark
                        .foregroundColor(Color(ColorScheme.mainText))
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, CommonConstants.smallSpacing)
            .background(Color(ColorScheme.darkBackground))
            .cornerRadius(CommonConstants.cornerRadius)
        })
    }
}
