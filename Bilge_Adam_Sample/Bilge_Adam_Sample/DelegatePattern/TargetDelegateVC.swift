//
//  TargetDelegateVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 9.08.2023.
//

import UIKit

class TargetDelegateVC: UIViewController {

    
    weak var ismetPasha:MainFileTransferDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        ismetPasha?.getDataFromTargetVC(text: "Misak-i Milli Kabul edildi.")
    }
    
}
