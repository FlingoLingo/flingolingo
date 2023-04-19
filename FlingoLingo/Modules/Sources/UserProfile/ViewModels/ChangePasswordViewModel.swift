import Foundation
import Authorization

final class ChangePasswordViewModel: ObservableObject {
    enum TextField: Equatable {
        case old
        case new
        case confirm
    }

    enum PasswordError: String {
        case notEnoughSymbols
        case notEqual

        func localizedString() -> String {
            NSLocalizedString(self.rawValue, comment: "")
        }
    }

    @Published var user: User
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var validatePasswords: [TextField: String] = [:]
    @Published var isSuccessfulChange: Bool = false

    private let backAction: () -> Void
    private let provider: ProfileProvider

    init(user: User,
         backAction: @escaping () -> Void,
         provider: ProfileProvider) {
        self.user = user
        self.backAction = backAction
        self.provider = provider
    }

    func changePassword() {

        if oldPassword.count < 6 {
            validatePasswords[.old] = PasswordError.notEnoughSymbols.localizedString()
        } else {
            validatePasswords[.old] = nil
        }

        if newPassword.count < 6 {
            validatePasswords[.new] = PasswordError.notEnoughSymbols.localizedString()
        } else {
            validatePasswords[.new] = nil
        }

        if confirmPassword != newPassword {
            validatePasswords[.confirm] = PasswordError.notEqual.localizedString()
        } else {
            validatePasswords[.confirm] = nil
        }

        if !hasError(for: .old) && !hasError(for: .new) && !hasError(for: .confirm) {
            isSuccessfulChange = true
//            provider.changePassword(user: user, oldPassword: oldPassword, newPassword: newPassword, onFinish: { isSuccess in
//                if isSuccess {
//                    isSuccessfulChange = true
//                } else {
//
//                }
//            })
        }
    }

    func getErrorText(for type: TextField) -> String? {
        validatePasswords[type]
    }

    func hasError(for type: TextField) -> Bool {
        validatePasswords[type] != nil
    }

    func goBack() {
        backAction()
    }
}
