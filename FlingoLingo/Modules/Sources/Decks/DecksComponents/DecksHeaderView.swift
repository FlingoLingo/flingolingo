//
//  HeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DecksHeaderView: View {

    private let viewModel = DecksHeaderViewModel()

    var body: some View {
        HStack {
            Text(NSLocalizedString("decksHeader", comment: ""))
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
