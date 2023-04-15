import SwiftUI
import UIComponents

struct ProfileHeaderView: View {

    private let formatter: ProfileFormatter = .init()

    var body: some View {
        HStack {
            Text(formatter.formatProfile())
                .font(Font(Fonts.largeTitle))
                .foregroundColor(SColors.mainText)
            Spacer()
            Button(action: {

            },
                   label: {
                Icons.settings
                    .foregroundColor(SColors.mainText)
            })
        }
    }
}
