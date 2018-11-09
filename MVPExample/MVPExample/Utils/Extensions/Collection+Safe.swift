//
//  Collection+Safe.swift
//  MVPExample
//
//  Created by Pablo Dominé on 09/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
