//
//  DictionaryViewController.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import UIKit
import UIComponents
import Decks

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
        tableView.allowsSelection = true
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

    public lazy var suggestionView: SuggestionView = {
        let suggestionView = SuggestionView()
        suggestionView.translatesAutoresizingMaskIntoConstraints = false
        return suggestionView
    }()

    private var centerConstraint: NSLayoutConstraint?
    private var selectedLanguageConstant: NSLayoutConstraint?
    private var arrowConstraint: NSLayoutConstraint?
    private var suggestionViewConstraint: NSLayoutConstraint?
    var tableSpacing = 10
    private lazy var network: NetworkRequest = {
        let network = NetworkRequest()
        return network
    }()
    private lazy var networkFetcher: NetworkFetcher = {
        let networkFetcher = NetworkFetcher(network: network)
        return networkFetcher
    }()
    lazy var sinonimsCount = 0
    lazy var tableData: Word = Word(def: nil)
    lazy var blockAppearance = false
    lazy var popOverVC = PopUpViewController(decksProvider: decksProvider)
    private var workItem: DispatchWorkItem?
    public var languagesPairApiCode = "en-ru"
    private let decksProvider: DecksProvider

    public init(decksProvider: DecksProvider) {
        self.decksProvider = decksProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // swiftlint:disable function_body_length
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.background
        [tableView, topLabel, originLanguage,
         arrowButton, translatedLanguage,
         suggestionView, textField].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        let centerConstraint = topLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                constant: 40)
        let selectedLanguageConstant = originLanguage.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                               constant: CommonConstants.bigSpacing)
        let arrowConstraint = arrowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let suggestionViewConstraint = suggestionView.topAnchor.constraint(equalTo: originLanguage.bottomAnchor,
                                                                           constant: 25)
        self.centerConstraint = centerConstraint
        self.selectedLanguageConstant = selectedLanguageConstant
        self.arrowConstraint = arrowConstraint
        self.suggestionViewConstraint = suggestionViewConstraint
        textField.rightViewButton.button.addTarget(self, action: #selector(textFieldFunc),
                                      for: .touchUpInside)
        let topLabelConstraints = [
            centerConstraint,
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: CommonConstants.bigSpacing),
            topLabel.heightAnchor.constraint(equalTo: view.widthAnchor,
                                             multiplier: 0.1)
        ]
        let selectedLanguages = [
            selectedLanguageConstant,
            originLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                constant: CommonConstants.smallSpacing),
            arrowButton.leadingAnchor.constraint(equalTo: originLanguage.trailingAnchor,
                                           constant: CommonConstants.bigSpacing),
            arrowButton.centerYAnchor.constraint(equalTo: originLanguage.centerYAnchor),
            translatedLanguage.leadingAnchor.constraint(equalTo: arrowButton.trailingAnchor,
                                                        constant: CommonConstants.bigSpacing),
            translatedLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                    constant: 15)
        ]
        let textFieldConstraints = [
            textField.heightAnchor.constraint(equalToConstant: CommonConstants.textFieldHeight),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: CommonConstants.bigSpacing),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -CommonConstants.bigSpacing),
            textField.topAnchor.constraint(equalTo: originLanguage.bottomAnchor,
                                           constant: CommonConstants.bigSpacing)
        ]
        let suggestionViewConstraints = [
            suggestionViewConstraint,
            suggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: CommonConstants.bigSpacing),
            suggestionView.heightAnchor.constraint(equalToConstant: CommonConstants.textFieldHeight),

            suggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -CommonConstants.bigSpacing)
        ]
        let tableConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: CommonConstants.bigSpacing),

            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -CommonConstants.bigSpacing),
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                           constant: CommonConstants.smallSpacing),
            tableView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,
                                              constant: -CommonConstants.smallSpacing)
        ]
        NSLayoutConstraint.activate(topLabelConstraints)
        NSLayoutConstraint.activate(selectedLanguages)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(tableConstraints)
        NSLayoutConstraint.activate(suggestionViewConstraints)
        textField.addTarget(self, action: #selector(textFieldFunc),
                            for: .allEditingEvents)
        textField.addTarget(self, action: #selector(clear),
                            for: .editingChanged)
        textField.addTarget(self, action: #selector(clear),
                            for: .editingDidBegin)
        textField.rightViewButton.button.addTarget(self, action: #selector(clear),
                                      for: .touchUpInside)
        suggestionView.addTarget(self, action: #selector(suggestWasAccepted),
                                 for: .touchUpInside)
        arrowButton.addTarget(self, action: #selector(langsChanging), for: .touchUpInside)
        // swiftlint:enable function_body_length
    }
}

