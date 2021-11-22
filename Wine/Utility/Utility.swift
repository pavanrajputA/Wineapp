//
//  Utility.swift
//
//  Copyright © 2021 Pavan. All rights reserved.
//

import Foundation
import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

// Live
//35.80.124.208
let mainDomainLink = "http://35.80.124.208:3000/list/"
let mainDomainLinkWithuser = "http://35.80.124.208:3000/user/"
let paymentUrl = "http://35.80.124.208:3000/customer/"
let imagePath = "http://35.80.124.208/wineapp/images/"
let uploaduserProfileimage = "http://35.80.124.208:3000/user/profile"
let userProfileimage = "http://35.80.124.208/wineapp/profile_images/"

// Staging
//54.201.206.5
//let mainDomainLink = "http://54.201.206.5:3000/list/"
//let mainDomainLinkWithuser = "http://54.201.206.5:3000/user/"
//let paymentUrl = "http://54.201.206.5:3000/customer/"
//let imagePath = "http://54.201.206.5/wineapp/images/"
//let uploaduserProfileimage = "http://54.201.206.5:3000/user/profile"
//let userProfileimage = "http://54.201.206.5/wineapp/profile_images/"

let loginApi = mainDomainLinkWithuser + "login"
let SignupApi = mainDomainLinkWithuser + "register"
let getuserInfo = mainDomainLinkWithuser + "getuser"



let listExperience = mainDomainLink + "list1"
let listSubCategories = mainDomainLink + "list2"
let listSubsubCategories = mainDomainLink + "list3"
let listSubsubCategories2forfoodPairing = mainDomainLink + "list3subcategory"

let listSubsubsubCategories = mainDomainLink + "list4"
let varietalDetails = mainDomainLink + "winedetails"
let characteristicsWine = mainDomainLink + "characteristics"
let winTypelist = mainDomainLink + "winetypes"
let shipingDetailsUpdate = mainDomainLinkWithuser + "shippingdetails"
let newshipingDetailsAdd = mainDomainLinkWithuser + "insertaddress"
let listofaddress = mainDomainLinkWithuser + "listofaddress"
let deleteaddress = mainDomainLinkWithuser + "deleteaddresS"

let addPaymentCard = paymentUrl + "addToCard"
let getPaymentCardlist = paymentUrl + "listAllCards"
let paymentByuser = paymentUrl + "transaction"
let deleteCard = paymentUrl + "deleteCard"
let productsCalculetion =  paymentUrl + "productsCalculetion"
let paymentStatusSend = paymentUrl + "paymentStatus"
let receipt = paymentUrl + "productInvoice"

let producthistory = paymentUrl + "producthistory"

struct CurrentDevice {
    
    // iDevice detection code
    static let IS_IPAD               = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE             = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA             = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH          = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT         = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH     = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH     = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_6_OR_HIGHER = IS_IPHONE && SCREEN_MAX_LENGTH  > 568
    static let IS_IPHONE_6           = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P          = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X           = IS_IPHONE && SCREEN_MAX_LENGTH == 812
    static let IS_IPHONE_X_OR_HIGHER = IS_IPHONE && SCREEN_MAX_LENGTH  > 812
    static let IS_IPHONE_X_OR_LOWER  = IS_IPHONE && SCREEN_MAX_LENGTH  < 812
    
    static let IS_IPHONE_4_OR_LESS   = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5_OR_LESS   = IS_IPHONE && SCREEN_MAX_LENGTH <= 568
    
    // MARK: - Singletons
    static var ScreenWidth: CGFloat {
        struct Singleton {
            static let width = UIScreen.main.bounds.size.width
        }
        return Singleton.width
    }
    
    static var ScreenHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.main.bounds.size.height
        }
        return Singleton.height
    }
}

let NAME_ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "



// MARK: - Validation
struct Valid {
    
    static let MAX_Length_Mobile: Int = 20
    static let MAX_Length_Name: Int = 50
    static let MAX_Length_PassportNumber: Int = 50
    static let MAX_Length_VerificationCode: Int = 6
    
//    static let MAX_Length_QWT: Int = 20
//    static let MAX_Length_UnitID: Int = 25
//    static let MAX_Length_Location: Int = 25
//    static let MAX_Length_PT_Number: Int = 20
//    static let MAX_Length_PO_Number: Int = 20
//    static let MAX_Length_LicenceNumber: Int = 50
    
    static let CHARACTERS_Mobile = "1234567890"
    static let CHARACTERS_Name = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
    
    static let CHARACTERS_VerificationCode = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 "
    static let CHARACTERS_PassportNumber = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
    
//    static let CHARACTERS_Qty = "1234567890"
//    static let CHARACTERS_Location = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
//    static let CHARACTERS_PT_Number = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
//    static let CHARACTERS_PO_Number = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
//    static let CHARACTERS_LOT = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
//    static let CHARACTERS_LicenceNumber = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*()"
}

func dd_MMM_yyyy_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "d MMM, yyyy"
    
    return dateFormatter
}

func MMM_yyyy_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "MMM, yyyy"
    
    return dateFormatter
}

