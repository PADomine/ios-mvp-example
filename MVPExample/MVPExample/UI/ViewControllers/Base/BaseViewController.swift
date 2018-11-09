//
//  BaseViewController.swift
//  MVPExample
//
//  Created by Pablo Dominé on 06/08/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController, BaseContractView {

    internal var basePresenter: BaseContractPresenter!

    // MARK: - Properties

    internal var progressView: MBProgressHUD!
    internal var dimBackgroundView: UIView!

    // MARK: - Lyfecycle

    deinit {
        basePresenter.onDestroy()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        injectDependencies()

        configureProgressView()
    }

    // Override this method in all BaseViewController's childs
    func injectDependencies() {
        basePresenter = Configurator.getBasePresenter(viewController: self)
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - BaseContractView

    func showError(error: MVPExampleError) {
        switch error {
        case .notAvailable:
            showNotImplementedYetAlert()
        default:
            showSimpleAlert()
        }
    }

    func showProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        dispatchOnMainAsync {
            self.dimBackgroundView.isHidden = false
            self.progressView.show(animated: true)
        }
    }

    func hideProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        dispatchOnMainAsync {
            self.dimBackgroundView.isHidden = true
            self.progressView.hide(animated: true)
        }
    }

    // MARK: - Private

    private func configureProgressView() {
        dimBackgroundView = UIView(frame: view.bounds)
        dimBackgroundView.backgroundColor = Style.Color.black.withAlphaComponent(0.5)
        dimBackgroundView.isHidden = true
        view.addSubview(dimBackgroundView)

        progressView = MBProgressHUD()
        progressView.add(to: self.view)
    }

}
