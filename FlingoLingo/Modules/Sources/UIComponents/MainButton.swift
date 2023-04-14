//
//  MainButton.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public class MainButton: UIButton {

    // MARK: - Properties
    private let buttonCornerRadius: CGFloat = 20

    // MARK: - Initialization
    public convenience init(title: String,
                            titleColor: UIColor,
                            backgroundColor: UIColor) {
        self.init()

        layer.cornerRadius = buttonCornerRadius
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = Fonts.buttonTitle
        self.backgroundColor = backgroundColor
    }
}
