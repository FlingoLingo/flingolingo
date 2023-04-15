//
//  AuthorizationViewController.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public final class AuthorizationViewController: UIViewController {

    // MARK: - Properties
    private lazy var authorizationView: AuthorizationView = {
        let view = AuthorizationView()
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
        view = authorizationView
    }
}

// MARK: - AuthorizationViewDelegate
extension AuthorizationViewController: AuthorizationViewDelegate {

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func continueButtonTapped(mail: String, password: String) {
        if !ValidationChecker.isValidEmail(mail) {
            let errorTextFieldInfo = ErrorTextFieldInfo(type: .mail,
                                                        error: NSLocalizedString("mailErrorLabel", comment: ""))
            authorizationView.applyState(.error(errorTextFieldInfo))
        }

        if !ValidationChecker.isValidPassword(password) {
            let errorTextFieldInfo = ErrorTextFieldInfo(type: .password,
                                                        error: NSLocalizedString("passwordErrorLabel", comment: ""))
            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }
}
