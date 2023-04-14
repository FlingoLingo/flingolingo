import SwiftUI
import UIComponents

struct ProfileHeaderView: View {
    
    enum Constants {
        static let headerName: String = "Профиль"
    }
    
    var body: some View {
        HStack {
            Text(Constants.headerName)
                .font(Font(Fonts.largeTitle))
                .foregroundColor(Color(ColorScheme.mainText))
            Spacer()
            Button(action: {
                // TODO: add action
            },
                   label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(Color(ColorScheme.mainText))
            })
        }
    }
}
