//
//  Router.swift
//  MVPExample
//
//  Created by Pablo Dominé on 11/09/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import UIKit

public final class Router {
    static func swapViewController(_ viewController: UIViewController) {
        if let delegate = UIApplication.shared.delegate {
            UIView.transition(with: delegate.window!!, duration: GlobalConstants.Animation.defaultDuration, options: .transitionCrossDissolve, animations: {
                delegate.window!!.rootViewController = viewController
            }, completion: nil)
        }
    }
}
