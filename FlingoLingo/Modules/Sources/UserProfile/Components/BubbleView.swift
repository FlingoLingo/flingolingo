import SwiftUI
import UIComponents

struct BubbleView: View {
    var bubbleText: String

    var body: some View {
        VStack {
            Text(bubbleText)
                .foregroundColor(SColors.accent)
                .font(Font(Fonts.cardsText))
                .padding(.vertical, 9)
                .padding(.horizontal, 15)
        }
        .background(SColors.accent).opacity(0.25)
        .cornerRadius(CommonConstants.cornerRadius)
    }
}
