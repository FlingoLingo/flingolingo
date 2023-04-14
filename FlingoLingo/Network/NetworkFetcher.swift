//
//  NetworkFetcher.swift
//  FlingoLingo
//
//  Created by Yandex on 14.04.2023.
//

import Foundation

protocol INetworkFetcher {
    func getLangs(result: @escaping (Langs?) -> Void)
    func getWord(result: @escaping (Word?) -> Void, lungs: String, text: String)
}

final class NetworkFetcher: INetworkFetcher, ObservableObject {

    let network: INetworkRequest
    
    func getParamsString(params:[String : Any]) -> String {
            var data = [String]()
            for(key, value) in params {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
    }

    init(network: INetworkRequest) {
        self.network = network
    }

    func getLangs(result: @escaping (Langs?) -> Void) {
        network.request(path: Urls.langs.rawValue) { [weak self] data, response, error in
            if let error {
                print("error")
                print(error)
                result(nil)
            }
            if let response = (response as? HTTPURLResponse) {
                print(response.statusCode)
            }
            let langs = self?.decodeJSON(type: Langs.self, from: data)
            result(langs)
        }
    }
    
    func getWord(result: @escaping (Word?) -> Void, lungs: String, text: String) {
        let str =  Urls.lookup.rawValue + getParamsString(params: ["lang" : lungs, "text" : text])
        network.request(path: str) { [weak self] data, response, error in
            if let error {
                print(error)
                result(nil)
            }
            if let response = (response as? HTTPURLResponse) {
                print(response.statusCode)
            }
            let words = self?.decodeJSON(type: Word.self, from: data)
            result(words)
        }
    }
    
    // just декодер
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data, let response = try? decoder.decode(type, from: data) else { return nil }
        return response
    }
}

// all urls here
enum Urls: String {
            case langs = "https://dictionary.yandex.net/api/v1/dicservice.json/getLangs?key=dict.1.1.20230414T071057Z.cc74933e551e6749.af1a5aaf6c6d625a28b9ec00e98a759bd4cc06bc"
    
            // MARK: не готово!
            case lookup = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=dict.1.1.20230414T071057Z.cc74933e551e6749.af1a5aaf6c6d625a28b9ec00e98a759bd4cc06bc&"
}
