//
//  KeychainSampleVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 10.08.2023.
//

import UIKit

class KeychainSampleVC: UIViewController {

    var accessToken = "access_token_keychain"
    
    private lazy var stackView:UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var txtValue:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Yeni değer girin"
        tf.textColor = .black
        return tf
    }()
    
    private lazy var btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("Kaydet", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var btnRead: UIButton = {
        let button = UIButton()
        button.setTitle("Oku", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(btnReadTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var btnUpdate: UIButton = {
        let button = UIButton()
        button.setTitle("Güncelle", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(btnUpdateTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var btnDelete: UIButton = {
        let button = UIButton()
        button.setTitle("Sil", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(btnDeleteTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let data = KeychainHelper.shared.getAllKeyChainItemsOfClass(kSecClassGenericPassword as String)
        print(data)
    }
    

    @objc func btnSaveTapped(){
        
        let data = Data(accessToken.utf8)
        KeychainHelper.shared.save(data, service: "refresh-token", account: "google")
        
        
    }
    
    @objc func btnReadTapped(){
        
        guard let data = KeychainHelper.shared.read(service: "access-token", account: "google") else {  return print("Böyle bir veri yok") }
        
        if let token = String(data: data, encoding: .utf8) {
            print(token)
        }
        
        
        
    }
    
    @objc func btnUpdateTapped(){

        accessToken = txtValue.text!
        let data = Data(accessToken.utf8)
        KeychainHelper.shared.save(data, service: "access-token", account: "google")
    }
    
    @objc func btnDeleteTapped(){
        
        KeychainHelper.shared.delete("access-token", account: "google")
    }
    
    
    private func setupViews(){
        
        self.view.backgroundColor = .white
        self.view.addSubviews(stackView)
        
        stackView.addArrangedSubviews(txtValue,btnSave,btnRead,btnUpdate,btnDelete)
        
        setupLayout()
    }
    
    
    private func setupLayout(){
        
        txtValue.height(50)
        btnRead.height(to: txtValue)
        btnSave.height(to: txtValue)
        btnUpdate.height(to: txtValue)
        btnDelete.height(to: txtValue)
        
        stackView.leadingToSuperview(offset:24)
        stackView.trailingToSuperview(offset:24)
        stackView.topToSuperview(offset:36,usingSafeArea: true)
    }

    

}
