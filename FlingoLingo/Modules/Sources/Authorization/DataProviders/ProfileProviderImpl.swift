import Foundation
import NetworkLayer
import SwiftyKeychainKit

public class ProfileProviderImpl: ProfileProvider {

    private let keychain: Keychain = Keychain(service: "com.swifty.keychain")
    private let accessTokenKey = KeychainKey<String>(key: "accessToken")
    private var id: Int = 0
    private let defaults = UserDefaults.standard

    public var domainProfile: DomainProfile?

    public init() {
    }

    public func logInUser(email: String,
                          password: String,
                          onFinish: @escaping ((Result<DomainProfile, ClientError>) -> Void)) {
        let authClient = AuthClient(token: try? self.keychain.get(accessTokenKey))
        authClient.getToken(username: email, password: password) { res in
            DispatchQueue.main.async {
                switch res {
                case .success(let success):
                    let profileClient = ProfileClient(token: success.token)
                    try? self.keychain.set(success.token, for: self.accessTokenKey)
                    profileClient.getProfile { result in
                        switch result {
                        case .success(let success):
                            onFinish(.success(DomainProfile(getProfileResponse: success)))
                        case .failure(let failure):
                            onFinish(.failure(failure))
                        }
                    }
                case .failure(let failure):
                    onFinish(.failure(failure))
                }
            }
        }
    }

    public func registerUser(email: String,
                             password: String,
                             onFinish: @escaping ((Result<DomainProfile, ProfileError>) -> Void)) {
        let authClient = AuthClient(token: try? self.keychain.get(accessTokenKey))
        authClient.registerUser(username: email, password: password, completion: { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let resp):
                    self?.id = resp.id
                    self?.logInUser(email: email, password: password, onFinish: { usr in
                        switch usr {
                        case .success(let user):
                            onFinish(.success(user))
                        case .failure(let failure):
                            onFinish(.failure(.client(failure)))
                        }
                    })
                case .failure(let failure):
                    onFinish(.failure(.client(failure)))
                }
            }
        })
    }

    public func changePassword(email: String,
                               oldPassword: String,
                               newPassword: String,
                               onFinish: @escaping ((Bool) -> Void)) {

        let profileClient = ProfileClient(token: try? self.keychain.get(accessTokenKey))
        profileClient.changePassword(oldPassword: oldPassword,
                                     newPassword: newPassword,
                                     completion: { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success:
                    let authClient = AuthClient(token: nil)
                    authClient.getToken(username: email, password: newPassword, completion: { [weak self] res in
                        guard let self = self else { return }
                        switch res {
                        case .success(let success):
                            try? self.keychain.set(success.token, for: self.accessTokenKey)
                            onFinish(true)
                        case .failure:
                            onFinish(false)
                        }
                    })
                case .failure:
                    onFinish(false)
                }
            }
        })
    }

    public func getProfile(onFinish: @escaping ((Result<DomainProfile, ClientError>) -> Void)) {
        let profileClient = ProfileClient(token: try? self.keychain.get(accessTokenKey))
        profileClient.getProfile(completion: { res in
            switch res {
            case .success(let success):
                onFinish(.success(DomainProfile(getProfileResponse: success)))
            case .failure(let failure):
                onFinish(.failure(failure))
            }
        })
    }

    public func setDomainProfile(domainProfile: DomainProfile) {
        self.domainProfile = domainProfile
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

    func getStatistics() -> [String: Int] {
        defaults.dictionary(forKey: "stats") as? [String: Int] ?? [String: Int]()
    }
}
