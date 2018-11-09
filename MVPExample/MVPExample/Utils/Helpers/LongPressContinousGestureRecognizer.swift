//
//  LongPressContinousGestureRecognizer.swift
//  MVPExample
//
//  Created by Pablo Dominé on 23/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

@objc protocol LongPressContinousGestureRecognizerDelegate: class {
    func longPressContinousRecognized(_ recognizer: LongPressContinousGestureRecognizer)

    func longPressContinousDidStart(_ recognizer: LongPressContinousGestureRecognizer)

    func longPressContinousDidCancel(_ recognizer: LongPressContinousGestureRecognizer)

    func longPressContinousDidEnded(_ recognizer: LongPressContinousGestureRecognizer)

    func longPressContinousDidFailed(_ recognizer: LongPressContinousGestureRecognizer)
}

extension LongPressContinousGestureRecognizerDelegate {
    func longPressContinousDidStart(_ recognizer: LongPressContinousGestureRecognizer) { }

    func longPressContinousDidCancel(_ recognizer: LongPressContinousGestureRecognizer) { }

    func longPressContinousDidEnded(_ recognizer: LongPressContinousGestureRecognizer) { }

    func longPressContinousDidFailed(_ recognizer: LongPressContinousGestureRecognizer) { }
}

class LongPressContinousGestureRecognizer: UILongPressGestureRecognizer {

    private var longPressFired: Bool = false

    public weak var longPressContinousDelegate: LongPressContinousGestureRecognizerDelegate?

    override func reset() {
        super.reset()

        longPressFired = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        print("Began: \(self.state.rawValue)")

        longPressContinousDelegate?.longPressContinousDidStart(self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        print("Moved: \(self.state.rawValue)")

        if state == .began {
            longPressContinousDelegate?.longPressContinousRecognized(self)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        print("Ended: \(self.state.rawValue)")

        if state == .cancelled {
            longPressContinousDelegate?.longPressContinousDidCancel(self)
        } else if state == .ended {
            longPressContinousDelegate?.longPressContinousDidEnded(self)
        } else {
            longPressContinousDelegate?.longPressContinousDidFailed(self)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        print("Cancelled: \(self.state.rawValue)")

        longPressContinousDelegate?.longPressContinousDidCancel(self)
    }
}
