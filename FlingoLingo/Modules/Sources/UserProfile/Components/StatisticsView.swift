import SwiftUI
import UIComponents

struct StatisticsView: View {

    @StateObject private var viewModel: UserViewModel = UserViewModel()

    enum Constants {
        static let email: String = "hello@world.ru"
        static let days: Int = 0
        static let words: Int = 3
        static let decks: Int = 20
        static let times: Int = 136
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Вы с нами уже ")
                        .foregroundColor(Color(ColorScheme.mainText))
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: "\(viewModel.user.daysOfUse) дней")
                }
                HStack {
                    Text("Выучили ")
                        .foregroundColor(Color(ColorScheme.mainText))
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: "\(viewModel.user.wordsLearned) слов")
                }
                HStack {
                    Text("Создали ")
                        .foregroundColor(Color(ColorScheme.mainText))
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: "\(viewModel.user.decksCount) колод")
                }
                HStack {
                    Text("Повторили слова ")
                        .foregroundColor(Color(ColorScheme.mainText))
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: "\(viewModel.user.timesRepeated) раз")
                }
            }
        }
    }
}
