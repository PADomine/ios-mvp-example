//
//  ConfiguratorTest.swift
//  MVPExampleTests
//
//  Created by Federico Nieto on 13/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
@testable import MVPExample

class ConfiguratorTest {
    
    static var usersRepository: UsersRepository?
    
    // MARK: - Presenter Classes
    
    class func getBasePresenter(viewController: BaseContractView) -> BaseContractPresenter {
        return BasePresenter(view: viewController)
    }
    
    class func getMainPresenter(viewController: MainContractView) -> MainContractPresenter {
        return MainPresenter(repository: getUsersRepository(),
                             view: viewController)
    }
    
    // MARK: - Repositories Classes
    
    class func getUsersRepository() -> UsersRepository {
        if usersRepository == nil {
            usersRepository = UsersRepositoryMock()
        }
        return usersRepository!
    }
    
}
