//
//  BasePresenter.swift
//  MVPExample
//
//  Created by Pablo Dominé on 06/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

class BasePresenter: BaseContractPresenter {

    // MARK: - BaseContractPresenter

    internal weak var baseView: BaseContractView!

    init(view: BaseContractView) {
        self.baseView = view
    }

    func loadView() { }

    func viewDidLoad() { }

    func viewWillAppear() { }
    
    func viewDidAppear() { }

    func viewWillDisappear() { }

    func viewDidDisappear() { }

    func onDestroy() { }
}
