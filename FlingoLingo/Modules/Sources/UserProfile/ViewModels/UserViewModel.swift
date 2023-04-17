import Foundation

public final class UserViewModel: ObservableObject {

    @Published var user: User
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordCorrect: Bool = true

    public init(user: User = User()) {
        self.user = user
    }

    public func changePassword() {
        if newPassword == confirmPassword {
            print(newPassword)
            // TODO: send new password to server
        } else {
            // TODO: alert
        }
    }

    public func logOut() {

    }

    public func openWelcomeView() {

    }

    public func openSettings() {

    }

    public func goBack() {

    }
}
