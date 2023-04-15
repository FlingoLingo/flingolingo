import SwiftUI
import UIComponents

struct StatisticsView: View {

    @StateObject private var viewModel: UserViewModel = UserViewModel()
    private let formatter: ProfileFormatter = .init()

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: CommonConstants.smallSpacing) {
                HStack {
                    Text(formatter.formatDaysStudying())
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberDaysStudying(user: viewModel.user))
                }
                HStack {
                    Text(formatter.formatWordsLearned())
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberWordsLearned(user: viewModel.user))
                }
                HStack {
                    Text(formatter.formatDecksCreated())
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberDecksCreated(user: viewModel.user))
                }
                HStack {
                    Text(formatter.formatTimesRepeated())
                        .foregroundColor(SColors.mainText)
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: formatter.formatNumberTimesRepeated(user: viewModel.user))
                }
            }
        }
    }
}
