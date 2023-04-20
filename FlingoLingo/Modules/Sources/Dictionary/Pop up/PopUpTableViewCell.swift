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
        selectedBackgroundView = UIView()
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
            deckName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                              constant: CommonConstants.smallSpacing),
            deckName.leadingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                              constant: -CommonConstants.smallSpacing),
            deckName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deckName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

public class NewDeckPopUpTableViewCell: UICollectionViewCell {
    lazy var deckName = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        layer.cornerRadius = CommonConstants.cornerRadius
        backgroundColor = ColorScheme.darkBackground
        selectedBackgroundView = UIView()
        cellSettings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func cellSettings() {
        contentView.addSubview(deckName)
        deckName.translatesAutoresizingMaskIntoConstraints = false
        deckName.image = UIImage(systemName: "plus")
        deckName.contentMode = .scaleAspectFit
        deckName.tintColor = ColorScheme.mainText
        NSLayoutConstraint.activate([
            deckName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                              constant: CommonConstants.smallSpacing + 5),
            deckName.leadingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                              constant: -CommonConstants.smallSpacing - 5),
            deckName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deckName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deckName.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: CommonConstants.smallSpacing + 5),
            deckName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: -CommonConstants.smallSpacing - 5)
        ])
    }
}
