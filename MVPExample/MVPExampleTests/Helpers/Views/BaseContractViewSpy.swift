//
//  BaseContractViewSpy.swift
//  MVPExample
//
//  Created by Federico Nieto on 13/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
@testable import MVPExample

class BaseContractViewSpy: BaseContractView {

    func injectDependencies() {
        basePresenter = ConfiguratorTest.getBasePresenter(viewController: self)
    }

    // MARK: - BaseContractView

    var basePresenter: BaseContractPresenter!

    var showErrorCalled: MVPExampleError?
    var showProgressCalled = false
    var hideProgressCalled = false
    var showHighTemperatureAlertCalled = false

    func showError(error: MVPExampleError) {
        showErrorCalled = error
    }

    func showProgress() {
        showProgressCalled = true
    }

    func hideProgress() {
        hideProgressCalled = true
    }

    func showHighTemperatureAlert() {
        showHighTemperatureAlertCalled = true
    }


}
