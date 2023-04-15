import SwiftUI

class UsersViewModel: ObservableObject {

    @Published var users: [User] = []

    public init() {

    }
}
