//
//  SenderVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 16.08.2023.
//

import UIKit

class SenderVC: UIViewController,DataTransferProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let vc = TargetVC()
        configure(sender: vc)
    }
    
    func sendData(data: String) {
            // Gelen veriyi kullan
    }
        
    func configure(sender: TargetVC) {
        sender.dataReceiver = self
    }

    

}
