import Foundation

public final class UserViewModel: ObservableObject {
    
    enum TextField: Equatable {
        case old
        case new
        case confirm
    }
    
    enum PasswordError: String {
        case notEnoughSymbols = "notEnoughSymbols"
        case notEqual = "notEqual"
        
        func localizedString() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }
    
    @Published var user: User
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var oldPasswordCorrect: Bool = true
    @Published var newPasswordCorrect: Bool = true
    @Published var confirmPasswordCorrect: Bool = true
    @Published var validatePasswords: [TextField: String] = [:]
    
    private let router: UserProfileRouter
    private let backAction: () -> Void
    
    init(user: User = User(),
         backAction: @escaping () -> Void = {},
         router: UserProfileRouter = UserProfileRouter()) {
        self.user = user
        self.backAction = backAction
        self.router = router
    }
    
    func changePassword() {
        
        if oldPassword.count < 6 {
            validatePasswords[.old] = PasswordError.notEnoughSymbols.localizedString()
            oldPasswordCorrect = false
        } else {
            validatePasswords[.old] = nil
            oldPasswordCorrect = true
        }
        
        if newPassword.count < 6 {
            validatePasswords[.new] = PasswordError.notEnoughSymbols.localizedString()
            newPasswordCorrect = false
        } else {
            validatePasswords[.new] = nil
            newPasswordCorrect = true
        }
        
        if confirmPassword != newPassword {
            validatePasswords[.confirm] = PasswordError.notEqual.localizedString()
            confirmPasswordCorrect = false
        } else {
            validatePasswords[.confirm] = nil
            confirmPasswordCorrect = true
        }
        
        if oldPasswordCorrect && newPasswordCorrect && confirmPasswordCorrect {
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
        
    }
    
    func openWelcomeView() {
        
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
