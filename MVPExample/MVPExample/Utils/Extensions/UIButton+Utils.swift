//
//  UIButton+Utils.swift
//  MVPExample
//
//  Created by Pablo Dominé on 20/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func underline() {
        guard let stringValue = self.titleLabel?.text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: stringValue)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: stringValue.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }

}

extension UIButton {

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.clipsToBounds = true
        self.setBackgroundImage(color.toImage(), for: state)
    }
}
