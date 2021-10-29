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

typealias Parameters = [String : Any]


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

enum APIManager {
    
    case getAPI(path: String, data: Parameters) 
    case postAPI(path: String, data: Parameters)
    
    var method: HttpMethod{
        switch self {
            case .getAPI:
                return .get
            case .postAPI:
                return .post
        }
    }
    
    var path: String {
        switch self {
            case .getAPI(let path, _):
                return path
            case .postAPI(let path, _):
                return path
        }
    }
    
    static var baseURL: URL = URL(string: "https://jsonplaceholder.typicode.com/")!

    func addHeaders(request: inout URLRequest){
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: Self.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        var parameters = Parameters()
        switch self {
            case .getAPI(_, let queries):
                queries.forEach({parameters[$0] = $1})
                URLEncoding.queryString.encode(&request, with: parameters)
            case .postAPI(_, let queries): 
                queries.forEach({parameters[$0] = $1})
                if let jsonData = try? JSONSerialization.data(withJSONObject: parameters){
                    request.httpBody = jsonData
                }
            }
        self.addHeaders(request: &request)
        
        return request
    }
    
    
}




