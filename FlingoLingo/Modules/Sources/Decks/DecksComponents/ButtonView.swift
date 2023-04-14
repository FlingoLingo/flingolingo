//
//  ButtonView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents


struct ButtonView: View {
    // MARK: - Constants
    enum Constants {
        static let buttonText: String = "Начать"
        static let translation: String = "яблоко"
    }
    
    var body: some View {
        Button(action: {
            // TODO: add action
        }, label: {
            Text(Constants.buttonText)
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
        ButtonView()
    }
}
