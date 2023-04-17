//
//  DictionaryViewController.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import UIKit
import UIComponents

public final class DictionaryViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DictionaryTableViewCell.self, forCellReuseIdentifier: "DTableViewCell")
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = CommonConstants.textFieldCornerRadius
        tableView.allowsSelection = false
        return tableView
    }()

    private lazy var topLabel: UILabel = {
        let topLabel = UILabel()
        topLabel.font = Fonts.largeTitle
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.text = "Словарь"
        topLabel.textColor = ColorScheme.mainText

        return topLabel
    }()

    private lazy var originLanguage: LanguageButton = {
        let originLanguage = LanguageButton()
        originLanguage.setTitle("Английский")
        return originLanguage
    }()

    private lazy var translatedLanguage: LanguageButton = {
        let translatedLanguage = LanguageButton()
        translatedLanguage.setTitle("Русский")
        return translatedLanguage
    }()

    private lazy var arrowButton: UIButton = {
        let arrow = UIButton()
        arrow.backgroundColor = .clear
        arrow.tintColor = ColorScheme.mainText
        arrow.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        return arrow
    }()

    private lazy var textField: DTextField = {
        let textField = DTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()

    private lazy var suggestionView: SuggestionView = {
        let suggestionView = SuggestionView()
        suggestionView.translatesAutoresizingMaskIntoConstraints = false
        return suggestionView
    }()

    private var centerConstraint: NSLayoutConstraint?
    private var selectedLanguageConstant: NSLayoutConstraint?
    private var arrowConstraint: NSLayoutConstraint?
    private var suggestionViewConstraint: NSLayoutConstraint?

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.background
        self.navigationController?.isNavigationBarHidden = true
        [tableView,
         topLabel,
         originLanguage,
         arrowButton,
         translatedLanguage,
         suggestionView,
         textField].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        let centerConstraint = topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75)
        let selectedLanguageConstant = originLanguage.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                               constant: CommonConstants.smallSpacing)
        let arrowConstraint = arrowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let suggestionViewConstraint = suggestionView.topAnchor.constraint(equalTo: originLanguage.bottomAnchor,
                                                                           constant: CommonConstants.bigSpacing)
        self.centerConstraint = centerConstraint
        self.selectedLanguageConstant = selectedLanguageConstant
        self.arrowConstraint = arrowConstraint
        self.suggestionViewConstraint = suggestionViewConstraint
        let topLabelConstraints = [
            centerConstraint,
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CommonConstants.smallSpacing),
            topLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
            ]

        let selectedLanguages = [
            selectedLanguageConstant,

            originLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: CommonConstants.smallSpacing),
            arrowButton.leadingAnchor.constraint(equalTo: originLanguage.trailingAnchor,
                                               constant: CommonConstants.smallSpacing),
            arrowButton.centerYAnchor.constraint(equalTo: originLanguage.centerYAnchor),

            translatedLanguage.leadingAnchor.constraint(equalTo: arrowButton.trailingAnchor,
                                                        constant: CommonConstants.smallSpacing),
            translatedLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                    constant: CommonConstants.smallSpacing)
        ]

        let textFieldConstraints = [
            textField.heightAnchor.constraint(equalToConstant: CommonConstants.bottomPadding),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CommonConstants.smallSpacing),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CommonConstants.smallSpacing),
            textField.topAnchor.constraint(equalTo: originLanguage.bottomAnchor, constant: CommonConstants.bigSpacing)
        ]

        let suggestionViewConstraints = [
            suggestionViewConstraint,
            suggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: CommonConstants.smallSpacing),
            suggestionView.heightAnchor.constraint(equalToConstant: CommonConstants.bottomPadding),
            suggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -CommonConstants.smallSpacing)
        ]

        let tableConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CommonConstants.smallSpacing),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CommonConstants.smallSpacing),
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: CommonConstants.smallSpacing),
            tableView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,
                                              constant: -CommonConstants.smallSpacing)
            ]

        NSLayoutConstraint.activate([topLabelConstraints,
                                     selectedLanguages,
                                     textFieldConstraints,
                                     tableConstraints,
                                     suggestionViewConstraints].flatMap { $0 })
    }
}

extension DictionaryViewController: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.opacity = 1
        topLabel.isHidden = true
        centerConstraint?.constant = 0
        suggestionViewConstraint?.constant = 75
        guard let selectedLanguageConstant = self.selectedLanguageConstant else {
            return
        }
        guard let arrowConstraint = self.arrowConstraint else {
            return
        }
        guard let suggestionViewConstraint = self.suggestionViewConstraint else {
            return
        }
        NSLayoutConstraint.deactivate([selectedLanguageConstant])
        NSLayoutConstraint.activate([arrowConstraint, suggestionViewConstraint])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.opacity = 0.4
        topLabel.isHidden = false
        centerConstraint!.constant = 75
        selectedLanguageConstant?.constant = CommonConstants.smallSpacing
        guard let selectedLanguageConstant = self.selectedLanguageConstant else {
            return
        }
        guard let arrowConstraint = self.arrowConstraint else {
            return
        }
        guard var suggestionViewConstraint = self.suggestionViewConstraint else {
            return
        }
        NSLayoutConstraint.deactivate([arrowConstraint, suggestionViewConstraint])
        suggestionViewConstraint = suggestionView.topAnchor.constraint(equalTo: originLanguage.bottomAnchor,
                                                                        constant: CommonConstants.bigSpacing)
        NSLayoutConstraint.activate([selectedLanguageConstant, suggestionViewConstraint])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }

}
