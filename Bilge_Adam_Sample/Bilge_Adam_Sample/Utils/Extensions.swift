//
//  Extensions.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 8.08.2023.
//


import UIKit

enum FormatType:String {
    case longFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case longWithoutZone = "yyyy-MM-dd'T'HH:mm:ss"
    case withoutYear = "dd MMMM"
    case localeStandard = "dd.MM.yyyy"
    case standard = "yyyy-MM-dd"
    case dateAndTime = "dd.MM.yyyy'T'HH:mm"
    case time = "HH:mm"
}

extension UIButton {
    func centerTextAndImage(imageAboveText: Bool = false, spacing: CGFloat) {
            if imageAboveText {
                // https://stackoverflow.com/questions/2451223/#7199529
                guard
                    let imageSize = imageView?.image?.size,
                    let text = titleLabel?.text,
                    let font = titleLabel?.font else { return }

                let titleSize = text.size(withAttributes: [.font: font])

                let titleOffset = -(imageSize.height + spacing)
                titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)

                let imageOffset = -(titleSize.height + spacing)
                imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)

                let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
                contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
            } else {
                let insetAmount = spacing / 2
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
                contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
            }
        }
}

extension UIStackView {
    func addArrangedSubviews(_ view: UIView...) {
        view.forEach({ v in
            self.addArrangedSubview(v)
        })
    }
}

extension UIView {
    
    /// Add multiple subview to a view.
    /// - Parameter view: It is a subviews array which add to parent view
    func addSubviews(_ view: UIView...) {
        view.forEach({ v in
            self.addSubview(v)
        })
        
        
    }
    
    
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
       
        mask.shadowColor = UIColor.black.cgColor
        mask.shadowPath = mask.path
        mask.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mask.shadowOpacity = 0.4
        mask.shadowRadius = 10
        mask.fillColor = UIColor.systemBlue.cgColor
        mask.path = path.cgPath
        layer.mask = mask
        layer.insertSublayer(mask, at: 0)

    }
    
    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }

    func addDashedBorder(color: UIColor) {
        let color = color.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width-2, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: (frameSize.width / 2), y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4, 4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    
   
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    
    var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

 
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.windows.compactMap({ $0.rootViewController }).first?.view
        //let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
}

extension UIColor {
    
    

     class func applyGradient(colors: [UIColor], bounds:CGRect) -> UIColor {
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)

    }
}

extension UITextField {
    var placeholder: String? {
          get {
              attributedPlaceholder?.string
          }

          set {
              guard let newValue = newValue else {
                  attributedPlaceholder = nil
                  return
              }
              let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blue]
            let attributedText = NSAttributedString(string: newValue, attributes: attributes)
            attributedPlaceholder = attributedText
            
          }
    }
}


extension String {
    
    func maskToPhoneNumber() -> String {
       let isMoreThanTenDigit = self.count > 10
       _ = self.startIndex
       var newstr = ""
           if isMoreThanTenDigit {
               newstr = "\(self.dropFirst(self.count - 10))"
           }
           else if self.count == 10{
               newstr = "\(self)"
           }
           else {
               return "number has only \(self.count) digits"
           }
        
           if  newstr.count == 10 {
               let internationalString = "\(newstr.dropLast(7)) \(newstr.dropLast(4).dropFirst(3)) \(newstr.dropFirst(6).dropLast(2)) \(newstr.dropFirst(8))"
               newstr = internationalString
           }
        
       return newstr
    }
    
    /// It formats a String Value to Date easily.
    /// - Parameter formatType: If method is called without parameters, it formats string with standard format style(dd.MM.yyyy). If you want to define another format you can it.
    /// .standard = dd.MM.yyyy -> 28.02.2020
    /// .longDate = yyyy-MM-dd'T'HH:mm:ss.SSSZ -> 2021-01-28 14:00:00.000
    /// .withoutYear = "dd MMMM" -> 27 April
    /// .dateAndTime = "dd.MM.yyyy'T'HH:mm" 27.01.2021 14:00
    /// - Returns: Method returns formatted date from String that define by user.
    func formatToDate(formatType: FormatType = .localeStandard)-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = formatType.rawValue
        let date = dateFormatter.date(from: self)

        return date

    }
   
}

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case tokenObject
        case currentUser
    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
    
    func setEncodedObject<T:Codable>(object:T,key:Keys) {
        
        if let encoded = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getEncodedObject<T:Codable>(key:Keys, object:T.Type) -> T?{
        if let data = UserDefaults.standard.data(forKey: key.rawValue), let dataObject = try? JSONDecoder().decode(object, from: data) {
          return dataObject
        }
        return nil
    }
}

extension UIDatePicker {
    
    public var roundedDate: Date {
        let referenceTimeInterval = self.date.timeIntervalSinceReferenceDate
        let remainingSeconds = referenceTimeInterval.truncatingRemainder(dividingBy: TimeInterval(minuteInterval*60))
        let timeRoundedToInterval = referenceTimeInterval - remainingSeconds
        return Date(timeIntervalSinceReferenceDate: timeRoundedToInterval)
    }
}

extension Date {
    
    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month], from: self)
        components.hour = 3
        return  calendar.date(from: components)!
    }
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    
    func formatToString(formatType:FormatType = .localeStandard)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatType.rawValue
        formatter.locale = Locale(identifier: "tr")
        return formatter.string(from: self)
    }
}

extension Optional {
    
    func ifNil(_ default:Wrapped) -> Wrapped {
        return self ?? `default`
    }
}


extension Array {
    
  public subscript(safe index: Int) -> Element? {
       guard startIndex <= index && index < endIndex else {
           return nil
       }
       
       return self[index]
   }
}


extension UIColor {
  
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") { cString.removeFirst() }
    
    if cString.count != 6 {
      self.init("ff0000")
      return
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}

extension UINavigationBarAppearance {
    
    func setCustomTitle() {
        
        
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),
                               NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 17)!]
    }
}

extension UINavigationBar {

    func setCustomTitle(title:String?) {
        guard let topItem = self.topItem else { return }
        
        topItem.title = title
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),
                               NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 17)!]
    }
}

extension UIApplication {

    class func topViewController(base: UIViewController? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController

            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
