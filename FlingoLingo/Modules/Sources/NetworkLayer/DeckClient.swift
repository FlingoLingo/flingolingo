//
//  DeckClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public typealias Cards = [Card]

public struct DeckResponse: Decodable {
    public let id: Int
    public let isPrivate: Bool
    public let name: String
    public let cards: Cards
}

public struct DeckRequest: Encodable {
    var id: Int
    var isPrivate: Bool?
    var name: String?
}

public struct DeckNameRequest: Encodable {
    var name: String
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
    
    public func createDeckWithName(name: String, completion: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "POST",
                                  urlPattern: "/decks/",
                                  body: DeckNameRequest(name: name),
                                  completion: completion)
    }

    public func editDeck(id: Int,
                         name: String?,
                         isPrivate: Bool?,
                         completion: @escaping (Result<DeckResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "PATCH",
                                  urlPattern: "/decks/\(id)/",
                                  body: DeckRequest(id: id,
                                                    isPrivate: isPrivate,
                                                    name: name),
                                  completion: completion)
    }
    public func deleteDeck(id: Int, completion: @escaping (Result<MessageResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "DELETE",
                                  urlPattern: "/decks/\(id)/",
                                  body: EmptyRequest(),
                                  completion: completion)
    }
}
