//
//  Configurator.swift
//  MVPExample
//
//  Created by Pablo Dominé on 03/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation

// This class is the Dependecy Injection manager. It takes care of initializing all Presenters, Repositories and even the API classes. It handles all the 'singletons' necessary.

class Configurator {

    // Environment for our APIs
    static let environment: MVPExampleAPI.Environment = .development

    // Repositories and infrastructure (Handles our 'singletons')
    static var usersRepository: UsersRepository?
    static var reachabilityService: ReachabilityService?
    static var baseProjectAPI: MVPExampleAPI?

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
            // We could change UsersRepositoryMock for UserRepositoryImplementation if we want to work with the API
//            usersRepository = UsersRepositoryImplementation(baseProjectAPI: getMVPExampleAPI())
            usersRepository = UsersRepositoryMock()
        }
        return usersRepository!
    }

    // MARK: - Infrastructure Classes

    class func getReachabilityService() -> ReachabilityService {
        if reachabilityService == nil {
            reachabilityService = ReachabilityService()
        }
        return reachabilityService!
    }

    class func getMVPExampleAPI() -> MVPExampleAPI {
        if baseProjectAPI == nil {
            baseProjectAPI = MVPExampleAPI(environment: environment)
        }
        return baseProjectAPI!
    }

}
