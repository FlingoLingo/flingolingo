//
//  InfoTextField.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public class InformationTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Initialization
    public convenience init(placeholderText: String) {
        self.init()
        
        font = Fonts.searchText
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: ColorScheme.inactive]
        )
        textColor = ColorScheme.mainText
        layer.borderColor = ColorScheme.inactive.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = CommonConstants.textFieldCornerRadius
        contentVerticalAlignment = .center
    }
}
