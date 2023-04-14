//
//  DTableFuncs.swift
//  FlingoLingo
//
//  Created by Yandex on 13.04.2023.
//

import Foundation
import UIKit

extension DictionaryViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DTableViewCell", for: indexPath) as! DictionaryTableViewCell
        let verticalPadding: CGFloat = CGFloat(tableSpacing)
           let maskLayer = CALayer()
           maskLayer.cornerRadius = CGFloat(tableSpacing)    //if you want round edges
           maskLayer.backgroundColor = UIColor.black.cgColor
           maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
           cell.layer.mask = maskLayer
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableSpacing {
            case 10 : return tableView.frame.height / 8
        default:
            return (tableView.frame.height + 5) / 5
        }
    }
}
