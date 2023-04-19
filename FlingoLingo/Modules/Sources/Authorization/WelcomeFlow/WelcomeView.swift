//
//  WelcomeView.swift
//  FlingoLingo
//
//  Created by Alexander Muratov on 4/12/23.
//

import UIKit
import UIComponents

protocol WelcomeViewDelegate: AnyObject {

    func signUpButtonTapped()
    func logInButtonTapped()
    func guestLogInButtonTapped()
}

final class WelcomeView: UIView {

    // MARK: - Properties
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("appNameLabel", comment: "")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Fonts.largeTitle
        label.textColor = ColorScheme.mainText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("appDescriptionLabel", comment: "")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Fonts.mainText
        label.textColor = ColorScheme.secondaryText
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var appInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appNameLabel, appDescriptionLabel])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var logInButton: MainButton = {
        let title = NSLocalizedString("logInButton", comment: "")
        let button = MainButton(title: title, titleColor: ColorScheme.mainText, backgroundColor: ColorScheme.background)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CommonConstants.cornerRadius
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1).cgColor

        return button
    }()

    private lazy var signUpButton: MainButton = {
        let title = NSLocalizedString("signUpButton", comment: "")
        let button = MainButton(title: title, titleColor: ColorScheme.mainText, backgroundColor: ColorScheme.accent)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var guestLogInButton: MainButton = {
        let title = NSLocalizedString("guestLogInButton", comment: "")
        let button = MainButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(ColorScheme.secondaryText, for: .normal)
        button.titleLabel?.font = Fonts.mainText
        button.addTarget(self, action: #selector(guestLogInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private lazy var imageBackgroundView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background")!)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    weak var delegate: WelcomeViewDelegate?

    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Module functions
    private func setupViews() {
        backgroundColor = ColorScheme.darkBackground
    }

    private func setupConstraints() {

        setupAppInfoStackViewConstraints()
        setupButtonsConstraints()
        setupBackgroundImageConstraints()
    }

    private func addSubviews() {

        addSubview(appInfoStackView)
        addSubview(logInButton)
        addSubview(signUpButton)
        addSubview(guestLogInButton)
        addSubview(imageBackgroundView)
        sendSubviewToBack(imageBackgroundView)
    }

    // MARK: - Actions
    @objc private func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
    }

    @objc private func logInButtonTapped() {
        delegate?.logInButtonTapped()
    }

    @objc private func guestLogInButtonTapped() {
        delegate?.guestLogInButtonTapped()
    }
}

// MARK: - Setup constraints
extension WelcomeView {

    private func setupAppInfoStackViewConstraints() {

        NSLayoutConstraint.activate([

            appInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: appInfoStackView.trailingAnchor, constant: 25),
            centerYAnchor.constraint(equalTo: appInfoStackView.centerYAnchor, constant: 60)
        ])
    }

    private func setupButtonsConstraints() {

        NSLayoutConstraint.activate([

            guestLogInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: guestLogInButton.trailingAnchor, constant: 25),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: guestLogInButton.bottomAnchor, constant: 25),
            guestLogInButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor, constant: 25),
            guestLogInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),

            logInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            trailingAnchor.constraint(equalTo: logInButton.trailingAnchor, constant: 25),
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 15),
        ])
    }

    private func setupBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            imageBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageBackgroundView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
