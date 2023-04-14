//
//  SearchView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct SearchView: View {
    // MARK: - Constants
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let placeholder: String = "Найти слово в колоде..."
    }
    
    // MARK: - Properties
    @Binding var text: String
    
    private var isTextEmpty: Color {
        text.isEmpty ? Color(ColorScheme.inactive) : Color(ColorScheme.mainText)
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(Constants.placeholder)
                        .font(Font(Fonts.searchText))
                        .foregroundColor(Color(ColorScheme.inactive))
                }
                .foregroundColor(Color(ColorScheme.mainText))
            Spacer()
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }, label: {
                    Icons.xmark
                        .foregroundColor(Color(ColorScheme.mainText))
                })
            }
            
        }
        .padding(.all, CommonConstants.smallSpacing)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(isTextEmpty, lineWidth: 1)
        )
    }
}

private extension View {
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
