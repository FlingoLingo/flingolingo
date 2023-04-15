//
//  HeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DecksHeaderView: View {

    private let addDeckButtonClicked: (() -> Void)

    init(addDeckButtonClicked: @escaping () -> Void) {
        self.addDeckButtonClicked = addDeckButtonClicked
    }

    var body: some View {
        HStack {
            Text("decksHeader")
                .font(SFonts.largeTitle)
                .foregroundColor(SColors.mainText)
            Spacer()
            Button(action: addDeckButtonClicked) {
                Icons.plus
                    .foregroundColor(SColors.mainText)
            }
        }
    }
}
