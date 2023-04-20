import Foundation
import Authorization

final class ProfileViewModel: ObservableObject {

    @Published var isGuest: Bool = false
    @Published var isLoading = false

    var profile: DomainProfile?

    private let router: ProfileRouter
    @Published private var provider: ProfileProvider
    private let defaults = UserDefaults.standard

    init(router: ProfileRouter,
         provider: ProfileProvider) {
        self.router = router
        self.provider = provider
        setDomainProfile()
    }

    func logOut() {
        provider.logOut(onFinish: { [weak self] res in
            if res {
                self?.router.openWelcomeScreen()
            }
        })
    }

    func setDomainProfile() {
        isLoading = true
        provider.getProfile(onFinish: { [weak self] res in
            switch res {
            case .success(let success):
                self?.profile = success
            case .failure(let failure):
                print(failure)
            }
            self?.isLoading = false
        })
    }

    func openSettings() {
        router.changePassword(provider: provider)
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

    func getUserEmail() -> String {
        profile?.email ?? ""
    }
}
