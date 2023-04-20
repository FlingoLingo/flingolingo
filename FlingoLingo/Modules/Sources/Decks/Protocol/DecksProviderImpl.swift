//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 19.04.2023.
//

import Foundation
import NetworkLayer

public class DecksProviderImpl: DecksProvider {

    private var token: String {
      "00fa7675354ab19839cdd317efa545429764b77e"
    }

    public init() {

    }

    public func getAllDecks(onFinish: @escaping (Result<[DomainDeck], DecksError>) -> Void) {
        let client = DeckClient(token: token)
        client.getDecks(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let decks):
                    onFinish(.success(decks.map({ deck in
                        let decodedDeck = DomainDeck(deckResponse: deck)
                        return decodedDeck
                    })))
                case .failure(let failure):
                    onFinish(.failure(.client(failure)))
                }
            }
        })
    }

    public func getDeck(id: Int, onFinish: @escaping (Result<DomainDeck, DecksError>) -> Void) {
        let client = DeckClient(token: token)
        client.getDeck(id: id, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let deck):
                    onFinish(.success(DomainDeck(deckResponse: deck)))
                case .failure(let failure):
                    onFinish(.failure(.client(failure)))
                }
            }
        })
    }

    public func createNewDeck(name: String, onFinish: @escaping (Result<DomainDeck, DecksError>) -> Void) {
        let client = DeckClient(token: token)
        client.createDeckWithName(name: name, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let deck):
                    onFinish(.success(DomainDeck(deckResponse: deck)))
                case .failure(let failure):
                    onFinish(.failure(.client(failure)))
                }
            }
        })
    }

    public func deleteDeck(id: Int, onFinish: @escaping (Bool) -> Void) {
        let client = DeckClient(token: token)
        client.deleteDeck(id: id, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    onFinish(true)
                case .failure:
                    onFinish(false)
                }
            }
        })
    }

    public func deleteCardFromDeck(deckId: Int, carId: Int, onFinish: @escaping (Bool) -> Void) {
        let client = CardClient(token: token)
        client.removeCard(deckId: deckId, cardId: carId, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    onFinish(true)
                case .failure:
                    onFinish(false)
                }
            }
        })
    }

    public func insertCardToDeck(
        request: InsertCardRequest,
        onFinish: @escaping (Bool) -> Void
    ) {
        let client = CardClient(token: token)
        let card = AddCardRequest(eng: request.eng,
                                  rus: request.rus,
                                  transcription: request.transcription,
                                  examples: request.examples)
        client.addCard(card: card, decks: request.decks) { result in
            switch result {
            case .success:
                onFinish(true)
            case .failure:
                onFinish(false)
            }
        }
    }

    public func editDeck(id: Int, newName: String, onFinish: @escaping (Result<DomainDeck, DecksError>) -> Void) {
        let client = DeckClient(token: token)
        client.editDeck(id: id, name: newName, isPrivate: true, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let deck):
                    onFinish(.success(DomainDeck(deckResponse: deck)))
                case .failure(let failure):
                    onFinish(.failure(.client(failure)))
                }
            }
        })
    }

    public func setStatistics(deckId: Int, cardIdWithDirection: [Int: CardSwipeDirection]) {
        var cardsIdsToAdd: Set<String> = []
        var cardsIdsToRemove: Set<String> = []

        for (cardId, direction) in cardIdWithDirection {
            switch direction {
            case .left:
                cardsIdsToRemove.insert("\(cardId)")
            case .right:
                cardsIdsToAdd.insert("\(cardId)")
            }
        }

        let cardsIdsFromUserDefaults = UserDefaults.standard.stringArray(forKey: "\(deckId)") ?? []
        for cardId in cardsIdsFromUserDefaults {
            cardsIdsToAdd.insert(cardId)
        }

        for cardId in cardsIdsToRemove {
            cardsIdsToAdd.remove(cardId)
        }
        let cardsIdsToAddArray = Array(cardsIdsToAdd)
        UserDefaults.standard.set(cardsIdsToAddArray, forKey: "\(deckId)")
    }
}
