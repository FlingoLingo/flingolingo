//
//  CardsNavigationBarView.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import SwiftUI
import UIComponents

struct CardsNavigationBarView: View {
    @ObservedObject var viewModel: CardsViewModel

    var body: some View {
        HStack(spacing: CommonConstants.bigSpacing) {
            Button(action: viewModel.backButtonClicked) {
                Icons.leftArrow
                    .foregroundColor(SColors.mainText)
            }
            ProgressView(value: viewModel.progress, total: Double(viewModel.getCardsCount()))
                .tint(SColors.accent)
            Button(action: {}) {
                Icons.circledArrows
                    .foregroundColor(SColors.mainText)
            }
        }
    }
}
