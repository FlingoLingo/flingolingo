//
//  DeckView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents


struct DecksPageView: View {
    // MARK: - Constants
    enum Constants {
        static let cornerRadius: CGFloat = 19
        static let mainSpacing: CGFloat = 25
        static let stackSpacing: CGFloat = 5
    }
    
    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading, spacing: Constants.stackSpacing) {
                HeaderView()
                DecksScrollView()
                    .padding(.top, Constants.mainSpacing)
            }
            .padding(.horizontal, Constants.mainSpacing)
            .cornerRadius(Constants.cornerRadius)
            
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
