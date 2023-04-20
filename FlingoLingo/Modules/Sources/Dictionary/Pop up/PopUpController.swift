//
//  File.swift
//
//
//  Created by Yandex on 17.04.2023.
//

import Foundation
import UIKit
import UIComponents
import NetworkLayer
import Decks

public final class PopUpViewController: UIViewController {
    public lazy var wordName = " "
    public lazy var transcription = " "
    public lazy var translation = " "
    public lazy var originalExample = " "
    public lazy var translatedExample = " "
    private lazy var popUpView: UIView = {
        let popUp = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 490))
        popUp.layer.cornerRadius = CommonConstants.cornerRadius
        popUp.backgroundColor = ColorScheme.background
        popUp.translatesAutoresizingMaskIntoConstraints = false
        popUp.layer.shadowColor = UIColor.black.cgColor
        popUp.layer.shadowRadius = 150
        popUp.layer.shadowOpacity = 1
        popUp.layer.shadowOffset = CGSize(width: 0, height: 0)
        return popUp
    }()
    private lazy var downView: UIView = {
        let downView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        return downView
    }()
    private lazy var blackFrame: UIView = {
        let blackFrame = UIView()
        blackFrame.backgroundColor = ColorScheme.darkBackground
        blackFrame.translatesAutoresizingMaskIntoConstraints = false
        blackFrame.layer.cornerRadius = CommonConstants.cornerRadius
        return blackFrame
    }()
    private lazy var topLabel: UILabel = {
        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.textColor = ColorScheme.mainText
        topLabel.font = Fonts.largeTitle
        return topLabel
    }()
    private lazy var transcriptionLabel: UILabel = {
        let transcriptionLabel = UILabel()
        transcriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        transcriptionLabel.textColor = ColorScheme.mainText
        transcriptionLabel.font = Fonts.buttonTitle
        return transcriptionLabel
    }()
    private lazy var translationLabel: UILabel = {
        let translationLabel = UILabel()
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        translationLabel.textColor = ColorScheme.accent
        translationLabel.font = Fonts.mainText
        translationLabel.backgroundColor = .init(red: 210/255, green: 67/255, blue: 102/255, alpha: 0.5)
        translationLabel.clipsToBounds = true
        translationLabel.sizeToFit()
        translationLabel.layer.cornerRadius = 12.5
        return translationLabel
    }()
    private lazy var originalExampleLabel: UILabel = {
        let originalExampleLabel = UILabel()
        originalExampleLabel.translatesAutoresizingMaskIntoConstraints = false
        originalExampleLabel.textColor = ColorScheme.mainText
        originalExampleLabel.font = Fonts.mainText
        originalExampleLabel.numberOfLines = 0
        return originalExampleLabel
    }()
    private lazy var translatedExampleLabel: UILabel = {
        let translatedExampleLabel = UILabel()
        translatedExampleLabel.translatesAutoresizingMaskIntoConstraints = false
        translatedExampleLabel.textColor = ColorScheme.mainText
        translatedExampleLabel.font = Fonts.mainText
        translatedExampleLabel.numberOfLines = 0
        translatedExampleLabel.layer.opacity = 0.4
        return translatedExampleLabel
    }()
    private lazy var addingButton: MainButton = {
        let addingButton = MainButton(title: "Добавить",
                                      titleColor: ColorScheme.mainText,
                                      backgroundColor: ColorScheme.accent)
        addingButton.translatesAutoresizingMaskIntoConstraints = false
        return addingButton
    }()
    private lazy var performing = UIActivityIndicatorView()
    private var data: [DomainDeck] = [DomainDeck(deckResponse:
                                                    DeckResponse(id: -1,
                                                                 isPrivate: false,
                                                                 name: "Новая колода",
                                                                 cards: []))]
    private var selectedDecksIds: [Int] = []
    private lazy var decksCollection = CollectionViews.collectionView()
    var langsApi = ""
    var index = 1
    var rusWord = ""
    var engWord = ""

    private let decksProvider: DecksProvider

    init(decksProvider: DecksProvider) {
        self.decksProvider = decksProvider
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismis))
        downView.addGestureRecognizer(tapGesture)
        [downView, popUpView, performing].forEach { views in
            view.addSubview(views)
        }
        view.backgroundColor = .clear
        decksCollection.dataSource = self
        decksCollection.delegate = self
        decksCollection.register(PopUpTableViewCell.self, forCellWithReuseIdentifier: "ID")
        performing.translatesAutoresizingMaskIntoConstraints = false
        performing.startAnimating()
        performing.style = .large
        NSLayoutConstraint.activate([downView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     downView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     performing.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     performing.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     popUpView.widthAnchor.constraint(equalToConstant: 340),
                                     popUpView.heightAnchor.constraint(equalToConstant: 490)])

        [blackFrame, decksCollection, addingButton].forEach { label in
            popUpView.addSubview(label)
        }
        [topLabel, transcriptionLabel, translationLabel,
         originalExampleLabel, translatedExampleLabel].forEach { label in
            blackFrame.addSubview(label)
        }
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: blackFrame.topAnchor,
                                          constant: CommonConstants.smallSpacing),
            topLabel.leadingAnchor.constraint(equalTo: blackFrame.leadingAnchor,
                                              constant: CommonConstants.smallSpacing),
            topLabel.trailingAnchor.constraint(equalTo: blackFrame.trailingAnchor,
                                               constant: -CommonConstants.smallSpacing),
            blackFrame.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor,
                                                constant: CommonConstants.bigSpacing),
            blackFrame.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor,
                                                 constant: -CommonConstants.bigSpacing),
            blackFrame.topAnchor.constraint(equalTo: popUpView.topAnchor,
                                            constant: CommonConstants.bigSpacing),
            blackFrame.heightAnchor.constraint(equalToConstant: 270),
            transcriptionLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor,
                                                    constant: CommonConstants.smallSpacing),
            transcriptionLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
            transcriptionLabel.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor),
            translationLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                  constant: CommonConstants.smallSpacing),
            translationLabel.heightAnchor.constraint(equalToConstant: 30),
            translationLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
            originalExampleLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
            originalExampleLabel.topAnchor.constraint(equalTo: transcriptionLabel.bottomAnchor,
                                                      constant: CommonConstants.smallSpacing),
            originalExampleLabel.widthAnchor.constraint(equalToConstant: 260),
            originalExampleLabel.bottomAnchor.constraint(equalTo: translatedExampleLabel.topAnchor,
                                                         constant: -CommonConstants.smallSpacing),
            translatedExampleLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
            translatedExampleLabel.topAnchor.constraint(equalTo: originalExampleLabel.bottomAnchor,
                                                        constant: CommonConstants.smallSpacing),
            translatedExampleLabel.widthAnchor.constraint(equalToConstant: 260),
            translatedExampleLabel.bottomAnchor.constraint(lessThanOrEqualTo: blackFrame.bottomAnchor,
                                                           constant: -CommonConstants.smallSpacing),
            addingButton.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor,
                                                 constant: -CommonConstants.bigSpacing),
            addingButton.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor,
                                                  constant: CommonConstants.smallSpacing),
            addingButton.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor,
                                                   constant: -CommonConstants.smallSpacing),
            addingButton.heightAnchor.constraint(equalToConstant: 55),
            decksCollection.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor),
            decksCollection.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor),
            decksCollection.topAnchor.constraint(equalTo: blackFrame.bottomAnchor,
                                                 constant: CommonConstants.smallSpacing),
            decksCollection.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadCards()
        addingButton.layer.opacity = 0.5
        addingButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        transcriptionLabel.text = transcription
        topLabel.text = translation
        translationLabel.text = "  \(wordName)  "
        originalExampleLabel.text = translatedExample
        translatedExampleLabel.text = originalExample
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        selectedDecksIds = []
        decksCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
        decksCollection.reloadData()
        dismiss(animated: true)
    }

    @objc func dismis() {
        dismiss(animated: true)
    }

    @objc func add() {
        performing.isHidden = false
        guard !selectedDecksIds.isEmpty else {
            return
        }
        var dataArray: [Int] = []
        for item in selectedDecksIds {
            dataArray.append(item)
        }
        switch langsApi {
        case "en-ru": rusWord = translation
            engWord = wordName
        default: rusWord = wordName
            engWord = translation
        }
        if dataArray.contains(-1) {
            createNewDeck()
        }
        if dataArray.contains(-1) {
            dataArray.remove(at: 0)
        }
        addingCards(dataArray)
    }

    private func addingCards(_ deckIds: [Int]) {
        decksProvider.insertCardToDeck(request:
                                        InsertCardRequest(eng: engWord,
                                                          rus: rusWord,
                                                          transcription: transcription,
                                                          examples: translatedExample,
                                                          decks: deckIds)) { [weak self] _ in
            DispatchQueue.main.async {
                self?.performing.isHidden = true
                self?.dismiss(animated: true)
            }
        }
    }

    private func createNewDeck() {
        decksProvider.createNewDeck(name: "Новая колода") { result in
            switch result {
            case .success(let data):
                self.addingCards([data.id])
            case .failure(let error):
                print(error)
            }
        }
    }
    private func reloadCards() {
        decksProvider.getAllDecks { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    var datum = data
                    datum.append(DomainDeck(deckResponse: DeckResponse(id: -1,
                                                                       isPrivate: false,
                                                                       name: "Новая колода",
                                                                       cards: [])))
                    self.data = datum
                    self.decksCollection.reloadData()
                    self.performing.isHidden = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PopUpViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID",
                                                            for: indexPath) as? PopUpTableViewCell else {
            return PopUpTableViewCell()
        }
        cell.deckName.text = "\(data[indexPath.row % data.count].title)"
        if selectedDecksIds.contains(data[indexPath.row % data.count].id) {
            cell.backgroundColor = ColorScheme.accent
        } else {
            cell.backgroundColor = ColorScheme.darkBackground
        }
        if data[indexPath.row % data.count].id == -1 {
            cell.deckName.font = Fonts.mainTextBold
            cell.deckName.text = "+ новая колода"
        }
        else {
            cell.deckName.font = Fonts.mainText
        }
        return cell
    }
}
extension PopUpViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: decksCollection.frame.height)
    }
}
extension PopUpViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedDecksIds.contains(data[indexPath.row % data.count].id) {
            for ind in 0..<selectedDecksIds.count {
                if selectedDecksIds.count > ind {
                    if selectedDecksIds[ind] == data[indexPath.row % data.count].id {
                        selectedDecksIds.remove(at: ind)
                    }
                }
            }
        } else {
            selectedDecksIds.append(data[indexPath.row % data.count].id)
        }
        if selectedDecksIds.isEmpty {
            addingButton.layer.opacity = 0.5
        } else {
            addingButton.layer.opacity = 1
        }
        collectionView.reloadData()
    }
}
