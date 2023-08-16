//
//  NetworkingHelper(Singelton).swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 15.08.2023.
//

import Foundation
import Alamofire


enum Endpoint {
    
    static let baseURL = "https://64d8d7f85f9bf5b879ce9cec.mockapi.io/api/v1"
    
    case user(id:String = "")
    case film
    
    var apiURL:String {
        switch self {
        case .user(let id):
            return Endpoint.baseURL + "/User" + "/\(id)"
        case .film:
            return Endpoint.baseURL + "/Film"
        }
    }
}

class NetworkingHelper {
    
    
    static let shared = NetworkingHelper()
    
    func objectRequest<T:Codable>(from apiUrl:String, params:Parameters = [:], method:HTTPMethod, callback: @escaping (Result<T,Error>) -> Void) {
        
        
        AF.request(apiUrl,
                   method:method,
                   parameters: params).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let err):
                callback(.failure(err))
            }
        }
        
        
    }
    
    
    func arrayRequest<T:Codable>(from apiUrl:String, params:Parameters, method:HTTPMethod, callback: @escaping (Result<[T],Error>) -> Void) {
        
        AF.request(apiUrl,
                   method:method,
                   parameters: params).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode([T].self, from: jsonData)
                    callback(.success(decodedData))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let err):
                callback(.failure(err))
            }
        }
        
        
    }
    
    
}
