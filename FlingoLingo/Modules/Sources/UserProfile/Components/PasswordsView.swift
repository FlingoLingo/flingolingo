import SwiftUI
import UIComponents

struct PasswordsView: View {

    @ObservedObject private var viewModel: UserViewModel

    public init(viewModel: UserViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 15) {
            PasswordTextField(placeholder: NSLocalizedString("oldPassword", comment: ""),
                              password: $viewModel.oldPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
            PasswordTextField(placeholder: NSLocalizedString("newPassword", comment: ""),
                              password: $viewModel.newPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
            PasswordTextField(placeholder: NSLocalizedString("confirmPassword", comment: ""),
                              password: $viewModel.confirmPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
        }
    }
}
