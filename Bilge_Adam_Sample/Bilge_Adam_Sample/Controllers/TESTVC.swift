//
//  TESTVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 13.08.2023.
//

import UIKit
import Alamofire


protocol Fetchable {
    
    associatedtype T
    
    var prop:T? { get set }
    
    func getData(name:T)
    

}


class APIHelper<T>:Fetchable {
    
    var prop: T?
    
    func getData(name:T) {
        
    }
    
   
}


class Movie<T> {
    
    init(name:T){
        
        print(name)
    }

    
    func test(name:T){
        
    }
    
}







protocol Prot {
    associatedtype T
    var test:T? { get }
    func customFunc(item:T)->T
}



class Helper<T>:Prot {
    typealias Item = T
    var test: T?
    func customFunc(item: T) -> T {
        
        print(item)
        return item
    }
}

class TESTVC: UIViewController {
    
    let apiUrl = "https://64d8d7f85f9bf5b879ce9cec.mockapi.io/api/v1/Film"
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        let helper = APIHelper<String>()
        let movie = Movie(name: "Deneme")
        movie.test(name: "asdasdsad")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        let helper = APIHelper<Int>()
        print(helper)
        helper.prop = 5
        let result = helper.prop! * helper.prop!
        print(result)
        
        let params = ["filmName":"Deneme","rating":"5.0"]
        fetchData(from: apiUrl,parameters: params, completion: { (result:Result<Film,Error>) in
            
            switch result {
            case .success(let value):
                print(value)
                
            case.failure(let err):
                print(err)
            }
        })
        
        
        
//        fetchData(from: apiUrl) { (result: Result<[User], Error>) in
//            switch result {
//            case .success(let users):
//                for user in users {
//                    print("User Name: \(user.ad), Email: \(user.eposta), ID: \(user.id)")
//                }
//
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
        
    }
    
   
    func fetchData<T: Codable>(from apiUrl: String,parameters:Parameters, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(apiUrl,method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
  
}


struct User:Codable {
    var ad: String
    var eposta: [Email]
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case ad = "name"
        case eposta = "email"
        case id = "id"
    }
}


struct Email:Codable {
    var id:String
    var UserId:String
    var email:String
}

struct Film:Codable {
    
    var filmName:String
    var filmId:String
    var rating:String
}
