//
//  User.swift
//  MVPExample
//
//  Created by Pablo Dominé on 20/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    let id: String
    let name: String
    let phone: String
    let country: String

    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.phone = json["telephone"].stringValue
        self.country = json["country"].stringValue
    }
}

extension User {

    static let jsonString: String =
            """
            {
                "id": "987654321",
                "name": "Pablo Ramos",
                "telephone": "34660421846",
                "country": "🇪🇸"
            }
            """

    static func createDummyUser() -> User {
        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)!
        let json = try! JSON(data: dataFromString)
        return User(json: json)
    }
}
