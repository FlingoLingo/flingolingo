//
//  AuthClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

class AuthClient {
    struct AuthResponse: Decodable {
        var id: Int
        var username: String
    }

    enum AuthError: Error {
        case jsonSerializationError
        case jsonParseError
        case responseError
        case noDataError
    }
    
    public func registerUser(username: String, password: String, completion: @escaping (Result<AuthResponse, AuthError>) -> Void) {
        let registerURL = URL(string: baseUrl + "/profile/register/")!
        var request = URLRequest(url: registerURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue(APP_FILE_NAME, forHTTPHeaderField: "User-Agent")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["username": username, "password": password]) /* else {
            completion(.failure(.jsonSerializationError))
        }*/
        let session: URLSession = {
            let session = URLSession(configuration: .default)
            session.configuration.timeoutIntervalForRequest = 30.0
            return session
        }()

        let task = session.dataTask(with: request) { data, response, error in
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
        guard let decks = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
            completion(.failure(.jsonParseError))
        return
        }
        completion(.success(decks))
    }
    task.resume()
    }
}

// пример использования
//let client = AuthClient()
//client.registerUser(username: "bob", password: "roberts", completion: {res in print(res)})
