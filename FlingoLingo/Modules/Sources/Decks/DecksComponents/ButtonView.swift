//
//  ButtonView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct ButtonView: View {
    
    let buttonText: String
    let buttonClicked: (() -> Void)
    
    var body: some View {
        Button(action: buttonClicked,
               label: {
            Text(buttonText)
                .font(SFonts.buttonTitle)
                .foregroundColor(SColors.mainText))
        })
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
