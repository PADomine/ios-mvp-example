//
//  UsersRepositoryMock.swift
//  MVPExample
//
//  Created by Pablo Dominé on 21/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

class UsersRepositoryMock: UsersRepository {

    internal var currentUser: User?

    internal var error: MVPExampleError?

    func getUser(completionHandler: @escaping GetUserCompletionHandler) {
        if error == nil {
            self.currentUser = User.createDummyUser()
            completionHandler(Result.success(currentUser!))
        } else {
            completionHandler(Result.failure(error!))
        }
    }

    func logOut() {
        currentUser = nil
    }

    // Before testing, set the values that want the function to return:

    public func setCurrentUser(_ currentUser: User?) {
        self.currentUser = currentUser
    }

    public func setError(_ error: MVPExampleError?) {
        self.error = error
    }
}
