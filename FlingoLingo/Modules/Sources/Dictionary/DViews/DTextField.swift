//
//  DTextField.swift
//  FlingoLingo
//
//  Created by Yandex on 13.04.2023.
//

import Foundation
import UIKit
import UIComponents

final class DTextField: UITextField {
    let rightViewButton = ClearView()
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

        rightViewButton.button.addTarget(self, action: #selector(clear), for: .touchUpInside)
        rightView = rightViewButton
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

public class SuggestionView: UIButton {
    public var suggest = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1.5
        layer.borderColor = ColorScheme.mainText.cgColor
        layer.opacity = 0.4
        isHidden = true
        layer.cornerRadius = CommonConstants.textFieldCornerRadius
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
