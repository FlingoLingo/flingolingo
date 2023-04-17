import Foundation

public final class UserViewModel: ObservableObject {

    enum TextField: Equatable {
        case old
        case new
        case confirm
    }

    @Published var user: User
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var validatePasswords: [TextField: String] = [:]
    
    private let router: UserProfileRouter
    private let backAction: () -> Void

    public init(user: User = User(), backAction: @escaping () -> Void = {}, router: UserProfileRouter = UserProfileRouter()) {
        self.user = user
        self.backAction = backAction
        self.router = router
    }

    public func changePassword() {
        var error = false
        
        if oldPassword.count < 6 {
            validatePasswords[.old] = "Пароль должен состоять как минимум  из 6 символов"
            error = true
        } else {
            validatePasswords[.old] = ""
        }

        if newPassword.count < 6 {
            validatePasswords[.new] = "Пароль должен состоять как минимум  из 6 символов"
            error = true
        } else {
            validatePasswords[.new] = ""
        }

        if confirmPassword != newPassword {
            validatePasswords[.confirm] = "Пароли не совпадают"
            error = true
        } else {
            validatePasswords[.confirm] = ""
        }

        if !error {
            print("success")
            // change password
        }
    }

    public func isPasswordCorrect(password: String?) -> Bool {
        password?.count ?? 0 >= 6
    }

    func getErrorText(for type: TextField) -> String? {
        validatePasswords[type]
    }

    public func arePasswordsEqual(first: String?, second: String?) -> Bool {
        !(first?.isEmpty ?? true) && !(second?.isEmpty ?? true) && first == second
    }

    public func logOut() {

    }

    public func openWelcomeView() {

    }

    public func openSettings() {

    }

    public func goBack() {
        backAction()
    }

    func settingsIconClicked() {
        router.changePassword(user: self.user)
    }
}
