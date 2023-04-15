import Foundation

public struct User: Identifiable {

    public let id: Int
    public let email: String
    public let passwordHash: String
    public var daysOfUse: Int?
    public var wordsLearned: Int?
    public var decksCount: Int?
    public var timesRepeated: Int?
//    public var decks: [Deck]
//    public let isAuthorized: Bool

    public init(id: Int, email: String, passwordHash: String, daysOfUse: Int? = 0,
                wordsLearned: Int? = 0, decksCount: Int? = 0, timesRepeated: Int? = 0) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
        self.daysOfUse = daysOfUse
        self.wordsLearned = wordsLearned
        self.decksCount = decksCount
        self.timesRepeated = timesRepeated
    }
}
