import Foundation

public struct User: Identifiable {

    public let id: Int
    public let email: String
    public let daysOfUse: Int
    public let wordsLearned: Int
    public let decksCount: Int
    public let timesRepeated: Int

    public init(id: Int,
                email: String,
                daysOfUse: Int,
                wordsLearned: Int,
                decksCount: Int,
                timesRepeated: Int) {
        self.id = id
        self.email = email
        self.daysOfUse = daysOfUse
        self.wordsLearned = wordsLearned
        self.decksCount = decksCount
        self.timesRepeated = timesRepeated
    }
}

extension User {
    public init() {
        self.id = 0
        self.email = "mock"
        self.daysOfUse = 10
        self.wordsLearned = 20
        self.decksCount = 30
        self.timesRepeated = 40
    }
}
