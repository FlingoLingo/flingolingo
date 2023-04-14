//
//  HeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DecksHeaderView: View {
    // MARK: - Constants
    enum Constants {
        static let headerName: String = "Колоды"
    }

    private let viewModel = DecksHeaderViewModel()

    var body: some View {
        HStack {
            Text(Constants.headerName)
                .font(SFonts.largeTitle)
                .foregroundColor(SColors.mainText)
            Spacer()
            Button(action: {
                viewModel.addDeckButtonClicked()
            }, label: {
                Icons.plus
                    .foregroundColor(SColors.mainText)
            })
        }
    }
}
