//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckView: View {

    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack (spacing: CommonConstants.bigSpacing) {
                DeckBackHeaderView()
                DeckInfoView()
                SearchView(text: $text)
                WordsScrollView()
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
            VStack {
                Spacer()
                ButtonView()
                    .padding(.bottom, CommonConstants.bottomPadding)
                    .padding(.horizontal, CommonConstants.bigSpacing)
            }
        }
    }
}

struct DeckViewPr: PreviewProvider {
    static var previews: some View {
        DeckView()
    }
}
