//
//  APILoader.swift
//  GenericNetworkLayer
//
//

import Foundation
import UIKit

class APILoader<T: APIHandler> {
    
    let apiRequest: T
    let urlSession: URLSession
    
    init(apiRequest: T, urlsession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlsession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping(T.ResponseDataType? Error?) -> ()) {
     
        let urlRequest = apiRequest.makeRequest(from: requestData).urlRequest
//        urlSession.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
    }
}
