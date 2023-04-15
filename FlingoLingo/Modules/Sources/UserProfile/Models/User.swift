import Foundation

public struct User: Identifiable {

    public let id: Int
    public let email: String
    public let daysOfUse: Int
    public let wordsLearned: Int
    public let decksCount: Int
    public let timesRepeated: Int

    public init(id: Int = 0, email: String = "", daysOfUse: Int = 0,
                wordsLearned: Int = 0, decksCount: Int = 0, timesRepeated: Int = 0) {
        self.id = id
        self.email = email
        self.daysOfUse = daysOfUse
        self.wordsLearned = wordsLearned
        self.decksCount = decksCount
        self.timesRepeated = timesRepeated
    }
}
