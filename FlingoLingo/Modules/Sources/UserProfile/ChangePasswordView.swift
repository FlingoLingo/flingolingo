import SwiftUI
import UIComponents

struct ChangePasswordView: View {

    @ObservedObject var viewModel: ChangePasswordViewModel
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
                    .alert("Пароль был успешно изменен", isPresented: $viewModel.isSuccessfulChange) {
                        Button("OK", role: .cancel) { }
                    }
                    .alert("Ошибка смены пароля", isPresented: $viewModel.showPasswordAlert) {
                        Button("OK", role: .cancel) { }
                    }
                }
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
        .navigationBarBackButtonHidden()
    }
}
