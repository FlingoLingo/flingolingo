import Foundation

public final class UserViewModel: ObservableObject {

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
    @Published var isGuest: Bool = false

    private let router: ProfileRouter
    private let backAction: () -> Void

    init(user: User,
         backAction: @escaping () -> Void,
         router: ProfileRouter) {
        self.user = user
        self.backAction = backAction
        self.router = router
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
            // change password
        }
    }

    func getErrorText(for type: TextField) -> String? {
        validatePasswords[type]
    }

    func hasError(for type: TextField) -> Bool {
        validatePasswords[type] != nil
    }

    func logOut() {
        router.openWelcomeScreen()
    }

    func openSettings() {
        router.changePassword(user: user)
    }

    func goBack() {
        backAction()
    }

    func settingsIconClicked() {
        router.changePassword(user: self.user)
    }
}
