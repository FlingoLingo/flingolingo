//
//  ButtonView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI

public struct ButtonView: View {

    private let buttonText: String
    private let buttonClicked: (() -> Void)
    private let buttonTextColor: Color
    private let buttonBackgroundColor: Color
    private let animationDuration = 0.1
    @State private var animate = false

    public init(
        buttonText: String,
        buttonTextColor: Color = SColors.mainText,
        buttonBackgroundColor: Color = SColors.accent,
        buttonClicked: @escaping () -> Void
    ) {
        self.buttonText = buttonText
        self.buttonTextColor = buttonTextColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonClicked = buttonClicked
    }

    public var body: some View {
        Text(buttonText)
            .font(SFonts.buttonTitle)
            .foregroundColor(buttonTextColor)
            .frame(maxWidth: .infinity)
            .padding(.all, CommonConstants.smallSpacing)
            .background(buttonBackgroundColor)
            .cornerRadius(CommonConstants.cornerRadius)
            .onTapGesture {
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
                    self.animate = false
                    buttonClicked()
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
