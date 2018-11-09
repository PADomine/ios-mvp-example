//
//  LongPressContinousGestureRecognizer.swift
//  MVPExample
//
//  Created by Pablo Dominé on 23/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import AudioToolbox
import UIKit

class FeedbackGenerator {
    
    // Impact Generators
    private static let lightImpactGenerator   = UIImpactFeedbackGenerator(style: .light)
    private static let mediumImpactGenerator  = UIImpactFeedbackGenerator(style: .medium)
    private static let heavyImpactGenerator   = UIImpactFeedbackGenerator(style: .heavy)
    private static let notificationGenerator  = UINotificationFeedbackGenerator()
    private static let selectionGenerator     = UISelectionFeedbackGenerator()
    
    /*
     For making a generic Impact: An impact is a physical metaphor that
     complements a visual experience.
     Types are: [.light, .medium, .heavy]
     */
    static func makeImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        var generator: UIImpactFeedbackGenerator?
        
        switch style {
        case .light:
            generator = lightImpactGenerator
        case .medium:
            generator = mediumImpactGenerator
        case .heavy:
            generator = heavyImpactGenerator
        }
        
        let haptic = {
            generator?.prepare()
            generator?.impactOccurred()
        }
        
        checkForTaptic(haptic: haptic, isError: false)
    }
    
    /*
     For making impacts used in Notifications.
     Types are: [.success, .warning, .error]
     */
    static func makeNotificationImpact(type: UINotificationFeedbackGenerator.FeedbackType) {
        let haptic = {
            self.notificationGenerator.prepare()
            self.notificationGenerator.notificationOccurred(type)
        }
        
        let isError = type == .error || type == .warning
        checkForTaptic(haptic: haptic, isError: isError)
    }
    
    /*
     For making Selection impacts. i.e. Scrolling a Picker.
     */
    static func makeSelectionImpact() {
        let haptic = {
            self.selectionGenerator.prepare()
            self.selectionGenerator.selectionChanged()
        }
        
        checkForTaptic(haptic: haptic, isError: false)
    }
    
    /*
     Make Taptic feedback: Peek.
     */
    private static func makeTapticFeedbackPeek() {
        // 'Peek' feedback (weak boom)
        let peek = SystemSoundID(1519)
        AudioServicesPlaySystemSound(peek)
    }
    
    /*
     Make Taptic feedback: Fail.
     */
    private static func makeTapticFeedbackFail() {
        // 'Failed' feedback (three sequential strong booms)
        let failed = SystemSoundID(1107)
        AudioServicesPlaySystemSound(failed)
    }
    
    /*
     Make Taptic feedback: Pop.
     */
    private static func makeTapticFeedbackPop() {
        // 'Pop' feedback (strong boom)
        let pop = SystemSoundID(1520)
        AudioServicesPlaySystemSound(pop)
    }
    
    /*
     Make Taptic feedback: cancelled.
     */
    private static func makeTapticFeedbackCancelled() {
        // 'Cancelled' feedback (three sequential weak booms)
        let cancelled = SystemSoundID(1521)
        AudioServicesPlaySystemSound(cancelled)
    }
    
    /*
     Make Taptic feedback: Try Again.
     */
    private static func makeTapticFeedbackTryAgain() {
        // 'Try Again' feedback (week boom then strong boom)
        let tryAgain = SystemSoundID(1102)
        AudioServicesPlaySystemSound(tryAgain)
    }
    
    /*
     Vibrates the phone.
     */
    private static func vibratePhone() {
        let vibrate = SystemSoundID(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(vibrate)
    }
    
    /*
     Checks for _feedbackSupportLevel key to see
     if the device supports vibration or haptic.
     */
    private static func checkForTaptic(haptic: () -> Void, isError: Bool) {
        if let feedbackSupportLevel = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int {
            switch feedbackSupportLevel {
            case 2:
                // 2nd Generation Taptic Engine w/ Haptic Feedback (iPhone 7/7+)
                haptic()
            case 1:
                // 1st Generation Taptic Engine (iPhone 6S/6S+)
                isError ? makeTapticFeedbackFail() : makeTapticFeedbackPeek()
            case 0:
                // No Taptic Engine, do nothing
                break
            default:
                break
            }
        }
    }
}
