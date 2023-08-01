//
//  CustomTextField.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 28.07.2023.
//

import UIKit


class CurrencyTextField: UITextField {

    var insets:UIEdgeInsets
    
    var sideView:SideViewStatus? = nil {
        didSet{
            defineSideViewLocation()
        }
    }
    
    var fontType:Font = .desc {
        
        didSet{
            self.font = fontType.font
        }
    }


    init(insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 12)){
        self.insets = insets
        super.init(frame: .zero)
        
        self.keyboardType = .numberPad
        self.font = fontType.font
//        let attributedString = NSAttributedString(string: "Kullanıcı adınızı giriniz", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)])
//
//        self.attributedPlaceholder = attributedString
        self.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 6
        self.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1)
        self.autocorrectionType = .no
        self.textAlignment = .right
    }
    
    
    func defineSideViewLocation(){
        
        switch sideView {
        case .left:
            self.leftView = sideView?.definedSideView
            self.leftViewMode = .always
        case .right:
            self.rightView = self.sideView?.definedSideView
            self.rightViewMode = .always
        case .none?:
            return
        default:
            return
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: insets)
//    }
//
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    
}
