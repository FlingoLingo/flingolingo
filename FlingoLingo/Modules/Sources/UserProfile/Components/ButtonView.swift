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
