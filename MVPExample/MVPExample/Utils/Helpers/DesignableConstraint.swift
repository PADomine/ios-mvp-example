//
//  DesignableConstraint.swift
//  MVPExample
//
//  Created by Fernando Gonzalez on 1/30/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class DesignableConstraint: NSLayoutConstraint {
    
    @IBInspectable
    var iPhoneSE: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 568 {
                constant = iPhoneSE
            }
        }
    }
    
    @IBInspectable
    var iPhone: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 667 {
                constant = iPhone
            }
        }
    }
    
    @IBInspectable
    var iPhonePlus: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 736 {
                constant = iPhonePlus
            }
        }
    }

    @IBInspectable
    var iPhoneX: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 812 {
                constant = iPhoneX
            }
        }
    }

    @IBInspectable
    var iPhoneXMaxAndXr: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 896 {
                constant = iPhoneXMaxAndXr
            }
        }
    }
}
