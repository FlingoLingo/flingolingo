import SwiftUI
import UIComponents

struct ProfileView: View {

    @ObservedObject private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                ProfileHeaderView(buttonClicked: viewModel.openSettings, guest: viewModel.isGuest)

                if viewModel.isGuest {
                    GuestView()
                } else {
                    Text(viewModel.getUserEmail())
                        .font(Font(Fonts.subtitle))
                        .foregroundColor(SColors.accent)
                    StatisticsView(viewModel: viewModel)
                }

                Spacer()
                ButtonView(buttonText: viewModel.isGuest
                           ? NSLocalizedString("logInButton", comment: "")
                           : NSLocalizedString("logOut", comment: ""),
                           buttonClicked: viewModel.logOut)
                .padding(.bottom, CommonConstants.bottomPadding)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
        .onAppear(perform: viewModel.fetchUserIfNeeded)
    }
}
