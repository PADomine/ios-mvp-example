//
//  UILabel+Utils.swift
//  MVPExample
//
//  Created by Pablo Dominé on 3/10/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setLetterSpacing(_ letterSpacing: CGFloat) {
        
        guard let stringValue = self.text else {
            return
        }
        let alignment: NSTextAlignment = self.textAlignment
        //        NSMutableAttributedString(attributedString: self.attributedText)
        let attrString = NSMutableAttributedString(string: stringValue)
        attrString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: stringValue.count)) // default letterSpacing = self.font.pointSize * 0.1
        
        self.attributedText = attrString
        self.textAlignment = alignment
    }
    
    func setLineHeight(_ lineHeight: CGFloat) {
        
        guard let stringValue = self.text else {
            return
        }
        let alignment: NSTextAlignment = self.textAlignment
        let attrString = NSMutableAttributedString(string: stringValue)
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.lineBreakMode = .byTruncatingTail
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.count))
        
        self.attributedText = attrString
        self.textAlignment = alignment
    }

    func underline() {
        guard let stringValue = self.text else {
            return
        }

        let attributedString = NSMutableAttributedString(string: stringValue)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length - 1))
        self.attributedText = attributedString
    }
}
