import Foundation
import NetworkLayer

public struct DomainProfile: Identifiable {
    public let id: Int
    public let email: String
    public var dateJoined: String = ""

    public init(signUpResponse: SignUpResponse) {
        self.id = signUpResponse.id
        self.email = signUpResponse.username
    }

    public init(getProfileResponse: GetProfileResponse) {
        self.id = getProfileResponse.id
        self.email = getProfileResponse.username
        self.dateJoined = getProfileResponse.dateJoined
    }
}
