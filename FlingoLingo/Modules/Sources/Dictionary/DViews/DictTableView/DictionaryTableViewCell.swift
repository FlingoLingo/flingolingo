//
//  DictionaryTableViewCell.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import UIKit
import UIComponents

final class DictionaryTableViewCell: UITableViewCell {

    private let wordLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "DTableViewCell")
        cellSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

    }
    func cellSettings() {
        self.backgroundColor = .black
        wordLabel.textColor = .white
        wordLabel.font = Fonts.mainText
        wordLabel.text = "Слово"

        contentView.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            wordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            wordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])

    }

}