extension Date {
    static func dates_(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

func EEEE_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "EEEE"
    
    return dateFormatter
}

func countryName(from countryCode: String) -> String {
    
    if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
        // Country name was found
        return name
    } else {
        // Country name cannot be found
        return countryCode
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func UTC_DF() -> DateFormatter {
    let dateFormatter = DateFormatter()
    if let time = NSTimeZone(name: "UTC") {
        dateFormatter.timeZone = time as TimeZone
    }
    dateFormatter.locale = NSLocale.system
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"

    return dateFormatter
}

func UTCBig_DF() -> DateFormatter {
    let dateFormatter = DateFormatter()
    if let time = NSTimeZone(name: "UTC") {
        dateFormatter.timeZone = time as TimeZone
    }
    dateFormatter.locale = NSLocale.system
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter
}

func LocalDF() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.system
    if let time = NSTimeZone(name: "GMT") {
        dateFormatter.timeZone = time as TimeZone
    }
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    return dateFormatter
}


func OnlyDF() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    return dateFormatter
}

func DateTime_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    return dateFormatter
}

func DateTime2_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    
    return dateFormatter
}

func setDateFormatter_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "dd MMMM yyyy"
    
    return dateFormatter
}

func setDateTimeFormatter_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
    
    return dateFormatter
}

func DatePicker_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "MMM d, yyyy"
    
    return dateFormatter
}

func Show_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    
    return dateFormatter
}

func API_DF() -> DateFormatter {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    return dateFormatter
}

public func secondsToHoursMinutesSecondsStr (seconds : Int) -> String {
    let (hours, minutes, _) = secondsToHoursMinutesSeconds(seconds: seconds);
    var str : String = hours > 0 ? "\(hours) h" : ""
      str = minutes > 0 ? str + " \(minutes) min" : str
//      str = seconds > 0 ? str + " \(seconds) sec" : str
      return str
  }

public func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
 }

class Toast {
    
    static func show(message: String, controller: UIViewController) {
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = #colorLiteral(red: 0.3534786999, green: 0.3337596655, blue: 0.3043811321, alpha: 1)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(10.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -95)
        controller.view.addConstraints([c1, c2, c3])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}

func minutesToHoursMinutes (minutes : Int) -> String {
    
    return ("\(minutes / 60)h " + "\(minutes % 60)m")
}

extension NSDictionary {
    func GotValue(key : String)-> NSString {
        
        if self[key] != nil {
            
            if((self["\(key)"] as? NSObject) != nil && (key .isEmpty) == false) {
                
                let obj_value = self["\(key)"] as? NSObject
                
                let str = NSString(format:"%@", obj_value!)
                
                if str == "<null>" || str == "undefined" {
                    
                    return ""
                }
                
                return str
            }
        }
        
        return ""
    }
}


func isValidEmail(_ email:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

extension String {
    
    func firstCharacterUpperCase() -> String? {
        guard !isEmpty else { return nil }
        
        let lowerCasedString = self.lowercased()
        return lowerCasedString.replacingCharacters(in: lowerCasedString.startIndex...lowerCasedString.startIndex, with: String(lowerCasedString[lowerCasedString.startIndex]).uppercased())
    }
}

extension Date {
    var dateAtMidnight: Date {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        let dateAtMidnight = calendar.startOfDay(for: Date())
        
        return dateAtMidnight
    }
    
    var dateAtEnd: Date {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        let dateAtMidnight = calendar.startOfDay(for: Date())
        
        //For End Date
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        let dateAtEnd = calendar.date(byAdding: components, to: dateAtMidnight)
        
        return dateAtEnd!
    }
}

/******************************************************/
//MARK:- EXTension
/******************************************************/

extension UIImageView {
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}



extension NSMutableAttributedString {
    
    var fontSize:CGFloat { return 18 }
    var boldFont:UIFont { return UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont.systemFont(ofSize: fontSize)}

    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  boldFont,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedString(_ string: String, in label: UILabel) -> Bool {
        
        guard let text = label.text else {
            
            return false
        }
        
        let range = (text as NSString).range(of: string)
        return self.didTapAttributedText(label: label, inRange: range)
    }
    
    private func didTapAttributedText(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        guard let attributedText = label.attributedText else {
            
            assertionFailure("attributedText must be set")
            return false
        }
        
        let textContainer = createTextContainer(for: label)
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        if let font = label.font {
            
            textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))
        }
        textStorage.addLayoutManager(layoutManager)
        
        let locationOfTouchInLabel = location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let alignmentOffset = aligmentOffset(for: label)
        
        let xOffset = ((label.bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((label.bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - xOffset, y: locationOfTouchInLabel.y - yOffset)
        
        let characterTapped = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        let lineTapped = Int(ceil(locationOfTouchInLabel.y / label.font.lineHeight)) - 1
        let rightMostPointInLineTapped = CGPoint(x: label.bounds.size.width, y: label.font.lineHeight * CGFloat(lineTapped))
        let charsInLineTapped = layoutManager.characterIndex(for: rightMostPointInLineTapped, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return characterTapped < charsInLineTapped ? targetRange.contains(characterTapped) : false
    }
    
    private func createTextContainer(for label: UILabel) -> NSTextContainer {
        
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        return textContainer
    }
    
    private func aligmentOffset(for label: UILabel) -> CGFloat {
        
        switch label.textAlignment {
            
        case .left, .natural, .justified:
            
            return 0.0
        case .center:
            
            return 0.5
        case .right:
            
            return 1.0
            
            @unknown default:
            
            return 0.0
        }
    }
}
extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
