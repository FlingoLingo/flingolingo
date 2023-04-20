//
//  AuthClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//

import Foundation

public struct AuthRequest: Encodable {
    var username: String
    var password: String
}

public struct SignUpResponse: Decodable {
    public var id: Int
    public var username: String
}

public struct LogInResponse: Decodable {
    public var token: String
}

public final class AuthClient {
    let netLayer: NetworkLayer

    public init(token: String?) {
        self.netLayer = NetworkLayer(token: token)
    }

    public func registerUser(username: String,
                             password: String,
                             completion: @escaping (Result<SignUpResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "POST",
                                  urlPattern: "/profile/register/",
                                  body: AuthRequest(username: username,
                                                    password: password),
                                  completion: completion)
    }

    public func getToken(username: String,
                         password: String,
                         completion: @escaping (Result<LogInResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "POST",
                                  urlPattern: "/token-auth/",
                                  body: AuthRequest(username: username,
                                                    password: password),
                                  completion: completion)
    }
}
