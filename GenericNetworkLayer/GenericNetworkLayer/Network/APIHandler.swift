//
//  APIHandler.swift
//  GenericNetworkLayer
//
//

import Foundation

protocol RequestHandler {
   
    associatedtype RequestDataType
    
    func makeRequest(from parameters: RequestDataType) -> Request
}


protocol ResponseHandler {
    
    associatedtype ResponseDataType
    
    func parseResponse(data: Data) throws -> ResponseDataType
}

typealias APIHandler = ResponseHandler & ResponseHandler



extension RequestHandler {
    
    func set(_ parameters: [String : Any], urlRequest: inout URLRequest) {
        if parameters.count != 0 {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options:[]) {
                urlRequest.httpBody = jsonData
            }
        }
    }
}

// MARK: - Request

protocol Request {
    var urlRequest: URLRequest { get }
}

class BaseRequest: Request {
   
    var urlRequest: URLRequest {
        
        self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.setValue("", forHTTPHeaderField: "DeviceId")
        self.request.setValue("", forHTTPHeaderField: "DeviceLanguage")
        
        return request
    }
    
    private var request: URLRequest
    
    init(urlRequest: URLRequest) {
        self.request = urlRequest
    }
}

// MARK: - Response

protocol Response: Codable {
    var httpStatus: Int { set get }
}

extension ResponseHandler {
    
    func defaultParseResponse<T: Response>(data: Data) throws -> T {
        
    }
    
}
