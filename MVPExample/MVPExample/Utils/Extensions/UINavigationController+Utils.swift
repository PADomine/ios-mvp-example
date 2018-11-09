//
//  UINavigationController.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/4/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let visibleVC = visibleViewController {
            return visibleVC.supportedInterfaceOrientations
        }
        
        return super.supportedInterfaceOrientations
    }
    
    override open var shouldAutorotate: Bool {
        if let visibleVC = visibleViewController {
            return visibleVC.shouldAutorotate
        }
        
        return super.shouldAutorotate
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
