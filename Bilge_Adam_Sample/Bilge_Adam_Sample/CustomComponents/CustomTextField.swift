//
//  CustomTextField.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 28.07.2023.
//

import UIKit

class CustomTextField: UITextField {

    var insets:UIEdgeInsets
    
    var fontSize:CGFloat = 12 {
        didSet {
            
            self.font = UIFont(name: "AvenirNext-Regular", size: fontSize)
        }
    }

    init(insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 12)){
        self.insets = insets
        super.init(frame: .zero)
        
        let attributedString = NSAttributedString(string: "Kullanıcı adınızı giriniz", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)])

        self.attributedPlaceholder = attributedString
        self.textColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)
        self.font = UIFont(name: "Poppins-Regular", size: self.fontSize)
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = 6
        self.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9921568627, blue: 0.9490196078, alpha: 1)
        
        self.autocorrectionType = .no
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: insets)
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: insets)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: insets)
//    }
    
    
}
