//
//  CardClient.swift
//
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public struct AddCardToDecksRequest: Encodable {
    let card: AddCardRequest
    let decks: [Int]
}
public struct AddCardRequest: Encodable {
    public var eng: String
    public var rus: String
    public var transcription: String
    public var examples: String
    public init(eng: String, rus: String, transcription: String, examples: String) {
        self.eng = eng
        self.rus = rus
        self.transcription = transcription
        self.examples = examples
    }
}

public struct CardResponse: Decodable {
    public var id: Int
    public var eng: String
    public var rus: String
    public var transcription: String
    public var examples: String
}

public final class CardClient {
    private let netLayer: NetworkLayer

    public init(token: String) {
        self.netLayer = NetworkLayer(token: token)
    }

    public func addCard(card: AddCardRequest,
                        decks: [Int],
                        completion: @escaping (Result<CardResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "POST",
                                  urlPattern: "/decks/card/",
                                  body: AddCardToDecksRequest(card: card, decks: decks), completion: completion)
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
