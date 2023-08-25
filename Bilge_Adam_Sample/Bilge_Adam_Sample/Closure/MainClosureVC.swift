//
//  MainClosureVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 9.08.2023.
//

import UIKit



class MainClosureVC: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.view.backgroundColor = .blue

        let vc = TargetClosureVC()
        
        vc.targetClosure = { text in
            print(text)
           
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    
}
