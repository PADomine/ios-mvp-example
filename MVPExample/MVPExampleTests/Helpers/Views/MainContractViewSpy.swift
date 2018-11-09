//
//  MainContractViewSpy.swift
//  MVPExampleTests
//
//  Created by Federico Nieto on 21/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
@testable import MVPExample

class MainContractViewSpy: BaseContractViewSpy, MainContractView {
    
    override func injectDependencies() {
        super.injectDependencies()
        presenter = ConfiguratorTest.getMainPresenter(viewController: self)
    }
    
    // MARK: - MainContractView
    
    var presenter: MainContractPresenter!
    
    var displayUserInformationCalled = false
    
    func displayUserInformation(_ user: User) {
        displayUserInformationCalled = true
    }

}

