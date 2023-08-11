//
//  MvvmVM.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 11.08.2023.
//

import Foundation

class MvvmVM {

    let apiService: APIServiceProtocol
    
    var photoArray = [Photo]()

    init(apiService:APIServiceProtocol = APIService()){
        self.apiService = apiService
    }
    
    
    var photoArrayClosure:(()->())?
    
    func getDataFromRemote(){
        
        apiService.fetchPopularPhoto { [weak self] (success,photos,err) in
            guard let this = self else { return }
            if let _ = err {
                print("Alert göster")
            }else {
                this.photoArray = photos
                this.photoArrayClosure!()
            }
        }
        
        print(photoArray)
        
    }
    
    //MARK: -- callback closure, fonksiyonun bitiminden sonra çalışır ve parametre olarak [Photo] alır.
    func getDataFromRemote(with callback:@escaping (([Photo])->Void)){
        
        apiService.fetchPopularPhoto { [weak self] (success,photos,err) in
            guard let this = self else { return }
            if let _ = err {
                print("Alert göster")
            }else {
                this.photoArray = photos
                this.photoArrayClosure!()
                print("Allah-ü ekber vuhuuuuu: \(photos)")
            }
        }
        
        print("işlem biter yine sana hüsran: \(photoArray)")
        
    }
}
