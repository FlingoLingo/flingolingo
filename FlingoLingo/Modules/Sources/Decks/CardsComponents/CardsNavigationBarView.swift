//
//  CardsNavigationBarView.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import SwiftUI
import UIComponents

struct CardsNavigationBarView: View {
    @ObservedObject private var viewModel: CardsViewModel

    init(viewModel: CardsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: CommonConstants.bigSpacing) {
            Button(action: viewModel.backButtonClicked) {
                Icons.leftArrow
                    .foregroundColor(SColors.mainText)
            }
            ProgressView(value: viewModel.progress, total: Double(viewModel.fetchedCards.count))
                .tint(SColors.accent)
            Button(action: viewModel.changeCardsMainSide) {
                Icons.circledArrows
                    .foregroundColor(SColors.mainText)
            }
        }
    }
}
