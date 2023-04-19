// typealias ItemsResult = Result<[String], Error>

public protocol ProfileProvider: AnyObject {

//    func getItems(onFinish: @escaping ((ItemsResult) -> Void))

    func logInUser(email: String, password: String, onFinish: @escaping ((Bool) -> Void))

    func registerUser(email: String, password: String, onFinish: @escaping ((Bool) -> Void))

    func changePassword(email: String, oldPassword: String, newPassword: String, onFinish: @escaping ((Bool) -> Void))

    func logOut(email: String, onFinish: @escaping ((Bool) -> Void))
    
    func getUserEmail() -> String
    
    func getUserId() -> Int
}
