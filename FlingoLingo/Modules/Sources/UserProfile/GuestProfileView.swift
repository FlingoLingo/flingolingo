import SwiftUI
import UIComponents

struct GuestProfileView: View {

    @ObservedObject var viewModel = UserViewModel()

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                ProfileHeaderView(guest: true)
                Text(NSLocalizedString("guest", comment: ""))
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(SColors.accent)
                Group {
                    Text(NSLocalizedString("stat1", comment: ""))
                        .foregroundColor(SColors.mainText) + Text(NSLocalizedString("stat2", comment: ""))
                        .foregroundColor(SColors.accent).bold() +
                    Text(NSLocalizedString("stat3", comment: ""))
                        .foregroundColor(SColors.mainText)
                }
                .font(Font(Fonts.mainText))
                Spacer()
                ButtonView(buttonText: NSLocalizedString("logInButton", comment: ""),
                           buttonClicked: viewModel.openWelcomeView)
                .padding(.bottom, CommonConstants.bottomPadding)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
    }
}

struct GuestProfilePreviews: PreviewProvider {
    static var previews: some View {
        GuestProfileView()
    }
}
