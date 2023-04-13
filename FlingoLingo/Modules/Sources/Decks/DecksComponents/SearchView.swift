//
//  SearchView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct SearchView: View {
    // MARK: - Constants
    enum Constants {
        static let mainSpacing: CGFloat = 25
        static let smallSpacing: CGFloat = 15
        static let cornerRadius: CGFloat = 10
        static let deckInfo: String = "Всего слов: 3\nИзучено слов: 2\nПоследний раз повторяли : 10.04.2023"
    }
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text("Найти слово в колоде...")
                        .font(Font(Fonts.searchText))
                        .foregroundColor(Color(ColorScheme.inactive))
                }
                .foregroundColor(Color(ColorScheme.mainText))
            Spacer()
            Button(action: {
                text = ""
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(text.isEmpty ? Color(ColorScheme.inactive) : Color(ColorScheme.mainText))
            })
            .disabled(text.isEmpty)
            
        }
        .padding(.all, Constants.smallSpacing)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(Color(ColorScheme.inactive), lineWidth: 1)
        )
    }
}


