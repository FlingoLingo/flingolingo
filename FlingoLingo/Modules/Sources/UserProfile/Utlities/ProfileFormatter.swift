import Foundation
import SwiftUI

struct ProfileFormatter {

    func formatNumberDaysStudying(user: User) -> String {
        var word = ""
        if user.daysOfUse % 10 == 1 {
            word = NSLocalizedString("day1", comment: "")
        } else if user.daysOfUse % 10 >= 2 && user.daysOfUse <= 4 {
            word = NSLocalizedString("day2-4", comment: "")
        } else if user.daysOfUse % 10 == 0 || user.daysOfUse % 10 >= 5 {
            word = NSLocalizedString("day05-9", comment: "")
        }

        return "\(user.daysOfUse) \(word)"
    }

    func formatNumberWordsLearned(user: User) -> String {
        var word = ""
        if user.wordsLearned % 10 == 1 {
            word = NSLocalizedString("word1", comment: "")
        } else if user.wordsLearned % 10 >= 2 && user.wordsLearned <= 4 {
            word = NSLocalizedString("word2-4", comment: "")
        } else if user.wordsLearned % 10 == 0 || user.wordsLearned % 10 >= 5 {
            word = NSLocalizedString("word05-9", comment: "")
        }

        return "\(user.wordsLearned) \(word)"
    }

    func formatNumberTimesRepeated(user: User) -> String {
        var word = ""
        if user.timesRepeated % 10 == 0 || user.timesRepeated % 10 == 1 || user.timesRepeated % 10 >= 5 {
            word = NSLocalizedString("time015-9", comment: "")
        } else {
            word = NSLocalizedString("time2-4", comment: "")
        }

        return "\(user.timesRepeated) \(word)"
    }

    func formatNumberDecksCreated(user: User) -> String {
        var word = ""
        if user.timesRepeated % 10 == 0 || user.timesRepeated % 10 >= 5 {
            word = NSLocalizedString("deck-509", comment: "")
        } else if user.decksCount == 1 {
            word = NSLocalizedString("deck1", comment: "")
        } else if user.decksCount >= 2 && user.decksCount <= 4 {
            word = NSLocalizedString("deck2-4", comment: "")
        }

        return "\(user.decksCount) \(word)"
    }
}
