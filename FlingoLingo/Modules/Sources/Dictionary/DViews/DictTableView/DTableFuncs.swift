//
//  DTableFuncs.swift
//  FlingoLingo
//
//  Created by Yandex on 13.04.2023.
//

import Foundation
import UIKit
import UIComponents

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sinonimsCount != 0 {
            suggestionView.isHidden = true
        }
        return sinonimsCount

    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        popOverVC.wordName = tableData.def?.first?.text ?? ""
        popOverVC.langsApi = languagesPairApiCode
        popOverVC.transcription = tableData.def?.first?.ts ?? ""
        popOverVC.translation = tableData.def?.first?.tr?[indexPath.row].text ?? ""
        popOverVC.translatedExample = tableData.def?.first?.tr?[indexPath.row].ex?.first?.text ?? ""
        popOverVC.originalExample = tableData.def?.first?.tr?[indexPath.row].ex?.first?.tr?.first?.text ?? ""
        popOverVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(popOverVC, animated: true)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DTableViewCell",
                                                       for: indexPath) as? DictionaryTableViewCell else {
            return DictionaryTableViewCell()
        }
        let verticalPadding: CGFloat = CGFloat(tableSpacing)
           let maskLayer = CALayer()
        maskLayer.cornerRadius = CGFloat(CommonConstants.cornerRadius) 
           maskLayer.backgroundColor = UIColor.black.cgColor
           maskLayer.frame = CGRect(x: cell.bounds.origin.x,
                                    y: cell.bounds.origin.y,
                                    width: cell.bounds.width,
                                    height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
           cell.layer.mask = maskLayer
        cell.wordLabel.text = tableData.def?.first?.tr?[indexPath.row].text
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
