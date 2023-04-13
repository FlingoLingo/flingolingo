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
        static let mainSpacing: CGFloat = 25
        static let smallSpacing: CGFloat = 18
        static let cornerRadius: CGFloat = 19
        static let buttonText: String = "Начать"
        static let translation: String = "яблоко"
    }
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text(Constants.buttonText)
                .font(Font(Fonts.buttonTitle))
                .foregroundColor(Color(ColorScheme.mainText))
        })
        .frame(maxWidth: .infinity)
        .padding(.all, Constants.smallSpacing)
        .background(Color(ColorScheme.accent))
        .cornerRadius(Constants.cornerRadius)
    }
}

struct Buttonpr: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