extension DictionaryViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        blockAppearance = false
        sinonimsCount = 0
        tableView.reloadData()
        topLabel.isHidden = true
        centerConstraint?.constant = -30
        suggestionView.isHidden = true
        suggestionViewConstraint?.constant = 25
        NSLayoutConstraint.activate([self.suggestionViewConstraint!])
        updateSuggestTitle("")
        NSLayoutConstraint.deactivate([self.selectedLanguageConstant!])
        NSLayoutConstraint.activate([self.arrowConstraint!])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
        suggestionView.isHidden = true
        suggestionViewConstraint?.constant = CommonConstants.bigSpacing
        NSLayoutConstraint.activate([self.suggestionViewConstraint!])
        updateSuggestTitle("")
        view.layoutIfNeeded()
        tableView.reloadData()
    }

    private func updateSuggestTitle(_ title: String?) {
        if title?.trimmingCharacters(in: .whitespaces) ?? "" != "" {
            suggestionView.setTitle(title, for: .normal)
            suggestionView.isEnabled = true
        } else {
            suggestionView.setTitle("не найдено", for: .normal)
            suggestionView.isEnabled = false
        }
    }

    func textFieldEdited() {
        // отменяем старый айтем
        self.workItem?.cancel()
        tableView.reloadData()
        self.textField.layer.opacity = 1
        // новая альтернатива таймера
        let workItem = DispatchWorkItem { [weak self] in
            if !(self?.textField.text?.isEmpty ?? true) {
                self?.networkFetcher.getWord(
                    lungs:
                                                self?.languagesPairApiCode ?? "",
                                             text:
                                                self?.textField.text?.trimmingCharacters(in:
                                                    .whitespaces) ?? " ") { word in
                                                        if self?.sinonimsCount == 0 &&
                                                            !(self?.textField.text?.isEmpty ?? true) &&
                                                            !(self?.blockAppearance ?? true) {
                        self?.textField.layer.opacity = 1
                                                            self?.updateSuggestTitle(word?.def?.first?.text)
                        self?.suggestionViewConstraint?.constant = 80
                        self?.suggestionView.isHidden = false
                        NSLayoutConstraint.activate([self!.suggestionViewConstraint!])
                        UIView.animate(withDuration: 0.25) {
                            self?.view.layoutIfNeeded()
                        }
                    }
                }
            }
        }
        // вызываем айтем
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: workItem)
        self.workItem = workItem
    }
    func suggestWasSelected() {
        workItem?.cancel()
        blockAppearance = true
        textField.text = suggestionView.title(for: .normal) ?? ""
        suggestionView.isHidden = true
        suggestionViewConstraint?.constant = CommonConstants.bigSpacing
        NSLayoutConstraint.activate([self.suggestionViewConstraint!])
        updateSuggestTitle("")
        view.layoutIfNeeded()
        textField.resignFirstResponder()
        loadMenanings()
    }
    @objc func suggestWasAccepted() {
        suggestWasSelected()
    }
    @objc func textFieldFunc() {
        textFieldEdited()
    }
    @objc func clear() {
        sinonimsCount = 0
        if textField.text?.isEmpty ?? false {
            textField.layer.opacity = 0.4
            workItem?.cancel()
        }
        suggestionView.isHidden = true
        suggestionViewConstraint?.constant = CommonConstants.bigSpacing
        NSLayoutConstraint.activate([self.suggestionViewConstraint!])
        updateSuggestTitle("")
        view.layoutIfNeeded()
        tableView.reloadData()
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            textField.layer.opacity = 0.4
        }
        topLabel.isHidden = false
        centerConstraint!.constant = 40
        selectedLanguageConstant?.constant = CommonConstants.bigSpacing
        NSLayoutConstraint.deactivate([arrowConstraint!])
        NSLayoutConstraint.activate([selectedLanguageConstant!])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.workItem?.cancel()
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
    func loadMenanings() {
        arrowButton.layer.opacity = 1
        networkFetcher.getWord(lungs: languagesPairApiCode,
                               text: textField.text?.trimmingCharacters(in: .whitespaces) ?? " ") { word in
            self.tableData = word ?? Word(def: nil)
            self.sinonimsCount = word?.def?.first?.tr?.count ?? 0
            self.tableView.reloadData()
        }
        textField.layer.opacity = 0.4
    }
    @objc func langsChanging() {
        let origin = originLanguage.titleLabel?.text ?? ""
        let translated = translatedLanguage.titleLabel?.text ?? ""
        originLanguage.setTitle(translated)
        translatedLanguage.setTitle(origin)
        switch languagesPairApiCode {
        case "en-ru":
            languagesPairApiCode = "ru-en"
            textField.languageCode = "ru-RU"

        default:
            languagesPairApiCode = "en-ru"
            textField.languageCode = "en-US"
        }
        suggestWasAccepted()
        textField.text = ""
    }
}
