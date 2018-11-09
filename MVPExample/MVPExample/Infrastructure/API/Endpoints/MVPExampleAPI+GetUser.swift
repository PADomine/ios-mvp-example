//
//  MVPExampleAPI+CreateUser.swift
//  MVPExample
//
//  Created by Pablo Dominé on 01/10/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension MVPExampleAPI {

    typealias MVPExampleAPIGetUserResponse = (_ user: Result<User, MVPExampleError>) -> Void

    func getUser(completionHandler: @escaping MVPExampleAPIGetUserResponse) {
        let url = baseURL.appendingPathComponent("users")
        let method: HTTPMethod = .get
        let parameters: Parameters? = nil
        let headers: HTTPHeaders? = nil

        sessionManager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let user = User(json: json)
                completionHandler(.success(user))
            case .failure(_):
                completionHandler(.failure(MVPExampleError.userNotFound))
            }

            debugPrint("-----\nMVPExampleAPI: \n- Request: \(response.request!.description)\n - Response Code: \(response.response?.statusCode.description ?? "No Code")\n- Response:")
        }
    }
}
