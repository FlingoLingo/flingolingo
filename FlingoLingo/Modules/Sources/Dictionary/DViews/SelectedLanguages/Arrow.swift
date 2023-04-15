//
//  Arrow.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import Foundation
import UIKit

class Arrow: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        tintColor = .white
        setImage()
    }

    func setImage() {
        self.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
