import SwiftUI
import UIComponents

struct ProfileHeaderView: View {

    private let buttonClicked: (() -> Void)

    init(buttonClicked: @escaping () -> Void = {}) {
        self.buttonClicked = buttonClicked
    }

    var body: some View {
        HStack {
            Text(NSLocalizedString("profile", comment: ""))
                .font(Font(Fonts.largeTitle))
                .foregroundColor(SColors.mainText)
            Spacer()
            Button(action: buttonClicked,
                   label: {
                Icons.settings
                    .foregroundColor(SColors.mainText)
            })
        }
    }
}
