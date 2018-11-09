//
//  ReachabilityService.swift
//  MVPExample
//
//  Created by Pablo Dominé on 12/09/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Reachability

@objc public enum ConnectionState: Int {
    case online, offline
    init(connection: Reachability.Connection) {
        switch connection {
        case .cellular, .wifi:
            self = .online
        case .none:
            self = .offline
        }
    }
}

@objc protocol ReachabilityServiceProtocol: ObservableProtocol {
    func reachabilityDidChange(_ connection: ConnectionState)
}

public final class ReachabilityService: Observable {

    private let reachability = Reachability()!

    // Public
    internal var observers: [ReachabilityServiceProtocol] = []

    public var connectionState: ConnectionState {
        return ConnectionState(connection: reachability.connection)
    }

    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    init() {
        // Init Network comms
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: .reachabilityChanged, object: reachability)

        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start Reachability notifier.")
        }
    }

    @objc func reachabilityChanged(notification: Notification) {

        guard let reachability = notification.object as? Reachability else {
            return
        }

        switch reachability.connection {
        case .wifi, .cellular:
            print("Network reachable")
        case .none:
            print("Network not reachable")
        }

        forEachObserver { (observer) in
            DispatchQueue.main.async { () -> Void in
                observer.reachabilityDidChange(self.connectionState)
            }
        }
    }

}
