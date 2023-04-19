//
//  File.swift
//  
//
//  Created by Алиса Вышегородцева on 19.04.2023.
//

import Foundation
import NetworkLayer

public class DecksProviderImpl: DecksProvider {

    public init() {

    }

    public func getAllDecks(onFinish: @escaping (Result<[DeckResponse], ClientError>) -> Void) {
        let client = DeckClient(token: "00fa7675354ab19839cdd317efa545429764b77e")
        client.getDecks(completion: { result in
            DispatchQueue.main.async {
                onFinish(result)
            }
        })
    }

    public func getDeck(id: Int, onFinish: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        let client = DeckClient(token: "00fa7675354ab19839cdd317efa545429764b77e")
        client.getDeck(id: id, completion: { result in
            DispatchQueue.main.async {
                onFinish(result)
            }
        })
    }

    public func createNewDeck(name: String, onFinish: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        let client = DeckClient(token: "00fa7675354ab19839cdd317efa545429764b77e")
        client.createDeckWithName(name: name, completion: { result in
            DispatchQueue.main.async {
                onFinish(result)
            }
        })
    }

    public func deleteDeck(id: Int, onFinish: @escaping (Result<MessageResponse, ClientError>) -> Void) {
        let client = DeckClient(token: "00fa7675354ab19839cdd317efa545429764b77e")
        client.deleteDeck(id: id, completion: { result in
            DispatchQueue.main.async {
                onFinish(result)
            }
        })
    }

    public func deleteCardFromDeck(deckId: Int, carId: Int, onFinish: @escaping (Result<MessageResponse, ClientError>) -> Void) {
        let client = CardClient(token: "00fa7675354ab19839cdd317efa545429764b77e")
        client.removeCard(deckId: deckId, cardId: carId, completion: { result in
            DispatchQueue.main.async {
                onFinish(result)
            }
        })
    }

    public func insertCardToDeck(onFinish: @escaping (Bool) -> Void) {

    }

    public func editDeck(id: Int, newName: String, onFinish: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        let client = DeckClient(token: "00fa7675354ab19839cdd317efa545429764b77e")
        client.editDeck(id: id, name: newName, isPrivate: true, completion: { result in
            DispatchQueue.main.async {
                onFinish(result)
            }
        })
    }
}
