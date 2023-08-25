//
//  TargetVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 16.08.2023.
//

import UIKit

protocol DataTransferProtocol {
    func sendData(data: String)
}


class TargetVC: UIViewController {

    var dataReceiver: DataTransferProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let data = "Merhaba, dünya!"
        dataReceiver?.sendData(data: data)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
