//
//  Result.swift
//  MVPExample
//
//  Created by Pablo Dominé on 12/07/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation

//struct CoreError: Error {
//    var localizedDescription: String {
//        return message
//    }
//
//    var message = ""
//}

// See https://github.com/antitypical/Result
enum Result<T,E: Swift.Error> {
    case success(T)
    case failure(E)

    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
