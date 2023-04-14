//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents


struct DecksPageView: View {
    
    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
                HeaderView()
                DecksScrollView()
                    .padding(.top, CommonConstants.bigSpacing)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
            .cornerRadius(CommonConstants.cornerRadius)
        }
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        DeckCardView()
        DecksPageView()
        HeaderView()
        DecksScrollView()
        DeckView()
    }
}
