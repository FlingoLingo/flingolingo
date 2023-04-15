import SwiftUI
import UIComponents

struct ChangePasswordView: View {

    @StateObject private var viewModel = UsersViewModel()

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
    static let viewModel = {
        let viewModel = UsersViewModel()
        viewModel.users = Array(repeating: User(id: 1,
                                                email: "test@mail.ru",
                                                passwordHash: "123345544",
                                                daysOfUse: 5,
                                                wordsLearned: 159,
                                                decksCount: 10,
                                                timesRepeated: 14680489390), count: 2)
        return viewModel
    }()

    static var previews: some View {
        ChangePasswordView()
    }
}
