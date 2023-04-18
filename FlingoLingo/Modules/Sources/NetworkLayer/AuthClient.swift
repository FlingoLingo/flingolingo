//
//  AuthClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public struct SignUpResponse: Decodable {
    var id: Int
    var username: String
}

public struct LogInResponse: Decodable {
    var token: String
}

public enum AuthError: Error {
    case jsonSerializationError
    case jsonParseError
    case responseError
    case noDataError
}

public final class AuthClient {
    public init() {}

    public func registerUser(username: String, password: String, completion: @escaping (Result<SignUpResponse, AuthError>) -> Void) {
        let registerURL = URL(string: baseUrl + "/profile/register/")!
        var request = URLRequest(url: registerURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["username": username, "password": password])
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
            guard let resp = try? decoder.decode(SignUpResponse.self, from: data) else {
                completion(.failure(.jsonParseError))
                return
            }
            completion(.success(resp))
        }
        task.resume()
    }

    public func getToken(username: String, password: String, completion: @escaping (Result<LogInResponse, AuthError>) -> Void) {
        let registerURL = URL(string: baseUrl + "/token-auth/")!
        var request = URLRequest(url: registerURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["username": username, "password": password])
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
            guard let resp = try? JSONDecoder().decode(LogInResponse.self, from: data) else {
                completion(.failure(.jsonParseError))
                return
            }
            completion(.success(resp))
        }
        task.resume()
    }
}

// пример использования
//let client = AuthClient()
//client.registerUser(username: "bob", password: "roberts", completion: {res in print(res)})
//client.registerUser(username: "bobson1", password: "robertson1", completion: {res in print(res)})
//client.getToken(username: "bobson", password: "robertson", completion: {res in print(res)})
