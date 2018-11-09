//
//  UIViewController+StoryboardConvenience.swift
//  MVPExample
//
//  Created by Pablo Dominé on 04/03/2018.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    static var storyboardId: String {
        return String(describing: self)
    }

    // When no identifier is pass, will try to instantiate VC with save identifier as it's class
    class func instantiateFromStoryboard(name: String, identifier: String? = .none, bundle: Bundle? = .none) -> Self? {
        return fromStoryboardHelper(type: self, name: name, identifier: identifier ?? String(describing: self), bundle: bundle)
    }

    class func instantiateInitialFromStoryboard(name: String, bundle: Bundle? = .none) -> Self? {
        return fromStoryboardHelper(type: self, name: name, identifier: nil, bundle: bundle)
    }

    private class func fromStoryboardHelper<T: UIViewController>(type: T.Type, name: String, identifier: String?, bundle: Bundle?) -> T? {
        if let identifier = identifier {
            return UIStoryboard(name: name, bundle: bundle).instantiateViewController(withIdentifier: identifier) as? T
        } else {
            return UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController() as? T
        }
    }
}
