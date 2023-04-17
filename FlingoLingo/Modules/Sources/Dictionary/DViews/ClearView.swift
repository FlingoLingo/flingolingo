//
//  File.swift
//  
//
//  Created by Yandex on 15.04.2023.
//

import Foundation
import UIKit
import UIComponents

final class ClearView: UIView {
    let button = ClearButton()
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setting()
    }

    func setting() {
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            self.widthAnchor.constraint(equalToConstant: 35)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ClearButton: UIButton {

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
