//
//  CardView.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import SwiftUI
import UIComponents

struct CardView: View {
    @ObservedObject var viewModel: CardsViewModel

    var card: Card

    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false

    @State var endSwipe: Bool = false
    @State var flipped: Bool = false
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0

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
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = getRect().width - 50
                    let translation = value.translation.width

                    let checkingStatus = (translation > 0 ? translation : -translation)

                    withAnimation(.easeOut(duration: CommonConstants.animationDutation)) {
                        if checkingStatus > (width / 2) {
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeActions()
                            if translation > 0 {
                                rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                })
        )
        .onReceive(
            NotificationCenter.default.publisher(
                for: Notification.Name("actionFromButton"),
                object: nil
            )
        ) { data in
            guard let info = data.userInfo else { return }

            let id = info["id"] as? Int
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50

            if card.id == id {
                withAnimation(.easeOut(duration: CommonConstants.animationDutation)) {
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    if rightSwipe {
                        self.rightSwipe()
                    } else {
                        leftSwipe()
                    }
                }
            }
        }
    }

    func flipFlashcard() {
        let animationTime = CommonConstants.animationDutation
        withAnimation(Animation.linear(duration: animationTime)) {
            if flipped {
                flashcardRotation -= 180
            } else {
                flashcardRotation += 180
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + animationTime / 2) {
            if flipped {
                contentRotation -= 180
            } else {
                contentRotation += 180
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
                _ = withAnimation(
                    .easeIn(duration: CommonConstants.animationDutation / 2)
                ) {
                    viewModel.displayingCards.removeFirst()
                }
            }
        }
    }

    func leftSwipe() {
        viewModel.progress += 1
    }

    func rightSwipe() {
        viewModel.progress += 1
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
