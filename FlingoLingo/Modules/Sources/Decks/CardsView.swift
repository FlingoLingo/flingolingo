//
//  CardsView.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import SwiftUI
import UIComponents

enum CardSwipeDirection {
    case left
    case right
}

struct CardsView: View {
    @ObservedObject private var viewModel: CardsViewModel

    init(viewModel: CardsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            (SColors.background).edgesIgnoringSafeArea(.all)
            VStack {
                CardsNavigationBarView(viewModel: viewModel)
                    .padding(.horizontal, CommonConstants.bigSpacing)
                ZStack {
                    let cards = viewModel.displayingCards
                    if cards.isEmpty {
                        VStack(spacing: CommonConstants.bigSpacing) {
                            Spacer()
                            FinishMessageView()
                            Spacer()
                            ButtonView(
                                buttonText: NSLocalizedString("backToDecks", comment: ""),
                                buttonClicked: viewModel.backToDecksButtonClicked
                            )
                            .padding(.bottom, CommonConstants.bottomPadding)
                        }
                    } else {
                        ForEach(cards.reversed()) { card in
                            CardView(viewModel: viewModel, card: card)
                                .padding(.top, CommonConstants.bigSpacing * 2)
                        }
                        .padding(.bottom, CommonConstants.bigSpacing)
                    }
                }
                .padding(.top, CommonConstants.bigSpacing)
                .padding(.horizontal, CommonConstants.bigSpacing)
                .frame(maxWidth: .infinity)
                .zIndex(1000)

                let cards = viewModel.displayingCards
                if !cards.isEmpty {
                    HStack(spacing: CommonConstants.smallSpacing) {
                        ButtonView(
                            buttonText: NSLocalizedString("iDontKnow", comment: ""),
                            buttonTextColor: SColors.mainText,
                            buttonBackgroundColor: SColors.darkBackground
                        ) {
                            swipe(.left)
                        }
                        ButtonView(buttonText: NSLocalizedString("iKnow", comment: "")) {
                            swipe(.right)
                        }
                    }
                    .padding(.bottom, CommonConstants.bottomPadding)
                    .padding(.horizontal, CommonConstants.bigSpacing)
                }
            }
        }
    }

    func swipe(_ direction: CardSwipeDirection) {
        guard let card = viewModel.displayingCards.first else { return }
        withAnimation(.easeOut(duration: CommonConstants.animationDutation)) {
            viewModel.doSwipe(withInfo: CardSwipeInfo(id: card.id, direction: direction))
        }
    }
}
