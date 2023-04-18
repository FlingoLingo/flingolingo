//
//  File.swift
//  
//
//  Created by Yandex on 17.04.2023.
//

import Foundation
import UIKit

class CollectionViews {
    static func collectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: 0,
                                                            height: 0),
                                              collectionViewLayout: layout)
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        return collectionView
    }
}
