import SwiftUI
import UIComponents

struct SubHeaderView: View {

    enum Constants {
        static let headerName: String = "Изменение пароля"
    }

    var body: some View {
        HStack(spacing: 15) {
            Button(action: {

            },
                   label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(ColorScheme.mainText))
            })
            Text(Constants.headerName)
                .font(Font(Fonts.subtitle))
                .foregroundColor(Color(ColorScheme.mainText))
            Spacer()
        }
    }
}
