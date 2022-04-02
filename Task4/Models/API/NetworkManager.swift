//
//  NetworkManager.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import Foundation

typealias CompletionClosure = ((ATMModel?, Error?) -> Void)

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

struct NetworkManager {

    func fetchData(completion: CompletionClosure?) {
        guard let request = createRequest(for: Constants.Strings.urlString) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }

    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.name
        request.setValue(HTTPHeaderValue.json.rawValue, forHTTPHeaderField: HTTPHeader.contentType.rawValue)
        return request
    }

    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)

        session.configuration.httpMaximumConnectionsPerHost = 1
        session.configuration.waitsForConnectivity = true
        session.configuration.timeoutIntervalForResource = 60

        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}

