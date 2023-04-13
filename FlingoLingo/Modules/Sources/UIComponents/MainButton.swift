//
//  MainButton.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public class MainButton: UIButton {
    
    // MARK: - Initialization
    public convenience init(title: String,
                            titleColor: UIColor,
                            backgroundColor: UIColor) {
        self.init()

        layer.cornerRadius = 20
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = Fonts.title
        self.backgroundColor = backgroundColor
    }
}
