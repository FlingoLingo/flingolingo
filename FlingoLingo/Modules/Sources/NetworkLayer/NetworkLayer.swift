//
//  NetworkLayer.swift
//  
//
//  Created by Ринат Афиатуллов on 18.04.2023.
//

import Foundation

public struct Card: Decodable {
    public var id: Int
    public var eng: String
    public var rus: String
    public var transcription: String
    public var examples: String
    public var isLearned: Bool
}

public enum ClientError: Error {
    case jsonEncodeError
    case jsonDecodeError
    case responseError
    case noDataError
}

public struct EmptyRequest: Encodable {
}

public struct MessageResponse: Decodable {
    public var message: String
}

public final class NetworkLayer {
    let token: String?
    let baseUrl = "https://flingolingo.pythonanywhere.com/api"
    public init(token: String?) {
        self.token = token
    }
    public func makeRequest<T: Decodable, Body: Encodable>(
        method: String,
        urlPattern: String,
        body: Body,
        completion: @escaping (Result<T, ClientError>) -> Void) {
        let url = URL(string: baseUrl + urlPattern)!
        var request = URLRequest(url: url)
        if let token = token {
            request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        if method != "GET" {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            guard let httpBody = try? encoder.encode(body) else {
                completion(.failure(.jsonEncodeError))
                return
            }
            request.httpBody = httpBody
        }
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
        guard let resp = try? decoder.decode(T.self, from: data) else {
            completion(.failure(.jsonDecodeError))
        return
        }
        completion(.success(resp))
    }
    task.resume()
    }
}
