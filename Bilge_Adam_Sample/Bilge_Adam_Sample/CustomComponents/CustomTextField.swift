//
//  CustomTextField.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 28.07.2023.
//

import UIKit


enum Font {
    case avenir(fontType:String,size:CGFloat)
    case poppins(fontType:String,size:CGFloat)
    case arial(fontType:String,size:CGFloat)
    
    var font:UIFont {
        
        switch self {
        case .avenir(let type, let size):
            return UIFont(name: "Avenir-\(type)", size: size)!
        case .poppins(let type, let size):
            return UIFont(name: "Poppins-\(type)", size: size)!
        case .arial(let type, let size):
            return UIFont(name: "Arial-Black", size: size)!
        }
    }
}

enum SideViewStatus {
    
    case left(image:UIImage)
    case right(image:UIImage)
    case none
    
    var definedSideView:UIView? {
        switch self {
        case .left(let image):
            return setSideView(icon: image)
        case .right(let image):
             return setSideView(icon: image)
        case .none:
            return nil
        
        }
    }
    
    func setSideView(icon:UIImage? = nil)->UIView{
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        imageView.tintColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)
        imageView.image = icon
        imageView.contentMode = .scaleAspectFit
    
        
        let sideView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.center = sideView.center
        sideView.addSubview(imageView)
        
        
        return sideView
        
    }
}

class CustomTextField: UITextField {

    var insets:UIEdgeInsets
    
    var sideView:SideViewStatus? = nil {
        didSet{
            defineSideViewLocation()
        }
    }
    
    var fontType:Font = .poppins(fontType: "SemiBold", size: 12) {
        
        didSet{
            self.font = fontType.font
        }
    }


    init( insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 12)){
    
        self.insets = insets
        super.init(frame: .zero)
        
        self.font = fontType.font
        let attributedString = NSAttributedString(string: "Kullanıcı adınızı giriniz", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)])

        self.attributedPlaceholder = attributedString
        self.textColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = 6
        self.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9921568627, blue: 0.9490196078, alpha: 1)
        
        self.autocorrectionType = .no
        
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
