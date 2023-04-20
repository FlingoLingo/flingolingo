import SwiftUI
import UIComponents

struct StatisticsView: View {

    @StateObject var viewModel: ProfileViewModel
    private let formatter: ProfileFormatter = .init()

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: CommonConstants.smallSpacing) {
                HStack {
                    Text("userDays")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(
                        bubbleText: formatter.formatNumberDaysStudying(
                            daysOfUse: viewModel.getStatistics()["daysOfUse"] ?? 0))
                }
                HStack {
                    Text("wordsLearned")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(
                        bubbleText: formatter.formatNumberWordsLearned(
                            wordsLearned: viewModel.getStatistics()["wordsLearned"] ?? 0))
                }
                HStack {
                    Text("decksCreated")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(
                        bubbleText: formatter.formatNumberDecksCreated(
                            decksCount: viewModel.getStatistics()["decksCount"] ?? 0))
                }
                HStack {
                    Text("timesRepeated")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(
                        bubbleText: formatter.formatNumberTimesRepeated(
                            timesRepeated: viewModel.getStatistics()["timesRepeated"] ?? 0))
                }
            }
        }
    }
}
