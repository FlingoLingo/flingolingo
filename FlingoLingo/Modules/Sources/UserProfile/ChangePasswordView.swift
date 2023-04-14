import SwiftUI
import UIComponents

struct ChangePasswordView: View {
    
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
                SubHeaderView()
                VStack(spacing: 15) {
                    PasswordsView()
                    Spacer()
                    ButtonView(buttonText: "Изменить")
                        .padding(.bottom, 40)
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

struct ChangePasswordPreviews: PreviewProvider {
    static var previews: some View {
        SubHeaderView()
        ChangePasswordView()
    }
}
