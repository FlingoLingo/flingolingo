//
//  MainButton.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public final class MainButton: UIButton {

    // MARK: - Initialization
    public convenience init(title: String, titleColor: UIColor, backgroundColor: UIColor) {
        self.init()

        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = .init(
            top: CommonConstants.smallSpacing,
            leading: CommonConstants.smallSpacing,
            bottom: CommonConstants.smallSpacing,
            trailing: CommonConstants.smallSpacing
        )
        configuration.background.backgroundColor = backgroundColor
        configuration.background.cornerRadius = CommonConstants.cornerRadius

        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = Fonts.buttonTitle
            outgoing.foregroundColor = titleColor

            return outgoing
          }

        configuration.title = title
        self.configuration = configuration
    }
}
