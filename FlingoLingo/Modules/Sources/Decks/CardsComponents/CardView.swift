//
//  CardView.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import SwiftUI
import UIComponents

struct CardView: View {
    private enum Constants {
        static let cardRotation: CGFloat = 180
    }

    @ObservedObject private var viewModel: CardsViewModel

    private var card: Card

    @State private var offset: CGFloat = 0
    @GestureState private var isDragging: Bool = false
    @State private var endSwipe: Bool = false
    @State private var flipped: Bool = false
    @State private var flashcardRotation = 0.0
    @State private var contentRotation = 0.0

    init(viewModel: CardsViewModel, card: Card) {
        self.viewModel = viewModel
        self.card = card
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(viewModel.getIndex(card: card))
            let topOffset = (index <= 2 ? index : 2) * CommonConstants.bigSpacing

            ZStack {
                if flipped {
                    Text(card.rus)
                } else {
                    Text(card.eng)
                }
            }
            .frame(width: size.width - topOffset, height: size.height)
            .font(SFonts.largeTitle)
            .foregroundColor(SColors.mainText)
            .background(SColors.darkBackground)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                    .stroke(SColors.background, lineWidth: 5)
            )
            .cornerRadius(CommonConstants.cornerRadius)
            .offset(y: -topOffset)
            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                flipFlashcard()
            }
            .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging) { _, out, _ in
                    out = true
                }
                .onChanged { value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                }
                .onEnded { value in
                    let width = getRect().width - 50
                    let translation = value.translation.width

                    let checkingStatus = (translation > 0 ? translation : -translation)

                    withAnimation(.easeOut(duration: CommonConstants.animationDutation)) {
                        if checkingStatus > (width / 2) {
                            offset = (translation > 0 ? width : -width) * 2
                            if translation > 0 {
                                viewModel.doSwipe(withInfo: .init(id: card.id, direction: .right))
                            } else {
                                viewModel.doSwipe(withInfo: .init(id: card.id, direction: .left))
                            }
                        } else {
                            offset = .zero
                        }
                    }
                }
        )
        .onReceive(
            viewModel.notificationSubject
        ) { cardSwipeInfo in
            let cardId = cardSwipeInfo.id
            let swipeDirection = cardSwipeInfo.direction
            let width = getRect().width - 50

            if card.id == cardId {
                withAnimation(.easeOut(duration: CommonConstants.animationDutation)) {
                    switch swipeDirection {
                    case .left:
                        offset = -width * 2
                    case .right:
                        offset = width * 2
                    }
                    endSwipeActions()
                }
            }
        }
    }

    func flipFlashcard() {
        let animationTime = CommonConstants.animationDutation
        withAnimation(Animation.linear(duration: animationTime)) {
            if flipped {
                flashcardRotation -= Constants.cardRotation
            } else {
                flashcardRotation += Constants.cardRotation
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + animationTime / 2) {
            if flipped {
                contentRotation -= Constants.cardRotation
            } else {
                contentRotation += Constants.cardRotation
            }
            flipped.toggle()
        }
    }

    func getRotation(angle: Double) -> Double {
        let rotation = (offset / (getRect().width - 50)) * angle

        return rotation
    }

    func endSwipeActions() {
        withAnimation(.none) { endSwipe = true }

        DispatchQueue.main.asyncAfter(deadline: .now() + CommonConstants.animationDutation / 2) {
            if viewModel.displayingCards.first != nil {
                withAnimation(
                    .easeIn(duration: CommonConstants.animationDutation / 2)
                ) {
                    viewModel.removeFirst()
                }
            }
        }
    }
}

private extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
