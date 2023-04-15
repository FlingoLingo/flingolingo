import SwiftUI
import UIComponents

struct StatisticsView: View {

    @StateObject var viewModel: UsersViewModel

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
                    BubbleView(bubbleText: "\(viewModel.users[0].daysOfUse ?? 0) дней")
                }
                HStack {
                    Text("Выучили ")
                        .foregroundColor(Color(ColorScheme.mainText))
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: "\(viewModel.users[0].wordsLearned ?? 0) слов")
                }
                HStack {
                    Text("Создали ")
                        .foregroundColor(Color(ColorScheme.mainText))
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: "\(viewModel.users[0].decksCount ?? 0) колод")
                }
                HStack {
                    Text("Повторили слова ")
                        .foregroundColor(Color(ColorScheme.mainText))
                        .font(Font(Fonts.mainText))
                    BubbleView(bubbleText: "\(viewModel.users[0].timesRepeated ?? 0) раз")
                }
            }
        }
    }
}
