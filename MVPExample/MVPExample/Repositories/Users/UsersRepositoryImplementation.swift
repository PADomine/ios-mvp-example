//
//  UsersRepositoryImplementation.swift
//  MVPExample
//
//  Created by Pablo Dominé on 20/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

class UsersRepositoryImplementation: UsersRepository {

    internal var currentUser: User?
    internal let baseProjectAPI: MVPExampleAPI!

    init(baseProjectAPI: MVPExampleAPI) {
        self.currentUser = nil
        self.baseProjectAPI = baseProjectAPI
    }

    func getUser(completionHandler: @escaping GetUserCompletionHandler) {
        baseProjectAPI.getUser(completionHandler: { (result) in
            switch result {
            case .success(let user):
                self.currentUser = user
                completionHandler(.success(self.currentUser!))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }

    func logOut() {
        currentUser = nil
    }
}
