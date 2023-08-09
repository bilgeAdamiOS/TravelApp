//
//  TargetClosureVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 9.08.2023.
//

import UIKit

import TinyConstraints


class TargetClosureVC: UIViewController {
    
    typealias TargetClosure = (String)->Void
    
    var targetClosure:TargetClosure?
    
    lazy var btnChat: UIButton = {
        let button = UIButton()
        button.setTitle("Deneme", for: .normal)
       
        button.addTarget(self, action: #selector(btnChatPressed), for: .touchUpInside)
        return button
    }()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
        
        
        self.view.addSubview(btnChat)
        
        btnChat.edgesToSuperview(excluding: .bottom,insets:.top(50),usingSafeArea: true)
        btnChat.height(50)
        
        test(name:"Melih")  { name in
            print(name)
        }
        
        test(name: "String", closure: { item in
            
            print(item)
        })
    }
    
    
    func test(name:String,closure:TargetClosure) {
        let obj = name + "Melih"
        
        closure(obj)
        
    }
    
    @objc func btnChatPressed(){
        guard let closure = targetClosure else { return }
        closure("Merhaba Televole")
    }
    



}
