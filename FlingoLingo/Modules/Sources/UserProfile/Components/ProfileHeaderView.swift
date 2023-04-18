import SwiftUI
import UIComponents

struct ProfileHeaderView: View {

    private let buttonClicked: (() -> Void)
    private let guest: Bool

    public init(buttonClicked: @escaping () -> Void = {}, guest: Bool) {
        self.buttonClicked = buttonClicked
        self.guest = guest
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
            .opacity(guest ? 0 : 1)
        }
    }
}
