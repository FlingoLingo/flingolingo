//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckView: View {
    // MARK: - Constants
    enum Constants {
        static let mainSpacing: CGFloat = 25
        static let bottomPadding: CGFloat = 40
        static let deckInfo: String = "Всего слов: 3\nИзучено слов: 2\nПоследний раз повторяли : 10.04.2023"
    }
    
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack (spacing: Constants.mainSpacing) {
                DeckBackHeaderView()
                Text(Constants.deckInfo)
                    .font(Font(Fonts.mainText))
                    .foregroundColor(Color(ColorScheme.mainText))
                    .frame(maxWidth: .infinity, alignment: .leading)
                SearchView(text: $text)
                WordsScrollView()
            }
            .padding(.horizontal, Constants.mainSpacing)
            VStack {
                Spacer()
                ButtonView()
                    .padding(.bottom, Constants.bottomPadding)
                    .padding(.horizontal, Constants.mainSpacing)
            }
        }
    }
}

struct DeckViewPr: PreviewProvider {
    static var previews: some View {
        DeckView()
    }
}
