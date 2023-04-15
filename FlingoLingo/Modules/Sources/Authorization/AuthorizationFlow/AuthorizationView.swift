//
//  AuthorizationView.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit
import UIComponents

protocol AuthorizationViewDelegate: AnyObject {
    func backButtonTapped()
    func continueButtonTapped(mail: String, password: String)
}

struct ErrorTextFieldInfo {
    enum TextFieldType {
        case mail
        case password
    }

    let type: TextFieldType
    let error: String
}

final class AuthorizationView: UIView {
    enum State {
        case error(ErrorTextFieldInfo)
    }

    // MARK: - Properties
    private lazy var navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorScheme.background
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var navigationBarBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = ColorScheme.mainText
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var navigationBarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("authorizationViewNavigationBarTitleLabel", comment: "")
        label.font = Fonts.largeTitle
        label.numberOfLines = 1
        label.textColor = ColorScheme.mainText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("authorizationViewDescriptionLabel", comment: "")
        label.numberOfLines = 0
        label.font = Fonts.mainText
        label.textColor = ColorScheme.secondaryText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var mailTextField: InformationTextField = {
        let placeholderText = NSLocalizedString("mailTextFieldPlaceholder", comment: "")
        let textField = InformationTextField(placeholderText: placeholderText)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var mailErrorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.cardsText
        label.textColor = ColorScheme.secondaryText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var passwordTextField: InformationTextField = {
        let placeholderText = NSLocalizedString("passwordTextFieldPlaceholder", comment: "")
        let textField = InformationTextField(placeholderText: placeholderText)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.cardsText
        label.textColor = ColorScheme.secondaryText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var continueButton: MainButton = {
        let title = NSLocalizedString("continueButton", comment: "")
        let button = MainButton(title: title, titleColor: ColorScheme.mainText, backgroundColor: ColorScheme.accent)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    weak var delegate: AuthorizationViewDelegate?

    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        addSubviews()
        setupConstraints()
        addViewGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Module functions
    func applyState(_ state: State) {
        switch state {
        case .error(let errorTextFieldInfo):
                switch errorTextFieldInfo.type {
                case .mail:
                    mailErrorLabel.text = errorTextFieldInfo.error
                    mailTextField.layer.borderColor = UIColor.red.cgColor
                case .password:
                    passwordErrorLabel.text = errorTextFieldInfo.error
                    passwordTextField.layer.borderColor = UIColor.red.cgColor
                }
        }
    }

    private func configureView() {
        backgroundColor = ColorScheme.background
    }

    private func setupConstraints() {
        setupNavigationBarConstraints()
        setupDescriptionLabelConstraints()
        setupTextFieldsConstraints()
        setupContinueButtonConstraints()
    }

    private func addSubviews() {
        addSubview(navigationBarView)
        navigationBarView.addSubview(navigationBarBackButton)
        navigationBarView.addSubview(navigationBarTitleLabel)
        addSubview(descriptionLabel)
        addSubview(mailTextField)
        addSubview(mailErrorLabel)
        addSubview(passwordTextField)
        addSubview(passwordErrorLabel)
        addSubview(continueButton)
    }

    private func addViewGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tap)
    }

    // MARK: - Actions
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }

    @objc private func continueButtonTapped() {
        guard let mail = mailTextField.text, let password = passwordTextField.text else { return }
        delegate?.continueButtonTapped(mail: mail, password: password)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}

// MARK: - Setup constraints
extension AuthorizationView {

    private func setupNavigationBarConstraints() {
        NSLayoutConstraint.activate([
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBarView.topAnchor.constraint(equalTo: topAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: CommonConstants.safeAreaInsetsTop + 44 + 40),

            navigationBarBackButton.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor,
                                                             constant: CommonConstants.bigSpacing),
            navigationBarBackButton.heightAnchor.constraint(equalToConstant: CommonConstants.navigationBarIconSide),
            navigationBarBackButton.widthAnchor.constraint(equalToConstant: CommonConstants.navigationBarIconSide),
            navigationBarBackButton.centerYAnchor.constraint(equalTo: navigationBarTitleLabel.centerYAnchor),

            navigationBarTitleLabel.leadingAnchor.constraint(equalTo: navigationBarBackButton.trailingAnchor,
                                                             constant: CommonConstants.smallSpacing),
            navigationBarTitleLabel.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
        ])
    }

    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor,
                                                  constant: CommonConstants.smallSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CommonConstants.bigSpacing),
            trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: CommonConstants.bigSpacing)
        ])
    }

    private func setupTextFieldsConstraints() {
        NSLayoutConstraint.activate([
            mailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CommonConstants.bigSpacing),
            trailingAnchor.constraint(equalTo: mailTextField.trailingAnchor, constant: CommonConstants.bigSpacing),
            mailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                               constant: CommonConstants.bigSpacing),
            mailTextField.heightAnchor.constraint(equalToConstant: CommonConstants.textFieldHeight),

            mailErrorLabel.topAnchor.constraint(equalTo: mailTextField.bottomAnchor,
                                                constant: CommonConstants.smallStackSpacing),
            mailErrorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CommonConstants.bigSpacing),
            trailingAnchor.constraint(equalTo: mailErrorLabel.trailingAnchor, constant: CommonConstants.bigSpacing),

            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CommonConstants.bigSpacing),
            trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: CommonConstants.bigSpacing),
            passwordTextField.topAnchor.constraint(equalTo: mailErrorLabel.bottomAnchor,
                                                   constant: CommonConstants.smallSpacing),
            passwordTextField.heightAnchor.constraint(equalToConstant: CommonConstants.textFieldHeight),

            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                    constant: CommonConstants.smallStackSpacing),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CommonConstants.bigSpacing),
            trailingAnchor.constraint(equalTo: passwordErrorLabel.trailingAnchor, constant: CommonConstants.bigSpacing),
        ])
    }

    private func setupContinueButtonConstraints() {
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CommonConstants.bigSpacing),
            trailingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: CommonConstants.bigSpacing),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor,
                                                        constant: CommonConstants.bigSpacing),
            continueButton.heightAnchor.constraint(equalToConstant: CommonConstants.buttonHeight)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension AuthorizationView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if textField === mailTextField {
            mailErrorLabel.text = ""
        } else if textField === passwordTextField {
            passwordErrorLabel.text = ""
        }

        if text.isEmpty {
            textField.layer.borderColor = ColorScheme.inactive.cgColor
        } else {
            textField.layer.borderColor = ColorScheme.mainText.cgColor
        }
    }
}
