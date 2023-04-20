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
    private let provider: ProfileProvider
    private let child = SpinnerViewController()

    // MARK: - Lifecycle
    public init(provider: ProfileProvider) {
        self.provider = provider
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

    private func createSpinnerView() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    private func removeSpinnerView() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

// MARK: - AuthorizationViewDelegate
extension SignUpViewController: AuthorizationViewDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func continueButtonTapped(mail: String?, password: String?, repeatPassword: String?) {
        if checkValidation(mail: mail, password: password, repeatPassword: repeatPassword) {
            createSpinnerView()

            provider.registerUser(email: mail ?? "", password: password ?? "", onFinish: { [weak self] result in
                self?.removeSpinnerView()

                DispatchQueue.main.async {
                    switch result {
                    case .success(let profile):
                        self?.provider.domainProfile = profile
                        DispatchQueue.main.async {
                            self?.navigationController?.dismiss(animated: true)
                        }
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }
}
