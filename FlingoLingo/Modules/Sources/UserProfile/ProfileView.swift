import SwiftUI
import UIComponents

struct ProfileView: View {

    @ObservedObject var viewModel: UserViewModel
    @State var isGuest: Bool

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                ProfileHeaderView(buttonClicked: viewModel.openSettings, guest: isGuest)

                if isGuest {
                    GuestView()
                } else {
                    Text(viewModel.user.email)
                        .font(Font(Fonts.subtitle))
                        .foregroundColor(SColors.accent)
                    StatisticsView(viewModel: viewModel)
                }

                Spacer()
                ButtonView(buttonText: isGuest
                           ? NSLocalizedString("logInButton", comment: "")
                           : NSLocalizedString("logOut", comment: ""),
                           buttonClicked: viewModel.logOut)
                .padding(.bottom, CommonConstants.bottomPadding)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
    }
}
