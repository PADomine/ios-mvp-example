//
//  ForceTouchGestureRecognizer.swift
//  MVPExample
//
//  Created by Pablo Dominé on 22/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

// https://github.com/FlexMonkey/DeepPressGestureRecognizer
// https://github.com/foggzilla/DFContinuousForceTouchGestureRecognizer

@objc protocol ForceTouchGestureRecognizerDelegate: class {
    // Force touch was recognized according to the thresholds set by baseForceTouchPressure, triggeringForceTouchPressure, and forceTouchDelay
    func forceTouchRecognized(_ recognizer: ForceTouchGestureRecognizer)

    // Force touch started happening. Note that this is not necessary the moment when all touches started happening, just the moment when the first touch occurred with at least a force of baseForceTouchPressure
    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didStartWith force: CGFloat, and maxForce: CGFloat)

    // Force touch movement happening. This is only called if forceTouchDidStartWithForce had been called previously
    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didMoveWith force: CGFloat, and maxForce: CGFloat)

    // Force touch was cancelled. This is only called if forceTouchDidStartWithForce had been called previously
    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didCancelWith force: CGFloat, and maxForce: CGFloat)

    // Force touch ended. This is only called if forceTouchDidStartWithForce had been called previously
    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didEndWith force: CGFloat, and maxForce: CGFloat)

    // Force touch ended with Force Touch triggered. This is only called if forceTouchDidStartWithForce had been called previously
    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didEndTriggedWith force: CGFloat, and maxForce: CGFloat)

    // Force touch timed out. See notes about the timeout property below. This is only called if forceTouchDidStartWithForce had been called previously
    func forceTouchDidTimeout(_ recognizer: ForceTouchGestureRecognizer)
}

extension ForceTouchGestureRecognizerDelegate {

    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didStartWith force: CGFloat, and maxForce: CGFloat) { }

    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didMoveWith force: CGFloat, and maxForce: CGFloat) { }

    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didCancelWith force: CGFloat, and maxForce: CGFloat) { }

    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didEndWith force: CGFloat, and maxForce: CGFloat) { }

    func forceTouch(_ recognizer: ForceTouchGestureRecognizer, didEndTriggedWith force: CGFloat, and maxForce: CGFloat) { }

    func forceTouchDidTimeout(_ recognizer: ForceTouchGestureRecognizer) { }
}

// MARK: GestureRecognizer
class ForceTouchGestureRecognizer: UIGestureRecognizer {

    // The lowest pressuare at which a force touch will begin to be detected,
    //      anything lower is a normal press and will not trigger force touch logic
    // Defaults to 1.0f on a scale from 0.0f to 6.667f;
    public var minPressure: CGFloat = 1.0

    // The pressure at which a force touch will be triggered
    // Defaults to 2.5f on a scale from 0.0f to 6.667f;
    public var triggerPressure: CGFloat = 2.5

    // The delay in seconds after which, if the minPressure or greater is
    //      still being applied will recognize the force touch
    // Defaults to 0.5f (half a second)
    public var delay: Double = 0.5

    // The timeout in seconds after which will fail the gesture recognizer. It fires only if a touch event
    //      is not received again after forceTouchDidStartWithForce or forceTouchDidMoveWithForce is called.
    //
    // When this occurs forceTouchDidTimeout is called and the state is set to UIGestureRecognizerState.failed.
    // Defaults to 1.5f;
    //
    // This comes in handy when you have a view inside a scroll view and the if the user drags to scroll the
    //      view this gesture recognizer will not get its touchesCancelled or touchesEnded methods called
    public var timeout: Double = 1.5

    // Set this delegate to get continuous feedback on pressure changes
    public weak var forceTouchDelegate: ForceTouchGestureRecognizerDelegate?
    // Improve in Xcode 10 https://stackoverflow.com/questions/26180268/interface-builder-iboutlet-and-protocols-for-delegate-and-datasource-in-swift

    private var gestureStartTime: TimeInterval!
    private var forceTouchFired: Bool = false
    private var forceTouchInitialTouchDetect: Bool!
    private var initialForce: CGFloat!
    private var forceTouchTimedTrigger: Timer?

    // Its possible that the touches end will never get called if the view is scrolled
    //      inside a scroll view, so timeout the end of the gesture
    private var lastMovedTimeoutTimer: Timer?

