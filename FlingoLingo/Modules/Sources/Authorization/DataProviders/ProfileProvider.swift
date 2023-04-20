import NetworkLayer

public enum ProfileError: Error {
    case client(ClientError)
}

public protocol ProfileProvider: AnyObject {

    var domainProfile: DomainProfile? { get set }

    func logInUser(email: String, password: String, onFinish: @escaping ((Result<DomainProfile, ClientError>) -> Void))

    func registerUser(email: String,
                      password: String,
                      onFinish: @escaping ((Result<DomainProfile, ProfileError>) -> Void))

    func changePassword(email: String,
                        oldPassword: String,
                        newPassword: String,
                        onFinish: @escaping ((Bool) -> Void))

    func logOut()

    func getProfile(onFinish: @escaping ((Result<DomainProfile, ClientError>) -> Void))
}
