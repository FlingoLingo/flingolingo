//
//  ProfileViewSkeleton.swift
//  
//
//  Created by Алиса Вышегородцева on 20.04.2023.
//

import SwiftUI
import SkeletonUI
import UIComponents

struct ProfileViewSkeleton: View {

    var body: some View {
        ZStack {
            SColors.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: CommonConstants.bigSpacing) {
                HStack {
                    Text(NSLocalizedString("profile", comment: ""))
                        .font(Font(Fonts.largeTitle))
                        .foregroundColor(SColors.mainText)
                    Spacer()
                    Icons.settings
                        .foregroundColor(SColors.mainText)
                        .skeleton(with: true)
                        .shape(type: .rounded(.radius(3, style: .circular)))
                        .frame(width: 24, height: 24)
                }

                Rectangle()
                    .skeleton(with: true)
                    .shape(type: .rounded(.radius(CommonConstants.textFieldCornerRadius, style: .circular)))
                    .frame(width: 170, height: 33)
                    .padding(.top, 21)

                VStack(spacing: 16) {
                    ForEach((1...4), id: \.self) { _ in
                        Rectangle()
                            .skeleton(with: true)
                            .shape(type: .rounded(.radius(CommonConstants.textFieldCornerRadius, style: .circular)))
                            .frame(height: 33)
                    }
                }
                .padding(.top, 22)

                Spacer()
                Rectangle()
                .skeleton(with: true)
                .shape(type: .rounded(.radius(CommonConstants.cornerRadius, style: .circular)))
                .frame(height: 54)
                .padding(.bottom, CommonConstants.bottomPadding)
            }
            .padding(.horizontal, CommonConstants.bigSpacing)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewSkeleton()
    }
}
