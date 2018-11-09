//
//  UIScrollView.swift
//  MVPExample
//
//  Created by Pablo Dominé on 27/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height + self.contentInset.bottom)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}
