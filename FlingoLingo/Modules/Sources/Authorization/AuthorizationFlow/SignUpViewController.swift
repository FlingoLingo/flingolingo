//
//  File.swift
//  
//
//  Created by Alexander Muratov on 4/15/23.
//

import UIKit

public final class SignUpViewController: UIViewController {

    // MARK: - Properties
    private lazy var authorizationView: AuthorizationView = {
        let view = AuthorizationView(.registration)
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
extension SignUpViewController: AuthorizationViewDelegate {
    func checkForValid(mail: String?) {
        if !validationChecker.isValidEmail(mail) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .mail,
                error: NSLocalizedString("mailErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }

    func checkForValid(password: String?) {
        if !validationChecker.isValidPassword(password) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .password,
                error: NSLocalizedString("passwordErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }

    func checkForValid(password: String?, repeatPassword: String?) {
        guard repeatPassword != "" else { return }
    }

    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func continueButtonTapped(mail: String?, password: String?) {
        if !validationChecker.isValidEmail(mail) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .mail,
                error: NSLocalizedString("mailErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))
        }

        if !validationChecker.isValidPassword(password) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .password,
                error: NSLocalizedString("passwordErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))
        }
    }
}
