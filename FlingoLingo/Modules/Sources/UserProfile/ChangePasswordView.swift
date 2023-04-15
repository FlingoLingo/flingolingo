import SwiftUI
import UIComponents

struct ChangePasswordView: View {

    @ObservedObject var viewModel: UserViewModel
    private let formatter: ProfileFormatter = .init()

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                SubHeaderView(buttonClicked: viewModel.goBack)
                VStack(spacing: CommonConstants.smallSpacing) {
                    PasswordsView(viewModel: viewModel)
                    Spacer()
                    ButtonView(buttonText: formatter.formatChange(), buttonClicked: viewModel.changePassword)
                        .padding(.bottom, CommonConstants.bottomPadding)
                }
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
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
