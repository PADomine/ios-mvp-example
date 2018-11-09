//
//  UIDevice+UserInterfaceIdiom.swift
//  MVPExample
//
//  Created by Pablo Dominé on 9/25/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import UIKit

extension UIDevice {
    static var isPhone: Bool {
        return self.current.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        return self.current.userInterfaceIdiom == .pad
    }
}
