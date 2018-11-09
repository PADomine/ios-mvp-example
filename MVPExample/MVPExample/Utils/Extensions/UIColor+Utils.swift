//
//  UIColor+Utils.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/5/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation
import UIKit

private func colorComponent(fromByte: UInt8) -> CGFloat {
    return CGFloat(fromByte) / 255.0
}

private func colorByte(fromComponent: CGFloat) -> UInt8 {
    return UInt8(fromComponent * 255.0)
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        func confineColorValue(value: Int) -> Int {
            var adjustedValue = value
            
            adjustedValue = value > 255 ? 255 : value
            adjustedValue = value < 0 ? 0 : value
            
            return adjustedValue
        }
        
        let redConfined = confineColorValue(value: red)
        let greenConfined = confineColorValue(value: green)
        let blueConfined = confineColorValue(value: blue)
        
        self.init(red: CGFloat(redConfined) / 255.0, green: CGFloat(greenConfined) / 255.0, blue: CGFloat(blueConfined) / 255.0, alpha: alpha)
    }
    
    convenience init(rgbHex: Int, alpha: CGFloat = 1) {
        self.init(red: (rgbHex >> 16) & 0xFF, green: (rgbHex >> 8) & 0xFF, blue: rgbHex & 0xFF, alpha: alpha)
    }
    
    // swiftlint:disable large_tuple
    var rgbaComponents: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    var hexString: String {
        let (red, green, blue, _) = rgbaComponents
        return String(format: "#%02X%02X%02X", colorByte(fromComponent: red), colorByte(fromComponent: green), colorByte(fromComponent: blue))
    }

    static func colorFromHex(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) -> UIColor {
        return UIColor(red: colorComponent(fromByte: red), green: colorComponent(fromByte: green), blue: colorComponent(fromByte: blue), alpha: colorComponent(fromByte: alpha))
    }
}

extension UIColor {
    // https://stackoverflow.com/questions/14523348/how-to-change-the-background-color-of-a-uibutton-while-its-highlighted
    func toImage() -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(self.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
