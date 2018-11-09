//
//  UIViewController+NetworkActivity.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/2/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func startLoadingStatusBar() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func stopLoadingStatusBar() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func removeBackwardsNavigationTitle() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
