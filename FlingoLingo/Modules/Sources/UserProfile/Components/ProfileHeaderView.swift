import SwiftUI
import UIComponents

struct ProfileHeaderView: View {

    private let formatter: ProfileFormatter = .init()
    let buttonClicked: (() -> Void)
    let guest: Bool

    var body: some View {
        HStack {
            Text(formatter.formatProfile())
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
