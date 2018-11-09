//
//  Observable.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/09/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

// http://www.spazstik-software.com/blog/article/a-reusable-observer-protocol-written-in-swift

import Foundation

/// Protocol used as the base protocol type for a observer class
@objc protocol ObservableProtocol: class { }

protocol Observable {
    /// Observer is a generic type used for classes used as observers
    associatedtype Observer: ObservableProtocol

    /// observers is the array of references for the the registered observers
    /// to the class
    var observers: [Observer] { get set }

    /// Call this function to register the observer object.
    ///
    /// - parameter observer: A reference to a object that will get notifications
    mutating func add(observer: Observer)

    /// Call this function to de-register the observer object.
    ///
    /// - parameter observer: A reference to the object to de-register
    mutating func remove(observer: Observer)

    /// This method is call by the Observed object to call the passed block
    /// for each registered observer
    ///
    /// - parameter block: A block that is called for each registered observer
    func forEachObserver(_ block: (Observer) -> Void)
}

extension Observable {
    /// Call this function to register the observer object.
    ///
    /// - parameter observer: A reference to a object that will get notifications
    mutating func add(observer: Observer) {
        self.observers.append(observer)
    }

    /// Call this function to de-register the observer object.
    ///
    /// - parameter observer: A reference to the object to de-register
    mutating func remove(observer: Observer) {
        for (index, entry) in observers.enumerated() where entry === observer {
            observers.remove(at: index)
            return
        }
    }

    /// This method is call by the Observed object to call the passed block
    /// for each registered observer
    ///
    /// - parameter block: A block that is called for each registered observer
    func forEachObserver(_ block: (Observer) -> Void) {
        observers.forEach { (observer) in
            block(observer)
        }
    }
}
