//
//  AuthorizationViewController.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit

public final class LogInViewController: UIViewController {

    // MARK: - Properties
    private lazy var authorizationView: AuthorizationView = {
        let view = AuthorizationView(.authorization)
        view.delegate = self
        return view
    }()
    private let validationChecker = ValidationChecker()

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
extension LogInViewController: AuthorizationViewDelegate {
    func checkForValid(mail: String?) {
        if !validationChecker.isValidEmail(mail) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .mail,
                error: NSLocalizedString("authorizationMailErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }

    func checkForValid(password: String?) {
        if !validationChecker.isValidPassword(password) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .password,
                error: NSLocalizedString("authoricationPasswordErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }

    func checkForValid(password: String?, repeatPassword: String?)  {
        if repeatPassword != password {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .repeatPassword,
                error: NSLocalizedString("repeatPasswordErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func continueButtonTapped(mail: String?, password: String?) {
        if !validationChecker.isValidEmail(mail) {
            // В этом случае можно не отправлять запрос на сервер и сразу показать алерт.
//            let errorTextFieldInfo = ErrorTextFieldInfo(
//                type: .mail,
//                error: NSLocalizedString("authorizationMailErrorLabel", comment: "")
//            )
//            authorizationView.applyState(.error(errorTextFieldInfo))
        }

        if !validationChecker.isValidPassword(password) {
            // В этом случае тоже.
//            let errorTextFieldInfo = ErrorTextFieldInfo(
//                type: .password,
//                error: NSLocalizedString("authoricationPasswordErrorLabel", comment: "")
//            )
//            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }
}
