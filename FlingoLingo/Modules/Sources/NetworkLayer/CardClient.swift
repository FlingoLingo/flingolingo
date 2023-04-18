//
//  CardClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public struct Card: Decodable {
    var id: Int
    var front: String
    var back: String
}

public struct AddCardRequest: Decodable {
    var card: Card
    var decks: [Int]
}
public enum CardsError: Error {
    case jsonParseError
    case responseError
    case noDataError
}

public final class CardClient {
    public init() {}

    public func addCard(front: String, back: String, decks: [Int], completion: @escaping (Result<Card, CardsError>) -> Void) {
        let url = URL(string: baseUrl + "/decks/card/")!
        var request = URLRequest(url: url)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["card": ["front": front, "back": back], "decks": decks] as [String : Any])
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
        guard let card = try? decoder.decode(Card.self, from: data) else {
            completion(.failure(.jsonParseError))
        return
        }
        completion(.success(card))
    }
    task.resume()
    }

    public func removeCard(deckId: Int, cardId: Int, completion: @escaping (Result<Card, CardsError>) -> Void) {
        let deckSearch = URL(string: baseUrl + "/decks/\(deckId)/cards\(cardId)/")!
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
        guard let deck = try? decoder.decode(Card.self, from: data) else {
            completion(.failure(.jsonParseError))
        return
        }
        completion(.success(deck))
    }
    task.resume()
    }
}

// пример использования
//let client = CardClient()
//client.addCard(front: "pinapple", back: "ананас", decks: [3], completion: {res in print(res)})
//client.remove
