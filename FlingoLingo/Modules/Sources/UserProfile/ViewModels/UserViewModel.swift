import Foundation

public final class UserViewModel: ObservableObject {

    @Published var user: User = User()
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""

    public init() {

    }

    public func comparePasswords() -> Bool {
        if newPassword == confirmPassword {
            return true
        }
        return false
    }

    public func changePassword() {
        if comparePasswords() {
            // TODO: send new password to server
        } else {
            // TODO: alert
        }
    }

    public func logOut() {

    }

    public func openWelcomeView() {

    }
}
