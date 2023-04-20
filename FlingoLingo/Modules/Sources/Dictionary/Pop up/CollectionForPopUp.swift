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
        collectionView.contentInset.left = 70
        collectionView.contentInset.right = 70
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }
}
