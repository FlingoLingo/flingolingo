//
//  DeckBackHeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents


struct DeckBackHeaderView: View {
    // MARK: - Constants
    enum Constants {
        static let headerName: String = "Для путешествий"
        static let smallSpacing: CGFloat = 15
    }
    
    var body: some View {
        HStack {
            HStack {
                Button (action: {
                    // TODO: add action
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(ColorScheme.mainText))
                })
                Text(Constants.headerName)
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(Color(ColorScheme.mainText))
                    .padding(.leading, Constants.smallSpacing)
                Spacer()
                Button (action: {
                    // TODO: add action
                }, label: {
                    Image(systemName: "pencil")
                        .foregroundColor(Color(ColorScheme.mainText))
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
