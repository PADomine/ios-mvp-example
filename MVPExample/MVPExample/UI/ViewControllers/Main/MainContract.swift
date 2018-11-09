//
//  MainContract.swift
//  MVPExample
//
//  Created by Pablo Dominé on 06/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

protocol MainContractPresenter: BaseContractPresenter {
    var view: MainContractView! { get }
    var repository: UsersRepository! { get }
    var user: User? { get }
    func refreshUserButtonPressed()
}

protocol MainContractView: BaseContractView {
    var presenter: MainContractPresenter! { get }
    func displayUserInformation(_ user: User)
}
