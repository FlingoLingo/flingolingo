//
//  HeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct HeaderView: View {
    // MARK: - Constants
    enum Constants {
        static let headerName: String = "Колоды"
    }
        
    var body: some View {
        HStack {
            Text(Constants.headerName)
                .font(Font(Fonts.largeTitle))
                .foregroundColor(Color(ColorScheme.mainText))
            Spacer()
            Button (action: {
                // TODO: add action
            }, label: {
                Icons.plus
                    .foregroundColor(Color(ColorScheme.mainText))
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
