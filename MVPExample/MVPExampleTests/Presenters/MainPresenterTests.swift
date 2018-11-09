//
//  MainPresenterTests.swif
//  MVPExampleTests
//
//  Created by Federico Nieto on 21/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import XCTest
@testable import MVPExample

class MainPresenterTests: XCTestCase {
    
    let mainContractViewSpy = MainContractViewSpy()
    // swiftlint:disable force_cast
    let usersRepositoryMock = ConfiguratorTest.getUsersRepository() as! UsersRepositoryMock
    
    var mainPresenter: MainPresenter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mainPresenter = MainPresenter(repository: usersRepositoryMock, view: mainContractViewSpy)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_displayUserInformation() {
        // Given
        usersRepositoryMock.setCurrentUser(User.createDummyUser())
        
        // When
        mainPresenter.refreshUserButtonPressed()
        
        // Then
        XCTAssertTrue(mainContractViewSpy.displayUserInformationCalled, "User information was not displayed")
    }
    
    func test_displayUserInformation_errorCalled() {
        // Given
        usersRepositoryMock.setCurrentUser(nil)
        usersRepositoryMock.setError(MVPExampleError.userNotFound)
        
        // When
        mainPresenter.refreshUserButtonPressed()
        
        // Then
        XCTAssertEqual(usersRepositoryMock.error, mainContractViewSpy.showErrorCalled, "Error alert was not displayed")
    }
    
}

