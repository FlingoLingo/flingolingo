//
//  FinishMessageView.swift
//  
//
//  Created by Alexander Muratov on 4/18/23.
//

import SwiftUI
import UIComponents

struct FinishMessageView: View {
    var body: some View {
        VStack(spacing: CommonConstants.smallSpacing) {
            Text("wellDone")
                .font(SFonts.buttonTitle)
                .foregroundColor(SColors.mainText)
            Text("keepUpTheGoodWork")
                .font(SFonts.mainText)
                .foregroundColor(SColors.secondaryText)
        }
    }
}
