

import Foundation
import Combine


enum NetworkErrorr: Error {
      case serverError(statusCode: Int?)
      case noDataReceived
      case decodingError(DecodingError)
      case unknowError(Error)
  }

class  CombineNetworkService {
    
    let session: URLSession
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func get<T: Decodable>(url: URL) -> AnyPublisher<T,Error> {
        
        let request = URLRequest(url: url)
        
        return self.session
            .dataTaskPublisher(for: request)
            .tryMap{ data, response in
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                
                guard let code = statusCode , (200..<300) ~= code  else {
                    throw NetworkErrorr.serverError(statusCode: statusCode)
                }
                    
                return data
                
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
