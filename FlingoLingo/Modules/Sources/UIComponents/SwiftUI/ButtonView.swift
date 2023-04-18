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
        Button(action: buttonClicked) {
            Text(buttonText)
                .font(SFonts.buttonTitle)
                .foregroundColor(buttonTextColor)
                .frame(maxWidth: .infinity)
                .padding(.all, CommonConstants.smallSpacing)
                .background(buttonBackgroundColor)
                .cornerRadius(CommonConstants.cornerRadius)
        }
    }
}

struct Buttonpr: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonText: "Начать", buttonClicked: {})
    }
}
