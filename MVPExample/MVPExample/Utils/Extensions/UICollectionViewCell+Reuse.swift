//
//  UICollectionViewCell+Reuse.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/5/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static func registerNib(_ collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: reuseId)
    }
}
