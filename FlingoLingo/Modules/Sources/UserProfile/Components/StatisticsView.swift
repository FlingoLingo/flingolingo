import SwiftUI
import UIComponents

struct StatisticsView: View {

    @StateObject var viewModel: UserViewModel
    private let formatter: ProfileFormatter = .init()

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: CommonConstants.smallSpacing) {
                HStack {
                    Text(NSLocalizedString("userDays", comment: ""))
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberDaysStudying(user: viewModel.user))
                }
                HStack {
                    Text(NSLocalizedString("wordsLearned", comment: ""))
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberWordsLearned(user: viewModel.user))
                }
                HStack {
                    Text(NSLocalizedString("decksCreated", comment: ""))
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberDecksCreated(user: viewModel.user))
                }
                HStack {
                    Text(NSLocalizedString("timesRepeated", comment: ""))
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberTimesRepeated(user: viewModel.user))
                }
            }
        }
    }
}
