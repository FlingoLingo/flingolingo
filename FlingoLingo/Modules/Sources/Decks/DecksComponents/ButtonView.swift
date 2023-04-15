//
//  ButtonView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct ButtonView: View {

    private let buttonText: String
    private let buttonClicked: (() -> Void)

    init(buttonText: String, buttonClicked: @escaping () -> Void) {
        self.buttonText = buttonText
        self.buttonClicked = buttonClicked
    }

    var body: some View {
        Button(action: buttonClicked) {
            Text(buttonText)
                .font(SFonts.buttonTitle)
                .foregroundColor(SColors.mainText)
        }
        .frame(maxWidth: .infinity)
        .padding(.all, CommonConstants.smallSpacing)
        .background(SColors.accent)
        .cornerRadius(CommonConstants.cornerRadius)
    }
}

struct Buttonpr: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonText: "Начать", buttonClicked: {})
    }
}
