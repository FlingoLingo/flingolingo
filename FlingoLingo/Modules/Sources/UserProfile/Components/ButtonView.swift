import SwiftUI
import UIComponents

struct ButtonView: View {
    var buttonText: String
    let buttonClicked: (() -> Void)

    var body: some View {
        Button(action: buttonClicked, label: {
            Text(buttonText)
                .font(Font(Fonts.buttonTitle))
                .foregroundColor(SColors.mainText)
        })
        .frame(maxWidth: .infinity)
        .padding(.all, CommonConstants.smallSpacing)
        .background(SColors.accent)
        .cornerRadius(CommonConstants.cornerRadius)
    }
}
