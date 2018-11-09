//
//  MVPExampleAPI.swift
//  MVPExample
//
//  Created by Pablo Dominé on 01/10/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MVPExampleAPIRetrier: RequestRetrier {
    // swiftlint:disable function_parameter_count
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if request.retryCount >= 1 {
            completion(false, 0.0) // don't retry
        } else {
            completion(true, 1.0) // retry after 1 second
        }
    }
}

class MVPExampleAPI {

    public enum Environment: String {
        case development = "http://demo5960940.mockable.io/"
//        case staging = ""
//        case production = ""
    }

    private let environment: Environment
    internal var sessionManager: SessionManager!
    internal let baseURL: URL

    init(environment: Environment) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = 10 //seconds
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)

        self.sessionManager.retrier = MVPExampleAPIRetrier()

        self.environment = environment
        self.baseURL = URL(string: self.environment.rawValue)!
        print("Environement setted: \(environment.rawValue)")
    }
}
