//
//  APIService.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 11.08.2023.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    // Simulate a long waiting for fetching
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->() ) {
        DispatchQueue.global(qos: .utility).async {
            sleep(1)
            let path = Bundle.main.path(forResource: "content", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let photos = try! decoder.decode(Photos.self, from: data)
            complete( false, photos.photos, nil )
        }
        
        
    }
    
    func fetchPopularPhotos( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->() ) {
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            let path = Bundle.main.path(forResource: "content", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let photos = try! decoder.decode(Photos.self, from: data)
            complete( false, photos.photos, nil )
        }
        
        
    }
    
    func getPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->() ) {
        DispatchQueue.global(qos: .default).async {
            sleep(1)
            let path = Bundle.main.path(forResource: "content", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let photos = try! decoder.decode(Photos.self, from: data)
            
            DispatchQueue.main.async {
                complete( false, photos.photos, nil )
            }
            
        }
    
        
    }
    
    
    
}
