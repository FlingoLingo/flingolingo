//
//  CardSkeletonView.swift
//  
//
//  Created by Алиса Вышегородцева on 20.04.2023.
//

import SwiftUI
import UIComponents

struct CardSkeletonView: View {
    var body: some View {
        Rectangle()
            .skeleton(with: true)
            .shape(type: .rectangle)
            .frame(maxWidth: .infinity)
            .cornerRadius(CommonConstants.cornerRadius)
            .frame(height: 71)
    }
}
