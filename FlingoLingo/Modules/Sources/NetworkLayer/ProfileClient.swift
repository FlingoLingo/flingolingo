//
//  ProfileClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

class ProfileClient {
    struct GetProfileResponse: Decodable {
        var id: Int
        var username: String
    }
    struct NoContentErrorResponse: Decodable {
        var detail: String
    }
    enum AuthError: Error {
        case jsonParseError
        case responseError
        case noDataError
    }
    
    public func getProfile(completion: @escaping (Result<GetProfileResponse, AuthError>) -> Void) {
        let registerURL = URL(string: baseUrl + "/profile/")!
        var request = URLRequest(url: registerURL)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue(APP_FILE_NAME, forHTTPHeaderField: "User-Agent")
        request.httpMethod = "GET"
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
            guard let resp = try? JSONDecoder().decode(GetProfileResponse.self, from: data) else {
                completion(.failure(.jsonParseError))
                return
            }
            completion(.success(resp))
        }
        task.resume()
    }
    
    
    public func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<NoContentErrorResponse, AuthError>) -> Void) {
        let registerURL = URL(string: baseUrl + "/profile/")!
        var request = URLRequest(url: registerURL)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue(APP_FILE_NAME, forHTTPHeaderField: "User-Agent")
        request.httpMethod = "PATCH"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["old_password": oldPassword, "new_password": newPassword]) /* else {
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
            guard let resp = try? JSONDecoder().decode(NoContentErrorResponse.self, from: data) else {
                completion(.success(NoContentErrorResponse(detail: "OK")))
                return
            }
            completion(.failure(.jsonParseError))
        }
        task.resume()
    }
    
    public func deleteAccount(completion: @escaping (Result<NoContentErrorResponse, AuthError>) -> Void) {
        let registerURL = URL(string: baseUrl + "/profile/")!
        var request = URLRequest(url: registerURL)
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue(APP_FILE_NAME, forHTTPHeaderField: "User-Agent")
        request.httpMethod = "DELETE"

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
            guard let resp = try? JSONDecoder().decode(NoContentErrorResponse.self, from: data) else {
                completion(.success(NoContentErrorResponse(detail: "OK")))
                return
            }
            completion(.failure(.jsonParseError))
        }
        task.resume()
    }
}

// пример использования
//let client = ProfileClient()
//client.getProfile(completion: {res in print(res)})

//client.deleteAccount(completion: {res in print(res)})
