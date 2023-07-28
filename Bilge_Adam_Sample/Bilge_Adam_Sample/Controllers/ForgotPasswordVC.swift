//
//  ViewController.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 26.07.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class ForgotPasswordVC: UIViewController {
    
    weak var delegate:DataTransferDelegate?
    
    private lazy var txtPassword:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Mesajınızı girin"
        tf.textColor = #colorLiteral(red: 0.2834452093, green: 0.2834451795, blue: 0.2834452093, alpha: 1)
        tf.font = UIFont(name: "AvenirNext-Regular", size: 24)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        let imageView = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        
        tf.layer.cornerRadius = 8
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var txtPasswordValid:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Mesajınızı girin"
        tf.textColor = #colorLiteral(red: 0.2834452093, green: 0.2834451795, blue: 0.2834452093, alpha: 1)
        tf.font = UIFont(name: "AvenirNext-Regular", size: 24)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        let imageView = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        
        tf.layer.cornerRadius = 8
        tf.delegate = self
        
        return tf
    }()
    
    
    private lazy var btnNext:UIButton = {
        let button = UIButton()
        button.setTitle("Mesajı Göster", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(btnNextTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "Hoş Geldiniz"
        
        setupViews()
        
        
        
    }
    
    @objc func btnNextTapped() {
        
        let password = txtPassword.text
        let validPassword = txtPasswordValid.text
        
        if password == validPassword {
            delegate?.backwardDataTransfer(value: password)
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    //MARK: - Add Subviews to Superview
    func setupViews(){
        
        self.view.addSubview(txtPassword)
        self.view.addSubview(txtPasswordValid)
        self.view.addSubview(btnNext)
        setupWithSnap()
    }
    
    
    //MARK: Setup layout all subviews with Core Library
    
    
    func setupWithSnap(){
        
        txtPassword.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(16)
            make.height.equalTo(44)
        })
        
        txtPasswordValid.snp.makeConstraints({ make in
            make.top.equalTo(txtPassword.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(16)
            make.height.equalTo(44)
        })
        
        btnNext.snp.makeConstraints({ make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalTo(txtPasswordValid.snp.leading)
            make.trailing.equalTo(txtPasswordValid.snp.trailing)
            make.height.equalTo(44)
        })
        
    }
    
    
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ForgotPasswordVC:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("kullanıcı textfield input işlemini başlattı.")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("kullanıcı textfield input işlemini durdurdu.")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        
        print(textField.text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
        
    }

}
