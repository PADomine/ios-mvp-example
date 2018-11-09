//
//  Dispatch.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/11/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import Foundation

// Inspired by: https://medium.com/modernnerd-code/grand-central-dispatch-crash-course-for-swift-3-8bf2652c1cb8

// Main Queue is used to perform UI updates
func dispatchOnMainAsync(execute: @escaping () -> Void) {
    // Asynchronous code running on the main queue
    DispatchQueue.main.async(execute: execute)
}

func dispatchOnMainAsyncAfter(seconds: TimeInterval = 0.1, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: execute)
}

func dispatchOnMainSync(execute: @escaping () -> Void) {
    // Synchronous code running on the main queue
    DispatchQueue.main.sync(execute: execute)
}

// Low Priority Global Queue
func dispatchUtilityOnGlobalAsync(execute: @escaping () -> Void) {
    // Asynchronous code running on the low priority queue
    // User-initiated: tasks in this queue are tasks that should run
    // immediately -like opening documents or react to user actions.
    // Tasks should complete in a few seconds or less. Will be mapped to High priority queue.
    DispatchQueue.global(qos: .utility).async(execute: execute)
}

func dispatchUserInitiatedOnGlobalSync(execute: @escaping () -> Void) {
    // Synchronous code running on the high prioriy queue
    // Utility: this queue is for longer tasks that should complete immediately
    // (think tasks with a loading bar such as downloading or importing).
    // Tasks should complete in seconds or minutes. Will be mapped to Low priority queue.
    DispatchQueue.global(qos: .userInitiated).sync(execute: execute)
}

func dispatchBackgroundOnGlobalAsync(execute: @escaping () -> Void) {
    // Aynchronous code running on the low prioriy queue
    // Background: tasks that takes minutes to hours to complete — indexing,
    // syncing, etc… This queue is energy optimized and any disk I/O actions
    // are throttled. Will be mapped to Background priority queue.
    DispatchQueue.global(qos: .background).async(execute: execute)
}
