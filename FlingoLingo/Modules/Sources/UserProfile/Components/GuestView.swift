import SwiftUI
import UIComponents

struct GuestView: View {

    var body: some View {
        Text("guest")
            .font(Font(Fonts.subtitle))
            .foregroundColor(SColors.accent)
        Group {
            Text("stat1")
                .foregroundColor(SColors.mainText) + Text("stat2")
                .foregroundColor(SColors.accent).bold() +
            Text("stat3")
                .foregroundColor(SColors.mainText)
        }
        .font(Font(Fonts.mainText))
    }
}
