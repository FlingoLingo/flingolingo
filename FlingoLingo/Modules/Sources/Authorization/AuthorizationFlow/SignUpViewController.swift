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
        let view = AuthorizationView(.logIn)
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

    // MARK: - Module functions
    func checkValidation(mail: String?, password: String?, repeatPassword: String?) -> Bool {
        var isValid = true

        if !validationChecker.isValidEmail(mail) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .mail,
                error: NSLocalizedString("mailErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))

            isValid = false
        }

        if !validationChecker.isValidPassword(password) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .password,
                error: NSLocalizedString("passwordErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))

            isValid = false
        }

        if !validationChecker.isValidRepeatPassword(repeatPassword, password: password) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .repeatPassword,
                error: NSLocalizedString("repeatPasswordErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))

            isValid = false
        }

        return isValid
    }
}

// MARK: - AuthorizationViewDelegate
extension SignUpViewController: AuthorizationViewDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func continueButtonTapped(mail: String?, password: String?, repeatPassword: String?) {
        if checkValidation(mail: mail, password: password, repeatPassword: repeatPassword) {}
    }
}
