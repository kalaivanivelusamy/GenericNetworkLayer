//
//  ServiceConstants.swift
//  GenericNetworkLayer
//
//

import Foundation

enum Environment {
    case development
    case staging
    case production
    
    func baseURL() -> String {
        return "\(urlProtocol())://\(subDomain()).\(domain())\(route()))"
    }
    
    func urlProtocol() -> String {
        switch self {
            case .production:
               return "https"
            default:
                return "http"
        }
    }

    func subDomain() -> String {
        switch self {
            case .development:
                return "dev.subdomain"
            case .staging:
                return "test.subdomain"
            case .production:
                return "prod.subdomain"

        }
    }

    func domain() -> String {
        switch self {
            case .development, .staging, .production:
                return "domain.com"
        }
    }
    
    func route() -> String {
        return "/api/v1"
    }
    
}


extension Environment{
    func host() -> String {
        return "\(self.subDomain()).\(self.domain())"
    }
}

#if DEBUG
let environment: Environment = Environment.development
#else
let environment: Environment = Environment.staging
#endif

let baseURL = environment.baseURL()


struct Path {
    
    var login: String {
        return "\(baseURL)/login"
    }
    
}

