//
//  MainPresenter.swift
//  MVPExample
//
//  Created by Pablo Dominé on 06/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

class MainPresenter: BasePresenter, MainContractPresenter {

    // MARK: - Properties

    init(repository: UsersRepository, view: MainContractView) {
        self.view = view
        self.repository = repository
        super.init(view: view)
    }

    // MARK: - MainContractPresenter

    internal weak var view: MainContractView!
    internal var repository: UsersRepository!
    internal var user: User?

    func refreshUserButtonPressed() {
        getUser()
    }

    // MARK: - Private

    private func getUser() {
        view.showProgress()
        repository.getUser { (result) in
            self.view.hideProgress()
            switch result {
            case .success(let user):
                self.view.displayUserInformation(user)
            case .failure(let error):
                self.view.showError(error: error)
            }
        }
    }
}
