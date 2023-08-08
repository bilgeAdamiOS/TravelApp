//
//  CarLoginVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 3.08.2023.
//

import UIKit


class ContactVC: UIViewController {

    
    var chars = ["A","B","C","D"]
    
    var array = ["Ahmet","Ali","Arzu","Aydın","Bekir","Batu","Buse","Cem","Canan"]
    
    var arr = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterAndSort()
        
    }
    
    private func filterAndSort(){
        
        chars.enumerated().forEach({ index,char in
            
            let filtered = array.filter({ $0.hasPrefix(char) }).sorted(by: { $0<$1})
            
            if filtered.count > 0 {
                arr.append(filtered)
            }else {
                chars.remove(at: index)
            }
            
        })
        
        print(arr)
        print(chars)
        
    }
    
    private func addNew(name:String){
        
        array.append(name)
    }
    


}
