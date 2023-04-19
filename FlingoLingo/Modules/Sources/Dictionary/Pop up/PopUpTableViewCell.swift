//
//  PopUpTableViewCell.swift
//  
//
//  Created by Yandex on 17.04.2023.
//

import UIKit
import UIComponents

public class PopUpTableViewCell: UICollectionViewCell {
    lazy var deckName = UILabel()
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        layer.cornerRadius = CommonConstants.cornerRadius
        backgroundColor = ColorScheme.darkBackground
        cellSettings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func cellSettings() {
        contentView.addSubview(deckName)
        deckName.translatesAutoresizingMaskIntoConstraints = false
        deckName.textColor = ColorScheme.mainText
        deckName.textAlignment = .center
        NSLayoutConstraint.activate([
            deckName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            deckName.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            deckName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deckName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
