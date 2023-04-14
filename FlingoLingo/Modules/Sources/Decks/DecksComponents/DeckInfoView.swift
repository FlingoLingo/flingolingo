//
//  DeckInfoView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckInfoView: View {
    
    var deck: Deck
    private let formatter: Formatter = .init()
    
    public var body: some View {
        VStack(alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
            Text(formatter.formatWords(deck: deck))
                .font(SFonts.mainText)
                .foregroundColor(SColors.mainText)
            Text(formatter.formatLearnedWords(deck: deck))
                .font(SFonts.mainText)
                .foregroundColor(SColors.mainText)
            Text(formatter.formatDate(deck: deck))
                .font(SFonts.mainText)
                .foregroundColor(SColors.mainText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, CommonConstants.smallSpacing)
        .background(SColors.darkBackground)
        .cornerRadius(CommonConstants.cornerRadius)
    }
}
