import Foundation
import Authorization

final class ProfileViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var profile: DomainProfile?

    private let router: ProfileRouter
    @Published private var provider: ProfileProvider
    private let defaults = UserDefaults.standard
    @Published var wordsLearnedCount: Int = 0
    @Published var decksCreatedCount: Int = 0

    enum StatisticsType: String, Equatable {
        case daysOfUse
        case wordsLearned
        case decksCount
        case timesRepeated
    }

    init(router: ProfileRouter,
         provider: ProfileProvider) {
        self.router = router
        self.provider = provider
        setDomainProfile()
    }

    func logOut() {
        provider.logOut()
        profile = nil
        router.openWelcomeScreen()
    }

    private func fetchUserIfNeeded() {
        if profile == nil {
            setDomainProfile()
        }
    }

    private func fetchStatistics() {
        wordsLearnedCount = defaults.integer(forKey: "wordsLearned")
        decksCreatedCount = defaults.integer(forKey: "decksCount")
    }

    func fetchDataIfNeeded() {
        fetchUserIfNeeded()
        fetchStatistics()
    }

    private func setDomainProfile() {
        isLoading = true
        provider.getProfile(onFinish: { [weak self] res in
            switch res {
            case .success(let success):
                self?.profile = success
                self?.defaults.set(self?.profile?.email, forKey: "profileEmail")
            case .failure: break
            }
            self?.isLoading = false
        })
    }

    func openSettings() {
        if let profile = profile {
            router.changePassword(provider: provider, profile: profile)
        }
    }

    func getDaysOfUse() -> Int {
        getDaysOfUse(dateJoined: profile?.dateJoined ?? "")
    }

    func getDaysOfUse(dateJoined: String) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateJoined)
        guard let date = date else { return 0 }
        return calendar.numberOfDaysBetween(date, and: Date.now)
    }

    func getWordsLearned() -> Int {
        defaults.integer(forKey: "wordsLearned")
    }

    func getDecksCount() -> Int {
        defaults.integer(forKey: "decksCount")
    }

    func getUserEmail() -> String {
        let email = defaults.object(forKey: "profileEmail") as? String
        if email != nil {
            return email ?? ""
        }
        return profile?.email ?? ""
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and toDateInput: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: toDateInput)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)

        return numberOfDays.day ?? 0 + 1
    }
}
