//
//  AuthClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//
//
//
////import SwiftyKeychainKit
//
//import Foundation
//
//class AuthClient {
//    struct Card: Decodable {
//        var id: Int
//        var front: String
//        var back: String
//    }
//
//    typealias Cards = [Card]
//
//    struct Deck: Decodable {
//        var id: Int
//        var isPrivate: Bool
//        var name: String
//        var description: String
//        var cards: Cards
//    }
//
//    enum DecksError: Error {
//        case jsonParseError
//        case responseError
//        case noDataError
//    }
//
//    typealias Decks = [Deck]
//    
//    public func getDecks(completion: @escaping (Result<[Deck], DecksError>) -> Void) {
//        let deckSearch = URL(string: baseUrl + "/decks/")!
//        var request = URLRequest(url: deckSearch)
//        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        // request.setValue(APP_FILE_NAME, forHTTPHeaderField: "User-Agent")
//        request.httpMethod = "GET"
//        let session: URLSession = {
//            let session = URLSession(configuration: .default)
//            session.configuration.timeoutIntervalForRequest = 30.0
//            return session
//        }()
//
//        let task = session.dataTask(with: request) { data, response, error in
//        guard error == nil else {
//            completion(.failure(.responseError))
//            return
//        }
//        guard let data = data else {
//            completion(.failure(.noDataError))
//            return
//            
//        }
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        guard let decks = try? JSONDecoder().decode(Decks.self, from: data) else {
//            completion(.failure(.jsonParseError))
//        return
//        }
//        completion(.success(decks))
//    }
//    task.resume()
//    }
//}
