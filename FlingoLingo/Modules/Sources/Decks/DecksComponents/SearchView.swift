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
    @Binding var text: String

    private var borderColor: Color {
        text.isEmpty ? SColors.inactive : SColors.mainText
    }

    var body: some View {
        HStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(NSLocalizedString("searchWordInDeckPlaceholder", comment: ""))
                        .font(SFonts.searchText)
                        .foregroundColor(SColors.inactive)
                }
                .foregroundColor(SColors.mainText)
            Spacer()
            if !text.isEmpty {
                Button(action: {
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
