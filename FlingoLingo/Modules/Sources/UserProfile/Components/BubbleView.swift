import SwiftUI
import UIComponents

struct BubbleView: View {
    private var bubbleText: String

    public init(bubbleText: String) {
        self.bubbleText = bubbleText
    }

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
