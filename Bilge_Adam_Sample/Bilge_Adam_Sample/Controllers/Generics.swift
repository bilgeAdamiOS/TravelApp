//
//  TESTVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 13.08.2023.
//

import UIKit
import Alamofire



//MARK: -- Generic protocol. assosiatedType protocollere generic tipler tanımlamak için kullanılır.
protocol Fetchable {
    
    associatedtype T
    
    var prop:T? { get set }
    
    func getData(name:T)
    

}


//MARK: -- Generic Class with generic protocol
class APIHelper<T>:Fetchable {
    
    var prop: T?
    
    func getData(name:T) {
        
    }
    
   
}


//MARK: -- Generic Class
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

class GenericsVC: UIViewController {
   
    
    override func viewWillAppear(_ animated: Bool) {
        
        let helper = APIHelper<String>()
        let movie = Movie(name: "Deneme")
       

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        let helper = APIHelper<Int>()
        print(helper)
        helper.prop = 5
        
        let result = helper.prop! * helper.prop!
        print(result)
        
    }
    
    
    
   
    func fetchData<T: Codable>(from apiUrl: String,parameters:Parameters, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(apiUrl,method: .post, parameters: parameters).responseJSON { response in
            
        }
    }

    
  
}


struct User:Codable {
    var name: String
    var surname: String
    var email:String
    var phone:String
    var note:String
    var id: String
    
//    enum CodingKeys: String, CodingKey {
//        case userName = "name"
//        case userSurname = "surname"
//        case userEmail = "email"
//        case userPhone = "phone"
//        case userNote = "note"
//        case userId = "id"
//    }
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
