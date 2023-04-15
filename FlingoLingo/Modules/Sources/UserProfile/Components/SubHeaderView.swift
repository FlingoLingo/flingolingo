import SwiftUI
import UIComponents

struct SubHeaderView: View {

    private let formatter: ProfileFormatter = .init()

    var body: some View {
        HStack(spacing: CommonConstants.smallSpacing) {
            Button(action: {

            },
                   label: {
                Icons.leftArrow
                    .foregroundColor(SColors.mainText)
            })
            Text(formatter.formatChangePassword())
                .font(Font(Fonts.subtitle))
                .foregroundColor(SColors.mainText)
            Spacer()
        }
    }
}
