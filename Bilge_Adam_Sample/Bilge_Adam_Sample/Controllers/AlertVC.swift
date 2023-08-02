//
//  VC1.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 1.08.2023.
//

import UIKit
import SnapKit

class AlertVC: UIViewController {
    
    
    private lazy var button:UIButton = {
        let b = UIButton()
        b.setTitle("Show Alert", for: .normal)
        b.backgroundColor = .black
        b.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func addAlert(){
        
        
        let alert = UIAlertController(title: "Hata", message: "Kullanıcı adı hatalı", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Kapat", style: .destructive)
        
    
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func showSheet(){
        
        
        let alert = UIAlertController(title: "HATA", message: "Kullanıcı adı veya şifreniz hatalı", preferredStyle: .alert)
        
        let retry = UIAlertAction(title: "Yeniden Dene", style: .default, handler: { action in
            
            self.present(ForgotPasswordVC(), animated: true)
            
        })
        

        alert.addAction(retry)
        
        self.present(alert, animated: true)
    }
    
    
    @objc func showAlert(){
        
        
        
        showSheet()
        
        
    }
    
   
    private func setupViews(){
        self.view.backgroundColor = .white
        self.view.addSubview(button)
        setupLayout()
    }
    
    private func setupLayout(){
        button.snp.makeConstraints( { button in
            button.bottom.equalToSuperview().offset(-100)
            button.leading.equalToSuperview().offset(16)
            button.trailing.equalToSuperview().offset(-16)
            button.height.equalTo(50)
        })
    }
    

}
