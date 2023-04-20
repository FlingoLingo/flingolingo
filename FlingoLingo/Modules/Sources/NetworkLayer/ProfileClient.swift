//
//  ProfileClient.swift
//  
//
//  Created by Ринат Афиатуллов on 17.04.2023.
//
import Foundation

public struct GetProfileResponse: Decodable {
    public let id: Int
    public let username: String
    public let dateJoined: String
}

public struct ChangePasswordRequest: Encodable {
    public let oldPassword: String
    public let newPassword: String
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
