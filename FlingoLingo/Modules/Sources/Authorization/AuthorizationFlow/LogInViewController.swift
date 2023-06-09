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
    private let provider: ProfileProvider
    private lazy var activityIndicatorView = UIActivityIndicatorView()

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

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .large
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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

    private func showLoading() {
        authorizationView.continueButton.isEnabled = false
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }

    private func hideLoading() {
        authorizationView.continueButton.isEnabled = true
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }

    func continueButtonTapped(mail: String?, password: String?, repeatPassword: String?) {
        if checkValidation(mail: mail, password: password) {
            authorizationView.applyStateForSpinner(.start)

            provider.logInUser(email: mail ?? "", password: password ?? "", onFinish: { [weak self] res in
                self?.authorizationView.applyStateForSpinner(.stop)
                switch res {
                case .success(let profile):
                    self?.provider.domainProfile = profile
                    self?.navigationController?.dismiss(animated: true)
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
}
