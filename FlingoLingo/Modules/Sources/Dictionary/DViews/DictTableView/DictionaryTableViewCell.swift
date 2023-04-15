//
//  DictionaryTableViewCell.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import UIKit

class DictionaryTableViewCell: UITableViewCell {

    var word = UILabel()
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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

    }
    func cellSettings() {
        self.backgroundColor = .black
        word.textColor = .white
        word.font = UIFont(name: "Furuta Bold", size: 15)
        word.text = "Слово"

        contentView.addSubview(word)
        word.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            word.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            word.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])

    }

}
