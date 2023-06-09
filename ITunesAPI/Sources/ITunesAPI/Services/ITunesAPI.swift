//
//  API.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public final class API {
    
    public static let shared: API = {
        let instance = API()
        return instance
    }()
    
    var baseURL = "https://itunes.apple.com/search?term="
    var searchDefaults = "&country=tr&media=music"
    
    private var service: NetworkService
    
    init(service: NetworkService = NetworkManager()) {
        self.service = service
    }
    
}

extension API {
       
    public func isConnectedToInternet() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
    
    func executeRequestFor<T:Decodable>(
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        if let urlRequest = prepareURlRequestFor( parameters: parameters, headers: headers, method: method) {
            service.execute(urlRequest: urlRequest, completion: completion)
        } else {
            completion(.failure(.invalidRequest))
        }
    }

    func prepareURlRequestFor(
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        method: RequestMethod = .get
    ) -> URLRequest? {
        
        let urlString = baseURL + (parameters?["text"] as? String ?? "") + searchDefaults
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)

        if let params = parameters {
            if method == .get || method == .delete {
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    return nil
                }
                let queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                guard let newURL = urlComponents.url else {
                    return nil
                }
                request = URLRequest(url: newURL)
            } else {
                let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
        }

        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let requestHeaders = headers {
            for (field, value) in requestHeaders {
                request.setValue(value, forHTTPHeaderField: field)
            }
        }
        return request
    }
    
}

