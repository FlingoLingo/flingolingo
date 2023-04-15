import SwiftUI
import UIComponents

struct PasswordsView: View {

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        VStack(spacing: 15) {
            PasswordTextField(placeholder: "старый пароль...", password: $viewModel.oldPassword)
                .overlay(RoundedRectangle(cornerRadius: 11)
                    .stroke(Color(ColorScheme.inactive), lineWidth: 1))
            PasswordTextField(placeholder: "новый пароль...", password: $viewModel.newPassword)
                .overlay(RoundedRectangle(cornerRadius: 11)
                .stroke(Color(ColorScheme.inactive), lineWidth: 1))
            PasswordTextField(placeholder: "подтвердите пароль...", password: $viewModel.confirmPassword)
                .overlay(RoundedRectangle(cornerRadius: 11)
                .stroke(Color(ColorScheme.inactive), lineWidth: 1))
        }
    }
}
