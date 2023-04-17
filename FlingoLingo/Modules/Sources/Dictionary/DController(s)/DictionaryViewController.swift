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
    open var tableSpacing = 10
    private lazy var network: NetworkRequest = {
        let network = NetworkRequest()
        return network
    }()
    private lazy var networkFetcher: NetworkFetcher = {
        let networkFetcher = NetworkFetcher(network: network)
        return networkFetcher
    }()
    var sinonimsCount = 0
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    var tableData: Word = Word(def: nil)
    var blockAppearance = false

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
        [tableView, topLabel, originLanguage, arrow, translatedLanguage, suggestionView, textField].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        let centerConstraint = topLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                                             constant: 75)
        let selectedLanguageConstant = originLanguage.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                               constant: 15)
        let arrowConstraint = arrow.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let suggestionViewConstraint = suggestionView.topAnchor.constraint(equalTo: originLanguage.bottomAnchor,
                                                                           constant: 25)
        self.centerConstraint = centerConstraint
        self.selectedLanguageConstant = selectedLanguageConstant
        self.arrowConstraint = arrowConstraint
        self.suggestionViewConstraint = suggestionViewConstraint
        textField.rw.button.addTarget(self, action: #selector(textFieldFunc),
                                      for: .touchUpInside)
        let topLabelConstraints = [
            centerConstraint,
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 15),
            topLabel.heightAnchor.constraint(equalTo: view.widthAnchor,
                                             multiplier: 0.1)
        ]
        let selectedLanguages = [
            selectedLanguageConstant,
            originLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                constant: 15),
            arrow.leadingAnchor.constraint(equalTo: originLanguage.trailingAnchor,
                                           constant: 15),
            arrow.centerYAnchor.constraint(equalTo: originLanguage.centerYAnchor),
            translatedLanguage.leadingAnchor.constraint(equalTo: arrow.trailingAnchor,
                                                        constant: 15),
            translatedLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                    constant: 15)
        ]
        let textFieldConstraints = [
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -15),
            textField.topAnchor.constraint(equalTo: originLanguage.bottomAnchor,
                                           constant: 25)
        ]
        let suggestionViewConstraints = [
            suggestionViewConstraint,
            suggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 15),
            suggestionView.heightAnchor.constraint(equalToConstant: 40),
            suggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -15)
        ]
        let tableConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -15),
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                           constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,
                                              constant: -15)
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
        textField.rw.button.addTarget(self, action: #selector(clear),
                                      for: .touchUpInside)
        suggestionView.addTarget(self, action: #selector(suggestWasAccepted),
                                 for: .touchUpInside)
        arrow.addTarget(self, action: #selector(langsChanging), for: .touchUpInside)
    }
    private var workItem: DispatchWorkItem?
    private var languagesPairApiCode = "en-ru"
}
extension DictionaryViewController {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        blockAppearance = false
        textField.layer.opacity = 1
        sinonimsCount = 0
        tableView.reloadData()
        topLabel.isHidden = true
        centerConstraint?.constant = 0
        arrow.layer.opacity = 0.4
        self.suggestionView.isHidden = true
        self.suggestionViewConstraint?.constant = 25
        NSLayoutConstraint.activate([self.suggestionViewConstraint!])
        self.suggestionView.setTitle("",
                                     for: .normal)
        NSLayoutConstraint.deactivate([self.selectedLanguageConstant!])
        NSLayoutConstraint.activate([self.arrowConstraint!])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
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
                self?.networkFetcher.getWord(lungs:
                                                self?.languagesPairApiCode ?? "",
                                             text:
                                                self?.textField.text?.trimmingCharacters(in:
                                                    .whitespaces) ?? " ") { word in
                                                        if self?.sinonimsCount == 0 && !(self?.textField.text?.isEmpty ?? true) && !(self?.blockAppearance ?? true) {
                        self?.textField.layer.opacity = 1
                        self?.suggestionView.setTitle(word?.def?.first?.text,
                                                      for: .normal)
                        self?.suggestionViewConstraint?.constant = 75
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
        suggestionViewConstraint?.constant = 25
        NSLayoutConstraint.activate([self.suggestionViewConstraint!])
        suggestionView.setTitle("",
                                     for: .normal)
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
            self.workItem?.cancel()
        }
        suggestionView.isHidden = true
        self.suggestionViewConstraint?.constant = 25
        NSLayoutConstraint.activate([self.suggestionViewConstraint!])
        self.suggestionView.setTitle("",
                                     for: .normal)
        self.view.layoutIfNeeded()
        tableView.reloadData()
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            textField.layer.opacity = 0.4
        }
        topLabel.isHidden = false
        centerConstraint!.constant = 75
        selectedLanguageConstant?.constant = 15
        NSLayoutConstraint.deactivate([arrowConstraint!])
        NSLayoutConstraint.activate([selectedLanguageConstant!])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.workItem?.cancel()
        arrow.layer.opacity = 1
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }
    func loadMenanings() {
        arrow.layer.opacity = 1
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

        default:
            languagesPairApiCode = "en-ru"
        }
        suggestWasAccepted()
        textField.text = ""
    }
}
