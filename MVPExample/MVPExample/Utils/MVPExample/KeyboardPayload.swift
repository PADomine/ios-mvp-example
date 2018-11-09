//
//  KeyboardPayload.swift
//  MVPExample
//
//  Created by Pablo Dominé on 27/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import UIKit

struct KeyboardPayload {
    let beginFrame: CGRect
    let endFrame: CGRect
    let animationOptions: UIView.AnimationOptions
    let duration: TimeInterval
    let isLocal: Bool

    init(note: Notification) {
        let userInfo = note.userInfo
        // swiftlint:disable all
        beginFrame = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        endFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        animationOptions = UIView.AnimationOptions(rawValue: userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt)
        duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        isLocal = userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as! Bool
    }
}
