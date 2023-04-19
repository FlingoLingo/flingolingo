//
//  CardClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public struct AddCardRequest: Encodable {
    var card: AddCard
    var decks: [Int]
}
public struct AddCard: Encodable {
    public var eng: String
    public var rus: String
    public var transcription: String
    public var examples: String
}

public struct CardResponse: Decodable {
    public var id: Int
    public var eng: String
    public var rus: String
    public var transcription: String
    public var examples: String
}

public final class CardClient {
    let netLayer: NetworkLayer

    public init(token: String) {
        self.netLayer = NetworkLayer(token: token)
    }

    public func addCard(card: AddCard,
                        decks: [Int],
                        completion: @escaping (Result<CardResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "POST",
                                  urlPattern: "/decks/card/",
                                  body: AddCardRequest(card: card, decks: decks), completion: completion)
    }

    public func removeCard(deckId: Int,
                           cardId: Int,
                           completion: @escaping (Result<MessageResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "DELETE",
                                  urlPattern: "/decks/\(deckId)/card/\(cardId)/",
                                  body: EmptyRequest(),
                                  completion: completion)
    }
}

// пример использования
// let client = CardClient(token: "83aeb32d84d74c8fc17529a456b86da7828eded1")
// client.addCard(card: AddCard(eng: "cucumber", rus: "огурец",
// transcription: "", examples: "Люблю огурцы"), decks: [10], completion: {res in print(res)})
// client.removeCard(deckId: 10, cardId: 7, completion: {res in print(res)})