    override func reset() {
        super.reset()

        forceTouchFired = false
        gestureStartTime = 0
        initialForce = 0
        endForceTouchTimer()

        // Do NOT reset this state or the timeout logic will not function since reset can be called before the timeout fires
        //endMovedTimeoutTimer()
        //forceTouchInitialTouchDetect = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)

        forceTouchInitialTouchDetect = false
        state = .possible
        if let touch = touches.first {
            if touch.force > minPressure {
                forceTouchStarted(with: touch)
            }
        }

        startMovedTimeoutTimer()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)

        endMovedTimeoutTimer()
        endForceTouchTimer()

        if let touch = touches.first {
            if forceTouchInitialTouchDetect {
                forceTouchDelegate?.forceTouch(self, didCancelWith: touch.force, and: touch.maximumPossibleForce)
            }
        }

        forceTouchInitialTouchDetect = false
        forceTouchFired = false

        state = .failed
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        endMovedTimeoutTimer()

        super.touchesMoved(touches, with: event)

        if state == .failed {
            return
        }

        // Do NOT set this state or other recognizers such as tap or long press won't trigger
        //self.state = .changed

        if let touch = touches.first {

            if let view = self.view {
                let pointInView = touch.location(in: view)

                if !view.point(inside: pointInView, with: event) {
                    state = .failed
                    if forceTouchInitialTouchDetect {
                        forceTouchDelegate?.forceTouch(self, didEndWith: touch.force, and: touch.maximumPossibleForce)
                    }
                    return
                }
            }

            if forceTouchInitialTouchDetect {
                forceTouchUpdated(with: touch)
            } else if touch.force > 1.0 {
                forceTouchStarted(with: touch)
            }

            startMovedTimeoutTimer()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)

        endMovedTimeoutTimer()
        endForceTouchTimer()

        if let touch = touches.first {
            state = .recognized
            if forceTouchFired {
                forceTouchDelegate?.forceTouch(self, didEndTriggedWith: touch.force, and: touch.maximumPossibleForce)
            } else {
                forceTouchDelegate?.forceTouch(self, didEndWith: touch.force, and: touch.maximumPossibleForce)
            }
        } else {
            state = .cancelled
        }

        forceTouchInitialTouchDetect = false
        forceTouchFired = false
    }

    // MARK: - Private

    private func forceTouchStarted(with touch: UITouch) {
        forceTouchInitialTouchDetect = true
        initialForce = touch.force

        // Only start the force touch logic if the pressure is above the minPressure pressure
        if initialForce > minPressure {
            startForceTouchTimer()
        }
    }

    private func startMovedTimeoutTimer() {
        endMovedTimeoutTimer()
        lastMovedTimeoutTimer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(timeout(_:)), userInfo: nil, repeats: false)
    }

    private func endMovedTimeoutTimer() {
        if lastMovedTimeoutTimer != nil {
            lastMovedTimeoutTimer!.invalidate()
            lastMovedTimeoutTimer = nil
        }
    }

    private func startForceTouchTimer() {
        endForceTouchTimer()
        forceTouchTimedTrigger = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(forceTouchFired(_:)), userInfo: nil, repeats: false)
    }

    private func endForceTouchTimer() {
        if forceTouchTimedTrigger != nil {
            forceTouchTimedTrigger!.invalidate()
            forceTouchTimedTrigger = nil
        }
    }

    private func forceTouchUpdated(with touch: UITouch) {
        // Its possible that the user started their tap below the minPressure pressure threshold and then
        //      increased their pressure to trigger a force touch.
        // If that happened then start the force touch detection
        if initialForce < triggerPressure && touch.force >= triggerPressure && !forceTouchFired {
            forceTouchFired(self)
        }

        forceTouchDelegate?.forceTouch(self, didMoveWith: touch.force, and: touch.maximumPossibleForce)
    }

    @objc func timeout(_ sender: AnyObject) {
        state = .failed
        if forceTouchInitialTouchDetect {
            forceTouchDelegate?.forceTouchDidTimeout(self)
        }
    }

    @objc func forceTouchFired(_ sender: AnyObject) {
        forceTouchFired =  true

        endMovedTimeoutTimer()
        endForceTouchTimer()

        // Do NOT set this state to UIGestureRecognizerState.recognized or the recognizer will reset and
        //      force pressure updates will cease.
        // Instead use a delegate callback to signify that the desired force touch gesture was performed
        //      and keep the events streaming with pressure updates
        //self.state = .recognized

        forceTouchDelegate?.forceTouchRecognized(self)
    }
}
