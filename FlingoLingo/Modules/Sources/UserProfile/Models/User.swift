import Foundation

public struct User: Identifiable {

    public let id: Int
    public let email: String
    public let daysOfUse: Int
    public let wordsLearned: Int
    public let decksCount: Int
    public let timesRepeated: Int

    public init(id: Int = 0,
                email: String = "testtest",
                daysOfUse: Int = 2,
                wordsLearned: Int = 5,
                decksCount: Int = 6,
                timesRepeated: Int = 9) {
        self.id = id
        self.email = email
        self.daysOfUse = daysOfUse
        self.wordsLearned = wordsLearned
        self.decksCount = decksCount
        self.timesRepeated = timesRepeated
    }
}
