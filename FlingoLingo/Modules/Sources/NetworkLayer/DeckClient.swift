//
//  DeckClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public typealias Cards = [Card]

public struct DeckResponse: Decodable {
    public var id: Int
    public var isPrivate: Bool
    public var name: String
    public var description: String
    public var cards: Cards
}

public struct DeckRequest: Encodable {
    var id: Int
    var isPrivate: Bool?
    var name: String?
    var description: String?
}

public enum DecksError: Error {
    case jsonEncodeError
    case jsonDecodeError
    case responseError
    case noDataError
}

typealias Decks = [DeckResponse]

public final class DeckClient {
    let netLayer: NetworkLayer

    public init(token: String) {
        self.netLayer = NetworkLayer(token: token)
    }

    public func getDecks(completion: @escaping (Result<[DeckResponse], ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "GET",
                                  urlPattern: "/decks/",
                                  body: EmptyRequest(),
                                  completion: completion)
    }

    public func getDeck(id: Int, completion: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "GET",
                                  urlPattern: "/decks/\(id)/",
                                  body: EmptyRequest(),
                                  completion: completion)
    }
    public func createDeck(completion: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "POST",
                                  urlPattern: "/decks/",
                                  body: EmptyRequest(),
                                  completion: completion)
    }

    public func editDeck(id: Int,
                         name: String?,
                         description: String?,
                         isPrivate: Bool?,
                         completion: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "PATCH",
                                  urlPattern: "/decks/\(id)/",
                                  body: DeckRequest(id: id,
                                                    isPrivate: isPrivate,
                                                    name: name,
                                                    description: description),
                                  completion: completion)
    }
    public func deleteDeck(id: Int, completion: @escaping (Result<MessageResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "DELETE",
                                  urlPattern: "/decks/\(id)/",
                                  body: EmptyRequest(),
                                  completion: completion)
    }
}

// let client = DeckClient(token: "83aeb32d84d74c8fc17529a456b86da7828eded1")
// client.getDecks(completion: {res in print(res)})
// client.getDeck(id: 3, completion: {res in print(res)})
// client.createDeck(completion: {res in print(res)})
// client.editDeck(id: 10, name: "aboba", description: "helo", isPrivate: nil, completion: {res in print(res)})
// client.deleteDeck(id: 5, completion: {res in print(res)})
