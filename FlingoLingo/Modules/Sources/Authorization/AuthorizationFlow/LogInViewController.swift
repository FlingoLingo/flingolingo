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
        let view = AuthorizationView(.signUp)
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

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Module functions
    func checkValidation(mail: String?, password: String?) -> Bool {
        var isValid = true

        if !validationChecker.isValidEmail(mail) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .mail,
                error: NSLocalizedString("logInMailErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))

            isValid = false
        }

        if !validationChecker.isValidPassword(password) {
            let errorTextFieldInfo = ErrorTextFieldInfo(
                type: .password,
                error: NSLocalizedString("logInPasswordErrorLabel", comment: "")
            )
            authorizationView.applyState(.error(errorTextFieldInfo))

            isValid = false
        }

        return isValid
    }
}

// MARK: - AuthorizationViewDelegate
extension LogInViewController: AuthorizationViewDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func continueButtonTapped(mail: String?, password: String?, repeatPassword: String?) {
        if checkValidation(mail: mail, password: password) {}
    }
}
