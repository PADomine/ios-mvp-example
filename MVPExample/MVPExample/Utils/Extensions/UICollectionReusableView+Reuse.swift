//
//  UICollectionReusableView+Reuse.swift
//  MVPExample
//
//  Created by Pablo Dominé on 9/22/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    static func registerCell(_ collectionView: UICollectionView) {
        let nib = UINib(nibName: reuseId, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseId)
    }

    static func registerSupplementaryViewNib(_ collectionView: UICollectionView, forKind kind: String) {
        let nib = UINib(nibName: reuseId, bundle: nil)
        collectionView.register(nib,
                                forSupplementaryViewOfKind: kind,
                                withReuseIdentifier: reuseId)
    }
}
