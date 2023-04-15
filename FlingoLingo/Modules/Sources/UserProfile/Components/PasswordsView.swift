import SwiftUI
import UIComponents

struct PasswordsView: View {

    var body: some View {
        VStack(spacing: 15) {
            PasswordTextField(placeholder: "старый пароль...")
                .overlay(RoundedRectangle(cornerRadius: 11)
                .stroke(Color(ColorScheme.inactive), lineWidth: 1))
            PasswordTextField(placeholder: "новый пароль...")
                .overlay(RoundedRectangle(cornerRadius: 11)
                .stroke(Color(ColorScheme.inactive), lineWidth: 1))
            PasswordTextField(placeholder: "подтвердите пароль...")
                .overlay(RoundedRectangle(cornerRadius: 11)
                .stroke(Color(ColorScheme.inactive), lineWidth: 1))
        }
    }
}
