import SwiftUI
import UIComponents

struct PasswordsView: View {

    @ObservedObject var viewModel: UserViewModel
    private let formatter: ProfileFormatter = .init()

    var body: some View {
        VStack(spacing: 15) {
            PasswordTextField(placeholder: formatter.formatOldPassword(), password: $viewModel.oldPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
            PasswordTextField(placeholder: formatter.formatNewPassword(), password: $viewModel.newPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
            PasswordTextField(placeholder: formatter.formatConfirmPassword(), password: $viewModel.confirmPassword)
                .overlay(RoundedRectangle(cornerRadius: CommonConstants.textFieldCornerRadius)
                .stroke(SColors.inactive, lineWidth: 1))
        }
    }
}
