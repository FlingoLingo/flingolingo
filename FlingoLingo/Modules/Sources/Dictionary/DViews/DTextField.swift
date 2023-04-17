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

        let rightViewButton = ClearView()
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

class ClearView: UIView {
    let button = ClearButton()
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setting()
    }
    func setting() {
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor), button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ClearButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        tintColor = .white
        contentHorizontalAlignment = .left
        contentVerticalAlignment = .center
        setImage()
    }
    func setImage() {
        self.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SuggestionView: UIButton {
    open var suggest = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1.5
        layer.borderColor = ColorScheme.mainText.cgColor
        layer.opacity = 0.4
        isHidden = true
        layer.cornerRadius = CommonConstants.textFieldCornerRadius
    }
    override func setTitle(_ title: String?, for state: UIControl.State) {
        if title?.trimmingCharacters(in: .whitespaces) ?? "" != "" {
            super.setTitle(title, for: state)
            self.isEnabled = true
        } else {
            super.setTitle("не найдено", for: .normal)
            self.isEnabled = false
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
