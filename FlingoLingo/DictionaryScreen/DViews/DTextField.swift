//
//  DTextField.swift
//  FlingoLingo
//
//  Created by Yandex on 13.04.2023.
//

import Foundation
import UIKit

class DTextField: UITextField {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.white.cgColor
        layer.opacity = 0.4
        layer.cornerRadius = Constants().screenWidth * 0.025
        
        placeholder = "Введите слово..."
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants().leadingAnchor * 0.5, height: Constants().screenHeight * 0.05))
        leftViewMode = .always
        
        textColor = .white
        
        keyboardType = .webSearch
        
        let rw = clearView()
        rw.button.addTarget(self, action: #selector(clear), for: .touchUpInside)
        rightView = rw
        rightViewMode = .always
        
        let font = UIFont(name: "Futura", size: 17)
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: placeholder!, attributes: attributes as [NSAttributedString.Key : Any])
        attributedPlaceholder = attributedTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clear() {
        self.text = ""
    }
}

class clearView: UIView {
    let button = clearButton()
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setting()
    }
    
    func setting() {
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor), button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.widthAnchor.constraint(equalToConstant: Constants().screenWidth * 0.1)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class clearButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        tintColor = .white
        setImage()
    }
    
    
    func setImage() {
        self.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
