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

    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var validatePasswords: [TextField: String] = [:]
    @Published var isSuccessfulChange: Bool = false
    @Published var showPasswordAlert: Bool = false

    private let backAction: () -> Void
    private let provider: ProfileProvider
    var domainProfile: DomainProfile

    init(backAction: @escaping () -> Void,
         provider: ProfileProvider, domainProfile: DomainProfile) {
        self.backAction = backAction
        self.provider = provider
        self.domainProfile = domainProfile
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
            provider.changePassword(email: domainProfile.email,
                                    oldPassword: oldPassword,
                                    newPassword: newPassword,
                                    onFinish: { res in
                DispatchQueue.main.async {
                    if res {
                        self.isSuccessfulChange = true
                    } else {
                        self.showPasswordAlert = true
                    }
                }
            })
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
