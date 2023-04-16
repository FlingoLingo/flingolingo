import SwiftUI
import UIComponents

struct UserProfileView: View {

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                ProfileHeaderView(buttonClicked: viewModel.openSettings, guest: false)
                Text(viewModel.user.email)
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(SColors.accent)

                StatisticsView()

                Spacer()
                ButtonView(buttonText: NSLocalizedString("logOut", comment: ""), buttonClicked: viewModel.logOut)
                    .padding(.bottom, CommonConstants.bottomPadding)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
    }
}

struct UserProfilePreviews: PreviewProvider {
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
        UserProfileView(viewModel: viewModel)
    }
}
