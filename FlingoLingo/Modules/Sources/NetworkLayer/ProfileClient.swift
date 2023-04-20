//
//  ProfileClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//
import Foundation

public struct GetProfileResponse: Decodable {
    public var id: Int
    public var username: String
    public var dateJoined: String
}

public struct ChangePasswordRequest: Encodable {
    var oldPassword: String
    var newPassword: String
}

public final class ProfileClient {
    let netLayer: NetworkLayer

    public init(token: String?) {
        self.netLayer = NetworkLayer(token: token)
    }

    public func getProfile(completion: @escaping (Result<GetProfileResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "GET", urlPattern: "/profile/", body: EmptyRequest(), completion: completion)
    }

    public func changePassword(oldPassword: String,
                               newPassword: String,
                               completion: @escaping (Result<MessageResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "PATCH",
                                  urlPattern: "/profile/",
                                  body: ChangePasswordRequest(oldPassword: oldPassword, newPassword: newPassword),
                                  completion: completion)
    }

    public func deleteAccount(completion: @escaping (Result<MessageResponse, ClientError>) -> Void) {
        self.netLayer.makeRequest(method: "DELETE",
                                  urlPattern: "/profile/",
                                  body: EmptyRequest(),
                                  completion: completion)
    }
}

// пример использования
// let client = ProfileClient(token: "1bba254cb6b2c179ee411259b30e6fd70b9cb8b2")
// client.getProfile(completion: {res in print(res)})
// client.changePassword(oldPassword: "robertson", newPassword: "roberts", completion: {res in print(res)})
// client.deleteAccount(completion: {res in print(res)})
