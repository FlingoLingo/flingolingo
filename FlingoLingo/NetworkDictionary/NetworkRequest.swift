//
//  NetworkManager.swift
//  BeRich
//
//  Created by Nikita Stepanov on 05.02.2023.
//
import Foundation

protocol INetworkRequest {
    func request(path: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class NetworkRequest: INetworkRequest {
    func request(path: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: path) else { return }
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
}
