//
//  UIViewController+Alerts.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/2/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleAlert(title: String? = "ErrorTitle".localized, message: String? = "ErrorMessage".localized, buttonTitle: String = "Ok".localized) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func showSimpleAlertWithCustomActions(title: String? = "ErrorTitle".localized, message: String? = "ErrorMessage".localized, buttons: [UIAlertAction]!, preferredStyle: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for button in buttons {
            alertController.addAction(button)
        }

        self.present(alertController, animated: true, completion:nil)
    }

    func showNotImplementedYetAlert() {
        let alert = UIAlertController(title: "ErrorTitle".localized, message: "ErrorNotReady".localized, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
//    func showAlertToSettingsWith(title: String, message: String?, dismissButton: UIAlertAction? = nil) {
//        let okAction = UIAlertAction(title: Strings.Alerts.Settings, style: .default) { (alert) in
//            _ = URLSchemesManager.openApp(.settingsApple)
//        }
//
//        var cancelButton: UIAlertAction
//
//        if dismissButton == nil {
//            cancelButton = UIAlertAction(title: Strings.Alerts.Dismiss, style: .cancel, handler: nil)
//        } else {
//            cancelButton = dismissButton!
//        }
//
//        self.showSimpleAlertWithCustomActions(title: title, message: message, buttons: [okAction, cancelButton])
//    }
}
