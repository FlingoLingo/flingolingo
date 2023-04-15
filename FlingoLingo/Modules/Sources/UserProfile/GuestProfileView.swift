import SwiftUI
import UIComponents

struct GuestProfileView: View {

    @ObservedObject var viewModel = UserViewModel()
    private let formatter: ProfileFormatter = .init()

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                ProfileHeaderView(buttonClicked: {}, guest: true)
                Text(formatter.formatGuest())
                    .font(Font(Fonts.subtitle))
                    .foregroundColor(SColors.accent)
                Group {
                    Text(formatter.formatStatFirstText())
                        .foregroundColor(SColors.mainText) + Text(formatter.formatStatSecondText())
                        .foregroundColor(SColors.accent).bold() +
                  Text(formatter.formatStatThirdText())
                        .foregroundColor(SColors.mainText)
                }
                .font(Font(Fonts.mainText))
                Spacer()
                ButtonView(buttonText: formatter.formatLogIn(), buttonClicked: viewModel.openWelcomeView)
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
