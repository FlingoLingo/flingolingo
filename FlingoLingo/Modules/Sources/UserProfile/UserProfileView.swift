import SwiftUI
import UIComponents

struct UserProfileView: View {
    
    enum Constants {
        static let email: String = "hello@world.ru"
        static let days: Int = 0
        static let words: Int = 3
        static let decks: Int = 20
        static let times: Int = 136
    }
    
    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 25) {
                ProfileHeaderView()
                Text(Constants.email)
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(Color(ColorScheme.accent))
                
                StatisticsView()
                
                Spacer()
                ButtonView(buttonText: "Выйти").padding(.bottom, 40)
            }
            .padding(.horizontal, 25)
        }
    }
}

struct UserProfilePreviews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
        UserProfileView()
    }
}
