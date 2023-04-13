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

class WelcomeView: UIView {
    
    // MARK: - Properties
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "FlingoLingo"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Fonts.largeTitle
        label.textColor = ColorScheme.label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Приложение для удобного изучения английского языка по карточкам"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Fonts.body
        label.textColor = ColorScheme.secondaryLabel
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
                
        addSubview(stackView)
        
        return stackView
    }()
    
    private lazy var logInButton: MainButton = {
        let button = MainButton(title: "Войти", titleColor: ColorScheme.label, backgroundColor: ColorScheme.background)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(button)
        
        return button
    }()
    
    private lazy var signUpButton: MainButton = {
        let button = MainButton(title: "Зарегистрироваться", titleColor: ColorScheme.label, backgroundColor: ColorScheme.fill)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(button)
        
        return button
    }()
    
    private lazy var guestLogInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти как гость", for: .normal)
        button.setTitleColor(ColorScheme.secondaryLabel, for: .normal)
        button.titleLabel?.font = Fonts.footnote
        button.addTarget(self, action: #selector(guestLogInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(button)
        
        return button
    }()
    
    weak var delegate: WelcomeViewDelegate?
    private var didSetupConstraints = false
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    public override func updateConstraints() {
        super.updateConstraints()
        
        if !didSetupConstraints {
            setupConstraints()
            didSetupConstraints = true
        }
    }
    
    // MARK: - Module functions
    private func setupViews() {
        
        backgroundColor = ColorScheme.secondaryBackground
    }
    
    private func setupConstraints() {
        
        setupAppInfoStackViewConstraints()
        setupButtonsConstraints()
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
            appInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            appInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60)
        ])
    }
    
    private func setupButtonsConstraints() {
        
        NSLayoutConstraint.activate([
            
            guestLogInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            guestLogInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            guestLogInButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25),
            guestLogInButton.heightAnchor.constraint(equalToConstant: 44),
            
            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            signUpButton.bottomAnchor.constraint(equalTo: guestLogInButton.topAnchor, constant: -10),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            
            logInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            logInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            logInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -15),
            logInButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
