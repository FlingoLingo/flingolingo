import SwiftUI
import UIComponents

struct SubHeaderView: View {

    private let buttonClicked: (() -> Void)

    init(buttonClicked: @escaping () -> Void) {
        self.buttonClicked = buttonClicked
    }

    var body: some View {
        HStack(spacing: CommonConstants.smallSpacing) {
            Button(action: buttonClicked,
                   label: {
                Icons.leftArrow
                    .foregroundColor(SColors.mainText)
            })
            Text(NSLocalizedString("changePassword", comment: ""))
                .font(Font(Fonts.subtitle))
                .foregroundColor(SColors.mainText)
            Spacer()
        }
    }
}
