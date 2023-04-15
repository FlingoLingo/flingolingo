import SwiftUI
import UIComponents

struct GuestProfileView: View {

    enum Constants {
        static let user: String = "гость"
        static let statictics: String = "Для формирования статистики, зарегистрируйтесь в приложении"
    }

    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 25) {
                ProfileHeaderView()
                Text(Constants.user)
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(Color(ColorScheme.accent))
                Group {
                    Text("Для формирования статистики")
                        .foregroundColor(Color(ColorScheme.mainText)) + Text(" зарегистрируйтесь ")
                        .foregroundColor(Color(ColorScheme.accent)).bold() +
                  Text("в приложении")
                        .foregroundColor(Color(ColorScheme.mainText))
                }
                .font(Font(Fonts.mainText))
                Spacer()
                ButtonView(buttonText: "Выйти").padding(.bottom, 40)
            }
            .padding(.horizontal, 25)
        }
    }
}

struct GuestProfilePreviews: PreviewProvider {
    static var previews: some View {
        GuestProfileView()
    }
}
