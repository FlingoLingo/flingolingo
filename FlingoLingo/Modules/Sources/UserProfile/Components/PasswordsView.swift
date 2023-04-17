import SwiftUI
import UIComponents

struct PasswordsView: View {

    @ObservedObject private var viewModel: UserViewModel

    public init(viewModel: UserViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            PasswordTextField(placeholder: NSLocalizedString("oldPassword", comment: ""),
                              password: $viewModel.oldPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
            if let error = viewModel.getErrorText(for: .old) {
                Text(error)
                    .foregroundColor(SColors.mainText)
                    .font(SFonts.mainText)
            }

            PasswordTextField(placeholder: NSLocalizedString("newPassword", comment: ""),
                              password: $viewModel.newPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
            if let error = viewModel.getErrorText(for: .new) {
                Text(error)
                    .foregroundColor(SColors.mainText)
                    .font(SFonts.mainText)
            }

            PasswordTextField(placeholder: NSLocalizedString("confirmPassword", comment: ""),
                              password: $viewModel.confirmPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
            if let error = viewModel.getErrorText(for: .confirm) {
                Text(error)
                    .foregroundColor(SColors.mainText)
                    .font(SFonts.mainText)
            }
        }
    }
}
