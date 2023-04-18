//
//  ButtonView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI

public struct ButtonView: View {

    private enum Constants {
        static let blurRadius: CGFloat = 4
        static let shadowRadius: CGFloat = 15
        static let offset: CGFloat = -10
        static let padding: CGFloat = 8
    }

    private let buttonText: String
    private let buttonClicked: (() -> Void)
    private let animationDuration = 0.1
    @State private var animate = false

    public init(buttonText: String, buttonClicked: @escaping () -> Void) {
        self.buttonText = buttonText
        self.buttonClicked = buttonClicked
    }

    public var body: some View {
        Text(buttonText)
            .font(SFonts.buttonTitle)
            .foregroundColor(SColors.mainText)
            .frame(maxWidth: .infinity)
            .padding(.all, CommonConstants.smallSpacing)
            .background {
                ZStack {
                    SColors.accent
                    RoundedRectangle(cornerRadius: CommonConstants.cornerRadius, style: .continuous)
                        .foregroundColor(SColors.lightButton)
                        .blur(radius: Constants.blurRadius)
                        .offset(x: Constants.offset, y: Constants.offset)
                    RoundedRectangle(cornerRadius: CommonConstants.cornerRadius, style: .continuous)
                        .fill(LinearGradient(gradient: Gradient(colors: [SColors.accent, SColors.lightButton]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                        .padding(Constants.padding)
                        .blur(radius: Constants.blurRadius)
                }
                .blur(radius: Constants.blurRadius)
            }
            .cornerRadius(CommonConstants.cornerRadius)
            .shadow(color: SColors.darkButton,
                    radius: Constants.shadowRadius,
                    x: Constants.padding / 2,
                    y: Constants.padding / 2)
            .onTapGesture {
                buttonClicked()
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
                    self.animate = false
                })
            }
            .scaleEffect(animate ? 0.9 : 1)
            .animation(.easeIn(duration: animationDuration), value: animate)
    }
}

struct Buttonpr: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonText: "Начать", buttonClicked: {})
    }
}
