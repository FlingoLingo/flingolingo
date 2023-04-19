import Foundation
import Authorization

final class ProfileViewModel: ObservableObject {

    @Published var user: User
    @Published var isGuest: Bool = false

    private let router: ProfileRouter
    private let provider: ProfileProvider
    private let defaults = UserDefaults.standard

    init(router: ProfileRouter,
         provider: ProfileProvider) {
        self.router = router
        self.provider = provider
        self.user = User()
    }

    func logOut() {
        router.openWelcomeScreen()
    }

    func openSettings() {
        user = getUser()
        router.changePassword(user: user, provider: provider)
    }

    func saveUserDefaults(user: User) {
        let dict = ["daysOfUse": user.daysOfUse,
                    "decksCount": user.decksCount,
                    "timesRepeated": user.timesRepeated,
                    "wordsLearned": user.wordsLearned]
        defaults.set(dict, forKey: "stats")
    }

    func getStatistics() -> [String: Int] {
        defaults.dictionary(forKey: "stats") as? [String: Int] ?? [String: Int]()
    }
    
    func getUser() -> User {
        let stats = getStatistics()
        let daysOfUse: Int = stats["daysOfUse"] ?? 0
        let wordsLearned: Int = stats["wordsLearned"] ?? 0
        let decksCreated: Int = stats["decksCreated"] ?? 0
        let timesRepeated: Int = stats["timesRepeated"] ?? 0
        
        let id = provider.getUserId()
        let email = provider.getUserEmail()
        return User(id: id, email: email, daysOfUse: daysOfUse, wordsLearned: wordsLearned, decksCount: decksCreated, timesRepeated: timesRepeated)
    }
}
