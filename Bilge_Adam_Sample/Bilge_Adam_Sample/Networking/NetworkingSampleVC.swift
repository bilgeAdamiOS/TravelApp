//
//  NetworkingSampleVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 16.08.2023.
//

import UIKit

class NetworkingSampleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK: -- Tüm kullanıcıları getirir. 
    func getAllUsers(){
        
        let endpoint = Endpoint.user()
        
        NetworkingHelper.shared.objectRequest(from: endpoint.apiURL, method: .get, callback: { (result:Result<[User],Error>) in
            
            switch result {
            case .success(let users):
                print(users)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    
    //MARK: -- Belirtilen id'li kullanıcıyı getirir.
    func getUserWith(userId:String){
        
        let endpoint = Endpoint.user(id:userId)
        
        NetworkingHelper.shared.objectRequest(from: endpoint.apiURL, method: .get, callback: { (result:Result<User,Error>) in
            
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    //MARK: -- User endpoint'ine parametrede tanımlanmış bilgilerle yeni eleman ekler.
    func addNewUserWith(params:[String:Any]) {
        
        let endpoint = Endpoint.user()
        
        NetworkingHelper.shared.objectRequest(from: endpoint.apiURL, params: params, method: .post, callback: { (result:Result<User,Error>) in
            
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    //MARK: -- Belirtilen id'li kullanıcıyı siler.
    func deleteUserWith(userId:String) {
        
        let endpoint = Endpoint.user(id:userId)
        
        NetworkingHelper.shared.objectRequest(from: endpoint.apiURL, method: .delete, callback: { (result:Result<User,Error>) in
            
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }
    
    
    //MARK: -- Belirtilen id'li kullanının bilgilerini yeni parametrelerle değiştirir.
    func updateUserWith(userId:String, params:[String:Any]) {
        
        let endpoint = Endpoint.user(id: userId)
        
        NetworkingHelper.shared.objectRequest(from: endpoint.apiURL, params: params, method: .put, callback: { (result:Result<User,Error>) in
            
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        })
    }

}
