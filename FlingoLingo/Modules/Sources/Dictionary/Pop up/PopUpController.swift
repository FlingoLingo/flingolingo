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
        translationLabel.textColor = ColorScheme.mainText
        translationLabel.font = Fonts.mainText
        translationLabel.backgroundColor = ColorScheme.accent
        translationLabel.clipsToBounds = true
        translationLabel.layer.cornerRadius = 7
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
    private var data: [Deck] = [.init(id: -1, isPrivate: false, name: "Новая колода", description: "", cards: [])]
    private var selectedDecksIds: [Int] = []
    private lazy var decksCollection = CollectionViews.collectionView()
    var langsApi = ""
    var index = 1
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismis))
        downView.addGestureRecognizer(tapGesture)
        [downView, popUpView, performing].forEach { views in
            view.addSubview(views)
        }
        view.backgroundColor = .clear
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowRadius = 150
        popUpView.layer.shadowOpacity = 1
        popUpView.layer.shadowOffset = CGSize(width: 0, height: 0)
        decksCollection.dataSource = self
        decksCollection.delegate = self
        decksCollection.register(PopUpTableViewCell.self, forCellWithReuseIdentifier: "ID")
        decksCollection.contentInset.left = 70
        decksCollection.showsHorizontalScrollIndicator = false
        decksCollection.translatesAutoresizingMaskIntoConstraints = false
        performing.translatesAutoresizingMaskIntoConstraints = false
        decksCollection.backgroundColor = .clear
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
            blackFrame.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor,
                                                constant: CommonConstants.bigSpacing),
            blackFrame.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor,
                                                 constant: -CommonConstants.bigSpacing),
            blackFrame.topAnchor.constraint(equalTo: popUpView.topAnchor,
                                            constant: CommonConstants.bigSpacing),
            blackFrame.heightAnchor.constraint(equalToConstant: 270),
            transcriptionLabel.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor),
            transcriptionLabel.leadingAnchor.constraint(equalTo: topLabel.trailingAnchor,
                                                        constant: CommonConstants.smallSpacing),
            translationLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                  constant: CommonConstants.smallSpacing),
            translationLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
            originalExampleLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
            originalExampleLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor,
                                                      constant: CommonConstants.smallSpacing),
            originalExampleLabel.widthAnchor.constraint(equalToConstant: 260),
            translatedExampleLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
            translatedExampleLabel.topAnchor.constraint(equalTo: originalExampleLabel.bottomAnchor,
                                                        constant: CommonConstants.smallSpacing),
            translatedExampleLabel.widthAnchor.constraint(equalToConstant: 260),
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
        topLabel.text = wordName
        translationLabel.text = "  \(translation.uppercased())  "
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
        if !selectedDecksIds.isEmpty {
            self.dismiss(animated: true)
            selectedDecksIds = []
            var dataArray: [Int] = []
            for item in selectedDecksIds {
                dataArray.append(item)
            }
            var rusWord = ""
            var engWord = ""
            switch langsApi {
            case "en-ru": rusWord = translation
                engWord = wordName
            default: rusWord = wordName
                engWord = translation
            }
            CardClient(token: "00fa7675354ab19839cdd317efa545429764b77e").addCard(card: AddCard(eng: engWord,
                                                                                                rus: rusWord,
                                                                                                transcription: translation,
                                                                                                examples: translatedExample),
                                                                                  decks: dataArray) { uselessStuff in
            }
            if dataArray.contains(-1) {
                DeckClient().createDeck { result in
                    switch result {
                    case .success(let data):
                        CardClient(token: "00fa7675354ab19839cdd317efa545429764b77e").addCard(card: AddCard(eng: "ass",
                                                                                                            rus: "жопа",
                                                                                                            transcription: " ",
                                                                                                            examples: " "),
                                                                                              decks: [data.id]) { uselessStuff in
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    private func reloadCards() {
        DeckClient().getDecks { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    var datum = data
                    datum.insert(Deck(id: -1,
                                      isPrivate: false,
                                      name: "Новая колода",
                                      description: "",
                                      cards: []),
                                 at: 0)
                    self.data = datum
                    self.decksCollection.reloadData()
                    self.performing.removeFromSuperview()
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
        cell.deckName.text = "\(data[indexPath.row % data.count].name)"
        if selectedDecksIds.contains(data[indexPath.row % data.count].id) {
            cell.backgroundColor = ColorScheme.accent
        }
        else {
            cell.backgroundColor = ColorScheme.darkBackground
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
        }
        else {
            selectedDecksIds.append(data[indexPath.row % data.count].id)
        }
        if selectedDecksIds.isEmpty {
            addingButton.layer.opacity = 0.5
        }
        else {
            addingButton.layer.opacity = 1
        }
        collectionView.reloadData()
    }
}
