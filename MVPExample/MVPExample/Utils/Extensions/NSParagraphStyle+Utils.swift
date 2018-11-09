//
//  NSParagraphStyle+Utils.swift
//  MVPExample
//
//  Created by Pablo Dominé on 3/10/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import UIKit

extension NSParagraphStyle {
    
    class func styleWith(lineHeightMultiple: CGFloat,
                         lineBreakMode: NSLineBreakMode? = nil,
                         alignment: NSTextAlignment? = nil) -> NSParagraphStyle {
        
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = lineHeightMultiple
        
        if let lineMode = lineBreakMode {
            style.lineBreakMode = lineMode
        }
        
        if let lineAlignment = alignment {
            style.alignment = lineAlignment
        }
        
        return style
    }
}
