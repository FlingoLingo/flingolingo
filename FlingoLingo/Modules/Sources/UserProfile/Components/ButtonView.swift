import SwiftUI
import UIComponents

struct ButtonView: View {
    var buttonText: String
    let buttonClicked: (() -> Void)

    var body: some View {
        Button(action: buttonClicked, label: {
            Text(buttonText)
                .font(Font(Fonts.buttonTitle))
                .foregroundColor(Color(ColorScheme.mainText))
        })
        .frame(maxWidth: .infinity)
        .padding(.all, 15)
        .background(Color(ColorScheme.accent))
        .cornerRadius(19)
    }
}
