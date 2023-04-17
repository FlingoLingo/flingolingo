import SwiftUI
import UIComponents

enum Hint: String {
    case password = "use alphanumeric characters in a range from 6 to 12"
}

struct ChangePasswordView: View {

    @ObservedObject var viewModel: UserViewModel
    @State private var isValidPassword: Bool = false
    @State private var arePasswordsEqual: Bool = false
    @State private var isFocused: Bool?

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                SubHeaderView(buttonClicked: viewModel.goBack)
                VStack(spacing: CommonConstants.smallSpacing) {
                    PasswordsView(viewModel: viewModel)
                    Spacer()
                    ButtonView(buttonText: NSLocalizedString("change", comment: ""),
                               buttonClicked: viewModel.changePassword)
                        .padding(.bottom, CommonConstants.bottomPadding)
                }
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
    }
}
