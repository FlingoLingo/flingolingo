//
//  Languge.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import Foundation
import UIKit
import UIComponents

class Language: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    // задаем красивый заголовок
    func setTitle(_ title: String?) {
        let font = Fonts.mainText
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: title ?? "не выбрано", attributes: attributes as [NSAttributedString.Key: Any])
        setAttributedTitle(attributedTitle, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
