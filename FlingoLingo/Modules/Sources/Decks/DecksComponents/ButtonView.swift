//
//  ButtonView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct ButtonView: View {
    
    var buttonText: String
    var buttonClicked: (() -> Void)?
    
    var body: some View {
        Button(action: {
            buttonClicked?()
        }, label: {
            Text(buttonText)
                .font(Font(Fonts.buttonTitle))
                .foregroundColor(Color(ColorScheme.mainText))
        })
        .frame(maxWidth: .infinity)
        .padding(.all, CommonConstants.smallSpacing)
        .background(Color(ColorScheme.accent))
        .cornerRadius(CommonConstants.cornerRadius)
    }
}

struct Buttonpr: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonText: "Начать")
    }
}
