//
//  DeckClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public typealias Cards = [Card]

public struct Deck: Decodable {
    public init(id: Int, isPrivate: Bool, name: String, description: String, cards: Cards) {
        self.id = id
        self.isPrivate = isPrivate
        self.name = name
        self.description = description
        self.cards = cards
    }
    
    public var id: Int
    public var isPrivate: Bool
    public var name: String
    public var description: String
    public var cards: Cards
}

public enum DecksError: Error {
    case jsonParseError
    case responseError
    case noDataError
}

typealias Decks = [Deck]

public final class DeckClient {
    public init() {}

    public func getDecks(completion: @escaping (Result<[Deck], DecksError>) -> Void) {
        let deckSearch = URL(string: baseUrl + "/decks/")!
        var request = URLRequest(url: deckSearch)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let session: URLSession = {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 30.0
            return session
        }()

        let task = session.dataTask(with: request) { data, _, error in
        guard error == nil else {
            completion(.failure(.responseError))
            return
        }
        guard let data = data else {
            completion(.failure(.noDataError))
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decks = self.decodeJSON(type: Decks.self, from: data) else {
            completion(.failure(.jsonParseError))
            return
        }
            completion(.success(decks))
        }
        task.resume()
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data else {
            return nil
        }
        do {
            return try decoder.decode(type, from: data)
        } catch {
            print(error)
            return nil
        }
    }

    public func getDeck(id: Int, completion: @escaping (Result<Deck, DecksError>) -> Void) {
        let deckSearch = URL(string: baseUrl + "/decks/\(id)/")!
        var request = URLRequest(url: deckSearch)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let session: URLSession = {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 30.0
            return session
        }()

        let task = session.dataTask(with: request) { data, _, error in
        guard error == nil else {
            completion(.failure(.responseError))
            return
        }
        guard let data = data else {
            completion(.failure(.noDataError))
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let deck = try? decoder.decode(Deck.self, from: data) else {
            completion(.failure(.jsonParseError))
        return
        }
        completion(.success(deck))
    }
    task.resume()
    }

    public func createDeck(completion: @escaping (Result<Deck, DecksError>) -> Void) {
        let deckSearch = URL(string: baseUrl + "/decks/")!
        var request = URLRequest(url: deckSearch)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let session: URLSession = {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 30.0
            return session
        }()

        let task = session.dataTask(with: request) { data, _, error in
        guard error == nil else {
            completion(.failure(.responseError))
            return
        }
        guard let data = data else {
            completion(.failure(.noDataError))
            return

        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decks = try? decoder.decode(Deck.self, from: data) else {
            completion(.failure(.jsonParseError))
        return
        }
        completion(.success(decks))
    }
    task.resume()
    }

    public func editDeck(id: Int, name: String, description: String, isPrivate: Bool, completion: @escaping (Result<Deck, DecksError>) -> Void) {
        let deckSearch = URL(string: baseUrl + "/decks/\(id)/")!
        var request = URLRequest(url: deckSearch)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["name": name, "description": description, "is_private": isPrivate] as [String : Any])
        let session: URLSession = {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 30.0
            return session
        }()

        let task = session.dataTask(with: request) { data, _, error in
        guard error == nil else {
            completion(.failure(.responseError))
            return
        }
        guard let data = data else {
            completion(.failure(.noDataError))
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let deck = try? decoder.decode(Deck.self, from: data) else {
            completion(.failure(.jsonParseError))
        return
        }
        completion(.success(deck))
    }
    task.resume()
    }
    public func deleteDeck(id: Int, completion: @escaping (Result<Deck, DecksError>) -> Void) {
        let deckSearch = URL(string: baseUrl + "/decks/\(id)/")!
        var request = URLRequest(url: deckSearch)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        let session: URLSession = {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 30.0
            return session
        }()

        let task = session.dataTask(with: request) { data, _, error in
        guard error == nil else {
            completion(.failure(.responseError))
            return
        }
        guard let data = data else {
            completion(.failure(.noDataError))
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let deck = try? decoder.decode(Deck.self, from: data) else {
            completion(.failure(.jsonParseError))
        return
        }
        completion(.success(deck))
    }
    task.resume()
    }
}
