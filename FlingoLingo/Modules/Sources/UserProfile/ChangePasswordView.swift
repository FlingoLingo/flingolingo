import SwiftUI
import UIComponents

struct ChangePasswordView: View {

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 25) {
                SubHeaderView()
                VStack(spacing: 15) {
                    PasswordsView(viewModel: viewModel)
                    Spacer()
                    ButtonView(buttonText: "Изменить", buttonClicked: viewModel.changePassword)
                        .padding(.bottom, 40)
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

struct ChangePasswordPreviews: PreviewProvider {
    static let viewModel = {
        let viewModel = UserViewModel()
        viewModel.user = User(id: 1,
                              email: "test@mail.ru",
                              daysOfUse: 5,
                              wordsLearned: 159,
                              decksCount: 10,
                              timesRepeated: 14680489390)
        return viewModel
    }()

    static var previews: some View {
        ChangePasswordView(viewModel: viewModel)
    }
}
