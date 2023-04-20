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
                            daysOfUse: viewModel.getStatistics(for: .daysOfUse)))
                }
                HStack {
                    Text("wordsLearned")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(
                        bubbleText: formatter.formatNumberWordsLearned(
                            wordsLearned: viewModel.getStatistics(for: .wordsLearned)))
                }
                HStack {
                    Text("decksCreated")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(
                        bubbleText: formatter.formatNumberDecksCreated(
                            decksCount: viewModel.getStatistics(for: .decksCount)))
                }
                HStack {
                    Text("timesRepeated")
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(
                        bubbleText: formatter.formatNumberTimesRepeated(
                            timesRepeated: viewModel.getStatistics(for: .timesRepeated)))
                }
            }
        }
    }
}
