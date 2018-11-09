//
//  MainViewController.swift
//  MVPExample
//
//  Created by Pablo Dominé on 01/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MainContractView {

    // MARK: - Inject Dependencies

    override func injectDependencies() {
        super.injectDependencies()
        presenter = Configurator.getMainPresenter(viewController: self)
    }

    // MARK: - Constants

    private enum Constants {
//        enum Strings {
//            static let percentaje = "%"
//            static let kilometers = "Km"
//        }
    }

    // MARK: - IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    // MARK: - Properties

    internal var presenter: MainContractPresenter!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load all localized strings
        loadStrings()
    }


    // MARK: - Private

    private func loadStrings() {

    }

    // MARK: - IBActions

    @IBAction func handleRefreshUserButtonTouched(_ sender: UIButton) {
        presenter.refreshUserButtonPressed()
    }

    // MARK: - MainContractView

    func displayUserInformation(_ user: User) {
        nameLabel.text = user.name
        idLabel.text = user.id
        countryLabel.text = user.country
        phoneLabel.text = user.phone
    }

    override func showError(error: MVPExampleError) {
        switch error {
        case .userNotFound:
            showSimpleAlert(message: "ErrorUserNotFoundMessage".localized)
        default:
            super.showError(error: error)
        }
    }
}
