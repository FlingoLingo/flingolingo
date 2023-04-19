import Foundation
import NetworkLayer
import SwiftyKeychainKit

public class ProfileProviderImpl: ProfileProvider {

    private var authClient: AuthClient
    private var profileClient: ProfileClient
    private let keychain: Keychain = Keychain(service: "com.swifty.keychain")
    private let accessTokenKey = KeychainKey<String>(key: "accessToken")
    private let passwordKey = KeychainKey<String>(key: "passwordKey")
    private var id: Int = -10

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
            case .failure: break
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
                        print("hi")
                        DispatchQueue.main.async {
                            onFinish(res)
                        }
                    case .failure:
                        print("bye")
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
                self.authClient.getToken(username: email, password: newPassword, completion: { res in
                    switch res {
                    case .success(let success):
                        try? self.keychain.set(success.token, for: self.accessTokenKey)
                        DispatchQueue.main.async {
                            onFinish(true)
                        }
                    case .failure: break
                    }
                })
            case .failure: break
            }
        })
    }

    public func logOut(email: String, onFinish: @escaping ((Bool) -> Void)) {
        try? keychain.remove(accessTokenKey)
        DispatchQueue.main.async {
            onFinish(true)
        }
    }

    public func isUserAuthenticated() -> Bool {
        let value = try? keychain.get(accessTokenKey)
        return !(value?.isEmpty ?? false)
    }

    public func getUserId() -> Int {
        id
    }
}
