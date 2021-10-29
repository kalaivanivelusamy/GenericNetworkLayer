//
//  LoginAPI.swift
//  GenericNetworkLayer
//
//

import Foundation

struct LoginAPI: APIHandler {    
    
    func makeRequest(from parameters: [String : Any]) -> Request {
        let url = URL(string: Path().login)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        set(parameters,urlRequest: &urlRequest)
        
        let request = BaseRequest(urlRequest: urlRequest)
        
        return request
        
    }
    
    func parseResponse(data: Data) throws -> LoginModel {
        return try defaultParseResponse(data: data)
    }
    
    
}


struct LoginModel: Response {

    var httpStatus: Int
    var message: String
    var authToken: String
} 


