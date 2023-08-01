//
//  CurrencyVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 31.07.2023.
//

import UIKit
import TinyConstraints

class CurrencyVC: UIViewController {
    
    var currency:String = ""
    
    private lazy var stackView1:UIStackView = {
       let sv = UIStackView()
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.spacing = 0
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var lblTitle1:UILabel = {
        let label = UILabel()
        label.text = "TRY"
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var txtCurrency1:CurrencyTextField = {
        let tf = CurrencyTextField()
        tf.sideView = .left(image: UIImage(named: "turkey")!)
       
        tf.delegate = self
        return tf
        
    }()
    
    private lazy var stackView2:UIStackView = {
       let sv = UIStackView()
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.spacing = 8
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var lblTitle2:UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var txtCurrency2:CurrencyTextField = {
        let tf = CurrencyTextField()
        tf.sideView = .left(image: UIImage(named: "united-states")!)
        tf.delegate = self
       
        
        return tf
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    private func setupViews(){
        
        self.view.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
        
        self.view.addSubviews(stackView1,stackView2)
        
        stackView1.addArrangedSubview(lblTitle1)
        stackView1.addArrangedSubview(txtCurrency1)
        
        stackView2.addArrangedSubview(lblTitle2)
        stackView2.addArrangedSubview(txtCurrency2)
        
        setupLayout()
    }
    
    
    private func setupLayout(){
        
        txtCurrency1.height(80)
        txtCurrency1.horizontalToSuperview()
        
        stackView1.topToSuperview(offset:50,usingSafeArea: true)
        stackView1.horizontalToSuperview(insets:.left(16) + .right(16))
        
        txtCurrency2.height(80)
        txtCurrency2.horizontalToSuperview()
        
        stackView2.topToBottom(of: stackView1,offset:20)
        stackView2.horizontalToSuperview(insets:.left(16) + .right(16))
    }
    
}


extension CurrencyVC:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        
        if string.isEmpty && currency.count > 0 {
            currency.removeLast()
            
        }
        
        currency += string
        
        if let sum = Double(currency){
            
            
            let tryToUsd = round(sum / 27.9)
            let usdToTry = round(sum * 27.9)
            
            if textField == txtCurrency1 {
                txtCurrency2.text = String(tryToUsd)
            }else {
                txtCurrency1.text = String(usdToTry)
            }
            
        }else {
            if textField == txtCurrency1 {
                txtCurrency2.text = ""
            }else {
                txtCurrency1.text = ""
            }
            
        }
        
        return true
        
    }
    
    
}
