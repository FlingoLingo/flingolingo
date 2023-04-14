//
//  WordsScrollView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//



import SwiftUI
import UIComponents

struct WordsScrollView: View {
    
    var body: some View {
        ScrollView {
            VStack (spacing: CommonConstants.smallSpacing) {
                ForEach (1..<5) { i in
                    WordCardView()
                }
            }
        }
    }
}
