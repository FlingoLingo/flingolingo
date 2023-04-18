//
//  WelcomeView.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public final class WelcomeViewController: UIViewController {

    // MARK: - Properties
    private lazy var welcomeView: WelcomeView = {
        let view = WelcomeView()
        view.delegate = self
        return view
    }()

    // MARK: - Lifecycle
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        view = welcomeView
    }
}

// MARK: - WelcomeViewDelegate
extension WelcomeViewController: WelcomeViewDelegate {
    func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        signUpViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(signUpViewController, animated: true)
    }

    func logInButtonTapped() {
        let logInViewController = LogInViewController()
        logInViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(logInViewController, animated: true)
    }

    func guestLogInButtonTapped() {}
}
