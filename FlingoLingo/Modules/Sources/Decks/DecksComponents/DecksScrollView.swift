//
//  DecksScrollView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI

struct DecksScrollView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach (1..<5) { i in
                    DeckCardView()
                }
            }
        }
    }
}
