//
//  SearchView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct SearchView: View {
    // MARK: - Properties
    @Binding private var text: String
    @FocusState private var fieldIsFocused: Bool

    private var borderColor: Color {
        text.isEmpty ? SColors.inactive : SColors.mainText
    }

    init(text: Binding<String>) {
        self._text = text
    }

    var body: some View {
        HStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text("searchWordInDeckPlaceholder")
                        .font(SFonts.searchText)
                        .foregroundColor(SColors.inactive)
                }
                .foregroundColor(SColors.mainText)
                .focused($fieldIsFocused)
            Spacer()
            if !text.isEmpty {
                Button(action: {
                    fieldIsFocused = false
                    text = ""
                }, label: {
                    Icons.xmark
                        .foregroundColor(SColors.mainText)
                })
            }
        }
        .padding(.all, CommonConstants.smallSpacing)
        .overlay(
            RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(borderColor, lineWidth: 1)
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
