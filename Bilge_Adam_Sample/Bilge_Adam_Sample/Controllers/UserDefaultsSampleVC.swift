//
//  UserDefaultsSampleVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 10.08.2023.
//

import UIKit

class UserDefaultsSampleVC: UIViewController {

    //MARK -- User Defaults'u çağır
    let userDefault = UserDefaults.standard
    
    var accessToken = "private_access_token"
    
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

        saveToUD(value: "asdasdşlfjaşksdfj")
        
        setupViews()
        
        readFromUD(type: "")
    }
    
    func saveToUD<T>(value:T) {
        
        userDefault.set(value, forKey: "deneme")
    }
    
    func readFromUD<T>(type:T) {
        
        guard let obj = userDefault.value(forKey: "deneme") as? T else { return }
        
        print(obj)
        
    }
    
    @objc func btnSaveTapped(){
        
        saveToUD(value: accessToken)
        //MARK: -- User Default'a veri yaz
//        userDefault.set(accessToken, forKey: "access-token")
//        userDefault.synchronize()
//
//        userDefault.set(true, forKey: "isDone")
    }
    
    @objc func btnReadTapped(){
        
        
        //MARK: -- UserDefault üzerindeki veriyi okur.
        
       
        if let value = userDefault.string(forKey: "access-tok") {
            print(value)
        }else {
            print("Herhangi bir veri bulunamadı.")
        }
        
        
        let boolValue = userDefault.bool(forKey: "isDon")
        print(boolValue)
        
    }
    
    @objc func btnUpdateTapped(){
        accessToken = txtValue.text!
        userDefault.set(accessToken, forKey: "access-token")
        userDefault.set(false, forKey: "isDone")
    }
    
    @objc func btnDeleteTapped(){
        
        userDefault.removeObject(forKey: "access-token")
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
