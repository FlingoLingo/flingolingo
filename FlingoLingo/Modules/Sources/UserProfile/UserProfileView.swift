import SwiftUI
import UIComponents

struct UserProfileView: View {

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        ZStack {
            Color(ColorScheme.background).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 25) {
                ProfileHeaderView()
                Text(viewModel.user.email)
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(Color(ColorScheme.accent))

                StatisticsView()

                Spacer()
                ButtonView(buttonText: "Выйти", buttonClicked: viewModel.logOut).padding(.bottom, 40)
            }
            .padding(.horizontal, 25)
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
