//
//  DTextField.swift
//  FlingoLingo
//
//  Created by Yandex on 13.04.2023.
//

import Foundation
import UIKit
import UIComponents

class DTextField: UITextField {

    override init(frame: CGRect) {

        super.init(frame: frame)
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.white.cgColor
        layer.opacity = 0.4
        layer.cornerRadius = 10

        placeholder = "Введите слово..."

        leftView = UIView(frame: CGRect(x: 0, y: 0, width: CommonConstants.bigSpacing * 0.5, height: 45))
        leftViewMode = .always

        textColor = .white

        keyboardType = .webSearch

        let rw = ClearView()
        rw.button.addTarget(self, action: #selector(clear), for: .touchUpInside)
        rightView = rw
        rightViewMode = .always

        let font = Fonts.searchText
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: placeholder!, attributes: attributes as [NSAttributedString.Key: Any])
        attributedPlaceholder = attributedTitle

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func clear() {
        self.text = ""
    }
}

class SuggestionView: UIButton {

    open var suggest = ""
    override init(frame: CGRect) {

        super.init(frame: frame)
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.white.cgColor
        layer.opacity = 0.4
        layer.cornerRadius = CommonConstants.textFieldCornerRadius

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setTitle(_ title: String?,
                           for state: UIControl.State) {
        let font = Fonts.searchText
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: suggest,
                                                 attributes: attributes as [NSAttributedString.Key: Any])
        super.setAttributedTitle(attributedTitle,
                                 for: state)
    }
}
