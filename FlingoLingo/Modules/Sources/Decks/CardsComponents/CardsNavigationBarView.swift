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
        HStack {
            Button(action: viewModel.backButtonClicked) {
                Icons.leftArrow
                    .foregroundColor(SColors.mainText)
            }
            Spacer(minLength: CommonConstants.smallSpacing)
            ProgressView(
                value: min(viewModel.progress, Double(viewModel.fetchedCards.count)),
                total: Double(viewModel.fetchedCards.count)
            )
            .tint(SColors.accent)
            Spacer(minLength: CommonConstants.smallSpacing)
            Button(action: viewModel.changeCardsMainSide) {
                Icons.circledArrows
                    .foregroundColor(SColors.mainText)
            }
        }
    }
}
