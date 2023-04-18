//
//  NetworkFetcher.swift
//  FlingoLingo
//
//  Created by Yandex on 14.04.2023.
//

import Foundation

final class NetworkFetcher: ObservableObject {

    let network: NetworkRequest

    private func getParamsString(params: [String: Any])
    -> String {
            var data = [String]()
            for(key, value) in params {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
    }

    init(network: NetworkRequest) {
        self.network = network
    }

    func getWord(
        lungs: String,
        text: String,
        completion: @escaping (Word?) -> Void
    ) {
        let str =  Urls.lookup.rawValue + getParamsString(params: ["lang": lungs, "text": text])
        network.request(path: str) { [weak self] data, _, error in
            guard let self = self else {
                return
            }
            if let error {
                print(error)
                completion(nil)
            }
            let words = self.decodeJSON(type: Word.self, from: data)
            completion(words)
        }
    }

    // just декодер
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data else {
            return nil
        }
        do {
            return try decoder.decode(type, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

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


// all urls here
private enum Urls: String {
            case langs = "https://dictionary.yandex.net/api/v1/dicservice.json/getLangs?key=dict.1.1.20230414T071057Z.cc74933e551e6749.af1a5aaf6c6d625a28b9ec00e98a759bd4cc06bc"

            // MARK: не готово!
            case lookup = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=dict.1.1.20230414T071057Z.cc74933e551e6749.af1a5aaf6c6d625a28b9ec00e98a759bd4cc06bc&"
}
