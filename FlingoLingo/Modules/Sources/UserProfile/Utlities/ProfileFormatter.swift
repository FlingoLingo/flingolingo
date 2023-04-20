import Foundation
import SwiftUI

struct ProfileFormatter {

    func formatNumberDaysStudying(daysOfUse: Int) -> String {
        var word = ""
        if daysOfUse % 10 == 1 {
            word = NSLocalizedString("day1", comment: "")
        } else if daysOfUse % 10 >= 2 && daysOfUse <= 4 {
            word = NSLocalizedString("day2-4", comment: "")
        } else if daysOfUse % 10 == 0 || daysOfUse % 10 >= 5 {
            word = NSLocalizedString("day05-9", comment: "")
        }

        return "\(daysOfUse) \(word)"
    }

    func formatNumberWordsLearned(wordsLearned: Int) -> String {
        var word = ""
        if wordsLearned % 10 == 1 {
            word = NSLocalizedString("word1", comment: "")
        } else if wordsLearned % 10 >= 2 && wordsLearned <= 4 {
            word = NSLocalizedString("word2-4", comment: "")
        } else if wordsLearned % 10 == 0 || wordsLearned % 10 >= 5 {
            word = NSLocalizedString("word05-9", comment: "")
        }

        return "\(wordsLearned) \(word)"
    }

    func formatNumberTimesRepeated(timesRepeated: Int) -> String {
        var word = ""
        if timesRepeated % 10 == 0 || timesRepeated % 10 == 1 || timesRepeated % 10 >= 5 {
            word = NSLocalizedString("time015-9", comment: "")
        } else {
            word = NSLocalizedString("time2-4", comment: "")
        }

        return "\(timesRepeated) \(word)"
    }

    func formatNumberDecksCreated(decksCount: Int) -> String {
        var word = ""
        if decksCount % 10 == 0 || decksCount % 10 >= 5 {
            word = NSLocalizedString("deck05-9", comment: "")
        } else if decksCount == 1 {
            word = NSLocalizedString("deck1", comment: "")
        } else if decksCount >= 2 && decksCount <= 4 {
            word = NSLocalizedString("deck2-4", comment: "")
        }

        return "\(decksCount) \(word)"
    }
}
