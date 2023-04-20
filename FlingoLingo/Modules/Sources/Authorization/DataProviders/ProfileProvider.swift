import NetworkLayer

public protocol ProfileProvider: AnyObject {

    func logInUser(email: String, password: String, onFinish: @escaping ((Result<LogInResponse, ClientError>) -> Void))

    func registerUser(email: String,
                      password: String,
                      onFinish: @escaping ((Result<SignUpResponse, ClientError>) -> Void))

    func changePassword(email: String,
                        oldPassword: String,
                        newPassword: String,
                        onFinish: @escaping ((Bool) -> Void))

    func logOut(onFinish: @escaping ((Bool) -> Void))

    func getUserEmail() -> String

    func getUserId() -> Int
}
