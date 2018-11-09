//
//  Style.swift
//  MVPExample
//
//  Created by Pablo Dominé.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit

struct Style {
    
    struct Color {
        private static let primary = UIColor(named: "PrimaryColor")!
        private static let secondary = UIColor(named: "SecondaryColor")!

        static let white = UIColor.white
        static let black = UIColor.black
        static let clear = UIColor.clear

        static let navigationBarBackground = white
        static let navigationBarTint = black
        static let background = white
        static let titleText = black
        static let barButtonTitle = clear
//        static let progressView = primary
//        static let bodyText = blackOne
//        static let secondaryText = gray
//        static let termsText = grayTwo
//        static let inputActive = primary
//        static let inputInactive = grayTwo
//        static let inputError = red
//        static let inputText = blackOne
//        static let buttonBackgroundEnable = primary
//        static let buttonBackgroundDisable = grayThree
//        static let pinInputBackgroundEnable = primary
//        static let pinInputBackgroundDisable = grayTwo
//        static let pinInputBackgroundError = red
//        static let pinInputText = blackOne
//        static let pinInputPlaceholderText = grayTwo
    }

    struct Font {
        enum Name: String {
            // GothamHTF
            case gothamHTFXLightItalic = "GothamHTF-XLightItalic"
            case gothamHTFBlackItalic = "GothamHTF-BlackItalic"
            case gothamHTFLightItalic = "GothamHTF-LightItalic"
            case gothamHTFThin = "GothamHTF-Thin"
            case gothamHTFBookCondensed = "GothamHTF-BookCondensed"
            case gothamHTFBook = "GothamHTF-Book"
            case gothamHTFMediumCondensed = "GothamHTF-MediumCondensed"
            case gothamHTFUltra = "GothamHTF-Ultra"
            case gothamHTFXlight = "GothamHTF-XLight"
            case gothamHTFMedium = "GothamHTF-Medium"
            case gothamHTFBookItalic = "GothamHTF-BookItalic"
            case gothamHTFUltraItalic = "GothamHTF-UltraItalic"
            case gothamHTFThinItalic = "GothamHTF-ThinItalic"
            case gothamHTFBlack = "GothamHTF-Black"
            case gothamHTFBoldItalic = "GothamHTF-BoldItalic"
            case gothamHTFLightCondensed = "GothamHTF-LightCondensed"
            case gothamHTFBoldCondensed = "GothamHTF-BoldCondensed"
            case gothamHTFBold = "GothamHTF-Bold"
            case gothamHTFLight = "GothamHTF-Light"
        }

        static func with(name: Name, size: CGFloat) -> UIFont {
            let name = name.rawValue

            guard let customFont = UIFont(name: name, size: size) else {
                fatalError("""
                Failed to load the \(name) font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """)
            }

            return customFont
        }
    }

//    struct UI {
//        static let modalCornerRadius: CGFloat = 5
//    }
}

extension Style {
    static func configureAppearance() {
        configure(appearance: UINavigationBar.appearance())
        configure(appearance: UIBarButtonItem.appearance())
    }

    fileprivate static func configure(appearance: UINavigationBar) {
        appearance.prefersLargeTitles = true
        appearance.barTintColor = Color.navigationBarBackground
        appearance.isTranslucent = false
        appearance.tintColor = Color.navigationBarTint

        let titleFont = Font.with(name: .gothamHTFMedium, size: 18)
        appearance.titleTextAttributes = [.font: titleFont,
                                          .foregroundColor: Color.titleText]

        let largeTitleFont = Font.with(name: .gothamHTFBold, size: 28)
        appearance.largeTitleTextAttributes = [.font: largeTitleFont,
                                          .foregroundColor: Color.titleText]
    }
    
    fileprivate static func configure(appearance: UIBarButtonItem) {
        // This is to have the back button title erase
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: Color.barButtonTitle]

        appearance.setTitleTextAttributes(attributes, for: UIControl.State())
    }
}
