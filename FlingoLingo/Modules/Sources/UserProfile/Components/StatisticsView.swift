import SwiftUI
import UIComponents

struct StatisticsView: View {

    @StateObject var viewModel: UserViewModel
    private let formatter: ProfileFormatter = .init()

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: CommonConstants.smallSpacing) {
                HStack {
                    Text("userDays")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberDaysStudying(user: viewModel.user))
                }
                HStack {
                    Text("wordsLearned")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberWordsLearned(user: viewModel.user))
                }
                HStack {
                    Text("decksCreated")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberDecksCreated(user: viewModel.user))
                }
                HStack {
                    Text("timesRepeated")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberTimesRepeated(user: viewModel.user))
                }
            }
        }
    }
}
