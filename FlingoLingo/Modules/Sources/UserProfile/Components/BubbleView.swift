import SwiftUI
import UIComponents

struct BubbleView: View {
    var bubbleText: String
    
    var body: some View {
        VStack {
            Text(bubbleText)
                .foregroundColor(Color(ColorScheme.accent))
                .font(Font(Fonts.cardsText))
                .padding(.vertical, 9)
                .padding(.horizontal, 15)
        }
        .background(Color(ColorScheme.accent).opacity(0.25))
        .cornerRadius(20)
    }
}

