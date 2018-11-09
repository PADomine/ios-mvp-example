//
//  BaseContract.swift
//  MVPExample
//
//  Created by Pablo Dominé on 06/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

protocol BaseContractPresenter {
    var baseView: BaseContractView! { get }
    func loadView()
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func onDestroy()
}

protocol BaseContractView: AnyObject {
    var basePresenter: BaseContractPresenter! { get }
    func showError(error: MVPExampleError)
    func showProgress()
    func hideProgress()
}
