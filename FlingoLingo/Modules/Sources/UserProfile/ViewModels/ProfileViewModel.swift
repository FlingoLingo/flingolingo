import Foundation

final class ProfileViewModel: ObservableObject {

    @Published var user: User
    @Published var isGuest: Bool = false
    @Published var isLoading = false

    private let router: ProfileRouter

    init(user: User,
         router: ProfileRouter) {
        self.user = user
        self.router = router
    }

    func logOut() {
        router.openWelcomeScreen()
    }

    func openSettings() {
        router.changePassword(user: user)
    }

    func settingsIconClicked() {
        router.changePassword(user: user)
    }
}
