//
//  DeckInfoView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckInfoView: View {
    // MARK: - Constants
    enum Constants {
        static let wordsCount: Int = 22
        static let wordsLearned: Int = 14
        static let repetitionDate: Date = Date.now
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: CommonConstants.smallStackSpacing) {
            Text("Всего слов: \(Constants.wordsCount)")
                .font(Font(Fonts.mainText))
                .foregroundColor(Color(ColorScheme.mainText))
            Text("Слов изучено: \(Constants.wordsLearned)")
                .font(Font(Fonts.mainText))
                .foregroundColor(Color(ColorScheme.mainText))
            Text("Последний раз повторяли: \(Constants.repetitionDate.formatted(.dateTime.day().month().year()))")
                .font(Font(Fonts.mainText))
                .foregroundColor(Color(ColorScheme.mainText))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, CommonConstants.smallSpacing)
        .background(Color(ColorScheme.darkBackground))
        .cornerRadius(CommonConstants.cornerRadius)
    }
}
