//
//  MainDelegateVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 9.08.2023.
//

import UIKit

protocol MainFileTransferDelegate:AnyObject {
    
    func getDataFromTargetVC(text:String)
}

//MARK -- Protocol Extension protocol içerisindeki methodların varsayılan işlemini yapmak için kullanılır. Aynı zamanda opsiyonel olmasını da sağlar.
//extension MainFileTransferDelegate {
//
//    func getDataFromTargetVC(){ }
//}

class MainDelegateVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let vc = TargetDelegateVC()
        vc.ismetPasha = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension MainDelegateVC:MainFileTransferDelegate {
    
    func getDataFromTargetVC(text:String) {
        
    }
}
