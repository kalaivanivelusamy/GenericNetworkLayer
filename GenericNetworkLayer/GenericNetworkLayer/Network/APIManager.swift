//
//  APIManager.swift
//  GenericNetworkLayer
//
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case apiError
    case decodingError
    case responseisInvalid
}

enum HttpMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum URLEncoding {
    case queryString
    case none
    
    func encode(_ request: inout URLRequest, with parameters: Parameters){
        switch self {
            case .queryString:
                guard let url = request.url else{ return }
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),!parameters.isEmpty {
                    urlComponents.queryItems = [URLQueryItem]()
                    for (k,val) in parameters {
                        let item = URLQueryItem(name: k, value: "\(val)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                        urlComponents.queryItems?.append(item)
                    }
                    request.url = urlComponents.url
                }
            case .none:
                break
        }
    }
}

typealias Parameters = [String : Any]



