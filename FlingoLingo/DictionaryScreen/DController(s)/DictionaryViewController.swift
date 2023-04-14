//
//  DictionaryViewController.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import UIKit

class DictionaryViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DictionaryTableViewCell.self, forCellReuseIdentifier: "DTableViewCell")
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.allowsSelection = false
        tableView.delegate = self
        return tableView
    }()

    private lazy var topLabel: UILabel = {
        let topLabel = UILabel()
        // шрифт потом общий
        topLabel.font = UIFont(name: "Futura Bold", size: 32)
        topLabel.translatesAutoresizingMaskIntoConstraints = false 
        topLabel.text = "Словарь"
        topLabel.textColor = .white
        
        return topLabel
    }()
    
    
    private lazy var originLanguage: Language = {
        let originLanguage = Language()
        originLanguage.setTitle("Английский")
        return originLanguage
    }()
    
    private lazy var translatedLanguage: Language = {
        let translatedLanguage = Language()
        translatedLanguage.setTitle("Русский")
        return translatedLanguage
    }()
    
    private lazy var arrow: Arrow = {
        let arrow = Arrow()
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
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        networkFetcher.getWord(lungs: "en-ru", text: "time") { word in
            print(word)
        }
        //networkFetcher.getLangs(result: fen2(_:))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
        
        [tableView, topLabel, originLanguage, arrow, translatedLanguage, suggestionView, textField].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        let centerConstraint = topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75)
        let selectedLanguageConstant = originLanguage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        let arrowConstraint = arrow.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let suggestionViewConstraint = suggestionView.topAnchor.constraint(equalTo: originLanguage.bottomAnchor, constant: 25)
        self.centerConstraint = centerConstraint
        self.selectedLanguageConstant = selectedLanguageConstant
        self.arrowConstraint = arrowConstraint
        self.suggestionViewConstraint = suggestionViewConstraint

        
        let topLabelConstraints = [
            centerConstraint,
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            topLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
            
            ]
        
        let selectedLanguages = [
            
            selectedLanguageConstant,
            
            originLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 15),

                arrow.leadingAnchor.constraint(equalTo: originLanguage.trailingAnchor, constant: 15),
                arrow.centerYAnchor.constraint(equalTo: originLanguage.centerYAnchor),

            translatedLanguage.leadingAnchor.constraint(equalTo: arrow.trailingAnchor, constant: 15),
            translatedLanguage.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 15)

        ]
        
       
        let textFieldConstraints = [
            
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: originLanguage.bottomAnchor, constant: 25)
        
        ]
        
        let suggestionViewConstraints = [
            
            suggestionViewConstraint,
            suggestionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            suggestionView.heightAnchor.constraint(equalToConstant: 40),
            suggestionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        
        ]
        
        let tableConstraints = [
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -15)

            ]
        
        NSLayoutConstraint.activate(topLabelConstraints)
        NSLayoutConstraint.activate(selectedLanguages)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(tableConstraints)
        NSLayoutConstraint.activate(suggestionViewConstraints)

    }
}


extension DictionaryViewController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.opacity = 1
        topLabel.isHidden = true
        centerConstraint?.constant = 0
        suggestionViewConstraint?.constant = 75
        NSLayoutConstraint.deactivate([self.selectedLanguageConstant!])
        NSLayoutConstraint.activate([self.arrowConstraint!, self.suggestionViewConstraint!])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.opacity = 0.4
        topLabel.isHidden = false
        centerConstraint!.constant = 75
        selectedLanguageConstant?.constant = 15
        NSLayoutConstraint.deactivate([self.arrowConstraint!, self.suggestionViewConstraint!])
        suggestionViewConstraint? = suggestionView.topAnchor.constraint(equalTo: originLanguage.bottomAnchor, constant: 25)
        NSLayoutConstraint.activate([self.selectedLanguageConstant!, self.suggestionViewConstraint!])
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }

    
}

