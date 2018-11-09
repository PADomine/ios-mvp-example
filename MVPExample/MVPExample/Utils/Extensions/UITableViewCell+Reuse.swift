//
//  UITableViewCell+Reuse.swift
//  MVPExample
//
//  Created by Pablo Dominé on 9/22/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var reuseId: String {
        return String(describing: self)
    }
}
