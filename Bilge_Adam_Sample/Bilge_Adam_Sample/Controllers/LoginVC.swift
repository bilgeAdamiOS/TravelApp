//
//  ViewController.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 26.07.2023.
//

import UIKit
import SnapKit
import TinyConstraints

protocol DataTransferDelegate:AnyObject {
    func backwardDataTransfer(value:String?)
}


class LoginVC: UIViewController {
    
    var username:String = "asd"
    var password:String = "123"
    
    let dispatchGroup = DispatchGroup()
    
    private lazy var imgHeader: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    
    private lazy var lblWelcome: UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)
        l.text = "Welcome back"
        l.textAlignment = .center
        l.font = UIFont(name: "Poppins-SemiBold", size: 32)
        return l
    }()
    
    private lazy var lblSubtitle: UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 0.754785803)
        l.text = "Login to your account"
        l.textAlignment = .center
        l.font = UIFont(name: "Poppins-Medium", size: 18)
        return l
    }()
    
    
    lazy var txtUserName: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Adınızı Girin"
        tf.sideView = .right(image: UIImage(systemName: "person.fill")!)
        tf.fontType = .avenir(fontType: "Book", size: 12)
        
        
        tf.delegate = self
        return tf
    }()
   
    
    
    private lazy var txtPassword:CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Şifre giriniz"
        tf.sideView = .right(image: UIImage(systemName: "lock.fill")!)
        tf.delegate = self
        return tf
    }()
    
    private lazy var btnNext:UIButton = {
        let button = UIButton()
        button.setTitle("Giriş Yap", for: .normal)
        button.setImage(#imageLiteral(resourceName: "location2"), for: .normal)
        //button.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)
        button.addTarget(self, action: #selector(btnNextTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var stackView:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillProportionally
        sv.spacing = 6
        sv.axis = .horizontal
        sv.alignment = .center
        return sv
        
    }()
    
    private lazy var lblSignUpTitle: UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 0.754785803)
        l.text = "Şifrenizi mi unuttunuz?"
        l.textAlignment = .right
        l.font = UIFont(name: "Poppins-Medium", size: 12)
        return l
    }()
    
    private lazy var btnSignUp:UIButton = {
        let button = UIButton()
        let attrString = NSAttributedString(string: "Hemen Değiştirin", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)])
        
        button.setAttributedTitle(attrString, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(btnSignUpTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        imgHeader.setImage(from: "https://wallpapercave.com/wp/wp5823275.jpg")
        setupViews()
//        btnNext.centerTextAndImage(imageAboveText: true, spacing: 8)
        
       
        
        dispatchGroup.enter()
    
        print("İşlem başladı.count:background")
        APIService().fetchPopularPhotos(complete: { success,object,error in
            print("İşlem bitt.count:background")
            self.dispatchGroup.leave()
            print("İşlemden çıkıldı:background")
        })
        
       
        
        dispatchGroup.enter()
        print("İşlem başladı.count:utility")
        APIService().fetchPopularPhoto(complete: { success,object,error in
            print("İşlem bitt.count:utility")
            
             
            self.dispatchGroup.leave()
            print("İşlemden çıkıldı:utility")
            
        })

        
        
        print("Tüm işlemlerin bitmesi bekleniyor")
        dispatchGroup.notify(queue: .main) {
            APIService().getPhoto(complete: { success,object,error in
                
                self.lblWelcome.text = object.first?.name
                
            })
        }
        
      
         
    }
    
 
    override func viewDidAppear(_ animated: Bool) {
        btnNext.roundCorners(corners: [.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        btnNext.layer.shadowColor = UIColor.black.cgColor
//        btnNext.layer.shadowRadius = 10
//        btnNext.layer.shadowOffset = CGSize(width: 0, height: 1)
//        btnNext.layer.shadowOpacity = 1
        
        
        
    }
    
    @objc func btnNextTapped() {
       let vc = CollectionViewSampleVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnSignUpTapped(){
        
        let vc = ForgotPasswordVC()
        vc.closure = { name, indis, boy in
            print(name)
            print(indis)
            print(boy)
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let vc = ForgotPasswordVC()
//        vc.closure = { pass in
//            print(pass)
//        }
        //vc.delegate = self
        
    }
    
    //MARK: - Add Subviews to Superview
    func setupViews(){
        
        self.view.backgroundColor = .white
        
        stackView.addArrangedSubview(lblSignUpTitle)
        stackView.addArrangedSubview(btnSignUp)
        
        self.view.addSubviews(imgHeader,
                              lblWelcome,
                              lblSubtitle,
                              txtUserName,
                              txtPassword,
                              stackView,
                              btnNext)
        
        
        
        setupWithSnap()
    }
    
    
    //MARK: Setup layout all subviews with Core Library

    
    
    func setupWithSnap(){
        
       
        
        imgHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        })
        
        

        lblWelcome.topToBottom(of: imgHeader, offset: 40)
        lblWelcome.centerXToSuperview()
        
        
        lblSubtitle.snp.makeConstraints({ make in
            make.top.equalTo(lblWelcome.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        
        txtUserName.topToBottom(of: lblSubtitle,offset: 20)
        txtUserName.edgesToSuperview(excluding: [.top,.bottom],insets: .left(16) + .right(16))
        txtUserName.height(50)
        
        
        
        txtPassword.snp.makeConstraints({ make in
            make.top.equalTo(txtUserName.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        })
        
        
        
        btnNext.snp.makeConstraints({ make in
            make.bottom.equalTo(stackView.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(100)
        })
        
        btnSignUp.width(120)
        
        stackView.bottomToSuperview(offset: -16,usingSafeArea: true)
        stackView.centerXToSuperview()
        stackView.height(40)
        
        

        
    }
    
    
    func setupWithTiny(){
        
        
        
//        txtUserName
//        txtUserName.topToBottom(of: lblWelcome,offset: 20)
//        txtUserName.leading(to: lblWelcome)
//        txtUserName.trailing(to: lblWelcome)
//        txtUserName.height(44)
//        
//        btnNext.height(44)
//        btnNext.edgesToSuperview(excluding:[.top], insets: .left(16) + .right(16) + .bottom(30), usingSafeArea: true)
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension LoginVC:UITextFieldDelegate {
    
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
    

}


extension LoginVC:DataTransferDelegate {
    func backwardDataTransfer(value: String?) {
        guard let value = value else { return }
        self.password = value
    }
    
    
}
