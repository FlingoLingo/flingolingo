import SwiftUI
import UIComponents

struct GuestView: View {

    var body: some View {
        Text(NSLocalizedString("guest", comment: ""))
            .font(Font(Fonts.subtitle))
            .foregroundColor(SColors.accent)
        Group {
            Text(NSLocalizedString("stat1", comment: ""))
                .foregroundColor(SColors.mainText) + Text(NSLocalizedString("stat2", comment: ""))
                .foregroundColor(SColors.accent).bold() +
            Text(NSLocalizedString("stat3", comment: ""))
                .foregroundColor(SColors.mainText)
        }
        .font(Font(Fonts.mainText))
    }
}
