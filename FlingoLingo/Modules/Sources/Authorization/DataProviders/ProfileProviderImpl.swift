import Foundation
import NetworkLayer
import SwiftyKeychainKit

public class ProfileProviderImpl: ProfileProvider {

    private var authClient: AuthClient
    private var profileClient: ProfileClient
    private let keychain: Keychain = Keychain(service: "com.swifty.keychain")
    private let accessTokenKey = KeychainKey<String>(key: "accessToken")
    private let passwordKey = KeychainKey<String>(key: "passwordKey")
    private var id: Int = 0
    private let defaults = UserDefaults.standard

    public init() {
        authClient = AuthClient(token: nil)
        profileClient = ProfileClient(token: nil)
    }

    public func getUserEmail() -> String {
        var email: String = ""
        profileClient.getProfile(completion: { result in
            switch result {
            case .success(let user):
                email = user.username
            case .failure: break
            }
        })

        return email
    }

    public func logInUser(email: String,
                          password: String,
                          onFinish: @escaping ((Result<LogInResponse, ClientError>) -> Void)) {
        authClient.getToken(username: email, password: password) { result in
            switch result {
            case .success(let resp):
                try? self.keychain.set(resp.token, for: self.accessTokenKey)
                try? self.keychain.set(password, for: self.passwordKey)
                DispatchQueue.main.async {
                    onFinish(result)
                }
            case .failure:
                DispatchQueue.main.async {
                    onFinish(result)
                }
            }
        }
    }

    public func registerUser(email: String,
                             password: String,
                             onFinish: @escaping ((Result<SignUpResponse, ClientError>) -> Void)) {
        authClient.registerUser(username: email, password: password, completion: { res in
            switch res {
            case .success(let resp):
                self.id = resp.id
                self.logInUser(email: email, password: password, onFinish: { usr in
                    switch usr {
                    case .success:
                        DispatchQueue.main.async {
                            onFinish(res)
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            onFinish(res)
                        }
                    }
                })
                DispatchQueue.main.async {
                    onFinish(res)
                }
            case .failure: break
            }
        })
    }

    public func changePassword(email: String,
                               oldPassword: String,
                               newPassword: String,
                               onFinish: @escaping ((Bool) -> Void)) {

        profileClient.changePassword(oldPassword: oldPassword,
                                     newPassword: newPassword,
                                     completion: { res in
            switch res {
            case .success:
                let authClient = AuthClient(token: nil)
                authClient.getToken(username: email, password: newPassword, completion: { res in
                    switch res {
                    case .success(let success):
                        try? self.keychain.set(success.token, for: self.accessTokenKey)
                        DispatchQueue.main.async {
                            onFinish(true)
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            onFinish(false)
                        }
                    }
                })
            case .failure:
                DispatchQueue.main.async {
                    onFinish(false)
                }
            }
        })
    }

    public func getDaysUsing() -> Int {
        var date: Date = Date.now
        var days: Int = 0
        profileClient.getProfile(completion: { res in
            switch res {
            case .success(let success):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
                date = dateFormatter.date(from: success.dateJoined) ?? Date.now
                days = Int(Date.now.timeIntervalSince1970 - date.timeIntervalSince1970)
                // return days
            case .failure: break
            }
        })

        return days
    }

    public func logOut(onFinish: @escaping ((Bool) -> Void)) {
        try? keychain.remove(accessTokenKey)
        DispatchQueue.main.async {
            onFinish(true)
        }
    }

    public func isUserAuthenticated() -> Bool {
        let value = try? keychain.get(accessTokenKey)
        return value != nil
    }

    public func getUserId() -> Int {
        id
    }

    func getStatistics() -> [String: Int] {
        defaults.dictionary(forKey: "stats") as? [String: Int] ?? [String: Int]()
    }

    // раскомментирую когда починю (сори)

//    func saveUserDefaults(user: User) {
//        let dict = ["daysOfUse": user.daysOfUse,
//                    "decksCount": user.decksCount,
//                    "timesRepeated": user.timesRepeated,
//                    "wordsLearned": user.wordsLearned]
//        defaults.set(dict, forKey: "stats")
//    }
//
//    func getUser() -> User {
//        let stats = getStatistics()
//        let daysOfUse: Int = stats["daysOfUse"] ?? 0
//        let wordsLearned: Int = stats["wordsLearned"] ?? 0
//        let decksCreated: Int = stats["decksCreated"] ?? 0
//        let timesRepeated: Int = stats["timesRepeated"] ?? 0
//
//        let id = getUserId()
//        let email = getUserEmail()
//        return User(id: id, email: email, daysOfUse: daysOfUse, wordsLearned: wordsLearned, decksCount: decksCreated, timesRepeated: timesRepeated)
//    }
}
