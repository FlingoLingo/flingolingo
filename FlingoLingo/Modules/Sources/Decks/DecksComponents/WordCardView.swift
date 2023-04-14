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
    var wordCardClicked: (() -> Void)
    
    var body: some View {
        Button(action: wordCardClicked?,
               label: {
            HStack {
                VStack (alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                    Text(card.eng)
                        .font(SFonts.cardsTitle)
                        .foregroundColor(SColors.mainText)
                    Text(card.rus)
                        .font(SFonts.cardsText)
                        .foregroundColor(SColors.secondaryText)
                }
                .padding(.trailing, CommonConstants.smallSpacing)
                Spacer()
                Button(action: wordCardClicked,
                       label: {
                    Icons.xmark
                        .foregroundColor(SColors.mainText)
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, CommonConstants.smallSpacing)
            .background(SColors.darkBackground)
            .cornerRadius(CommonConstants.cornerRadius)
        })
    }
}
