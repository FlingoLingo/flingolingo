import SwiftUI
import UIComponents

struct PasswordsView: View {

    @ObservedObject var viewModel: UserViewModel

    public init(viewModel: UserViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            PasswordTextField(placeholder: NSLocalizedString("oldPassword", comment: ""),
                              password: $viewModel.oldPassword,
                              isPasswordIncorrect: viewModel.hasError(for: .old))
            .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(viewModel.hasError(for: .old) ? Color.red : SColors.inactive, lineWidth: 1))
            if let error = viewModel.getErrorText(for: .old) {
                Text(error)
                    .foregroundColor(SColors.mainText)
                    .font(SFonts.mainText)
            }

            PasswordTextField(placeholder: NSLocalizedString("newPassword", comment: ""),
                              password: $viewModel.newPassword,
                              isPasswordIncorrect: viewModel.newPasswordCorrect)
            .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(viewModel.hasError(for: .new) ? Color.red : SColors.inactive, lineWidth: 1))
            if let error = viewModel.getErrorText(for: .new) {
                Text(error)
                    .foregroundColor(SColors.mainText)
                    .font(SFonts.mainText)
            }

            PasswordTextField(placeholder: NSLocalizedString("confirmPassword", comment: ""),
                              password: $viewModel.confirmPassword,
                              isPasswordIncorrect: viewModel.confirmPasswordCorrect)
            .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(viewModel.hasError(for: .confirm) ? Color.red : SColors.inactive, lineWidth: 1))
            if let error = viewModel.getErrorText(for: .confirm) {
                Text(error)
                    .foregroundColor(SColors.mainText)
                    .font(SFonts.mainText)
            }
        }
    }
}
