//
//  UsersRepository.swift
//  MVPExample
//
//  Created by Pablo Dominé on 20/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

typealias GetUserCompletionHandler = (_ user: Result<User, MVPExampleError>) -> Void

protocol UsersRepository {
    var currentUser: User? { get set }

    func getUser(completionHandler: @escaping GetUserCompletionHandler)
    func logOut()
}
