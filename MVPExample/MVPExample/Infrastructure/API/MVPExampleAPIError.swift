//
//  MVPExampleAPIError.swift
//  MVPExample
//
//  Created by Pablo Dominé on 01/10/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit
import SwiftyJSON

private struct MVPExampleAPIErrorKeys {
    static let code = "errorCode"
    static let message = "responseMessage"
}

class MVPExampleAPIError: Error {

    enum ErrorCodeType: Int {
        case unknown = 0
        case georestriction = 1008
    }

    var code: Int
    var codeType: ErrorCodeType
    var message: String

    init() {
        self.code = 0
        self.message = ""
        self.codeType = ErrorCodeType.unknown
    }

    init(code: Int, message: String) {
        self.code = code
        self.message = message
        self.codeType = ErrorCodeType(rawValue: self.code) ?? .unknown
    }

    init?(json: JSON) {
        if let code = json[MVPExampleAPIErrorKeys.code].int, let message = json[MVPExampleAPIErrorKeys.message].string {
            self.code = code
            self.message = message
            self.codeType = ErrorCodeType(rawValue: self.code) ?? .unknown
        } else {
            return nil
        }
    }
}
