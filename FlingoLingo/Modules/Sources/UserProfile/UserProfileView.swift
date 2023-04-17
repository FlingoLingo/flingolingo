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

                StatisticsView(viewModel: viewModel)

                Spacer()
                ButtonView(buttonText: NSLocalizedString("logOut", comment: ""), buttonClicked: viewModel.logOut)
                    .padding(.bottom, CommonConstants.bottomPadding)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
    }
}
