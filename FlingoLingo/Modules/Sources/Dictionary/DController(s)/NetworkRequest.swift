//
//  NetworkRequest.swift
//  FlingoLingo
//
//  Created by Yandex on 14.04.2023.
//

import Foundation

final class NetworkRequest {
    func request(path: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string:
                                path.addingPercentEncoding(withAllowedCharacters:
                                                            NSCharacterSet.urlQueryAllowed)!) else {
            return
        }
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
