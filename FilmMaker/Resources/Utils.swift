//
//  PhoneNumberListViewController.swift
//  NotifyMe
//
//  Created by RASHED on 14/10/22.
//

import UIKit

//MARK- TextField Padding
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension String {
    
}

//MARK- ScrollView Contentsize
enum ScrollDirection {
    case Top
    case Right
    case Bottom
    case Left
    
    func contentOffsetWith(scrollView: UIScrollView) -> CGPoint {
        var contentOffset = CGPoint.zero
        switch self {
        case .Top:
            contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
        case .Right:
            contentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
        case .Bottom:
            contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        case .Left:
            contentOffset = CGPoint(x: -scrollView.contentInset.left, y: 0)
        }
        return contentOffset
    }
}
//MARK- UIScrollView content size
extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
        //Added extra height for scrollview
        //contentSize.height += 5
    }
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        if self.contentSize.height > UIScreen.main.bounds.height{
            self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
        }
    }
}

extension UIImage {
    static func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIButton {
    func getButtonComponentsWithCornerRadious() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 1.00).cgColor
        self.layer.borderWidth = 0.5
        self.layer.backgroundColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 1.00).cgColor
    }
    
    func roundCornerButtonWithShadow(){
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true

        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
    }
    
    func buttonStyleRoundwithBorder(){
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.75
        self.layer.borderColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 1.00).cgColor
    }
    
}

extension UITextField {
    func getTextFieldComponenets() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor(red: 0.49, green: 0.49, blue: 0.49, alpha: 1.00).cgColor
    }
    
    func setBorderForTextField() {
        self.layer.borderWidth = 1.3
        self.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 1.00, alpha: 1.00).cgColor
        self.layer.cornerRadius = 6
    }
}


class Utils: NSObject {
    class func setInsertedPhoneNumber(id: NSArray){
        UserDefaults.standard.set(id, forKey: "store_array")
    }
    
    class func getInsertedPhoneNumber() -> [String] {
        UserDefaults.standard.stringArray(forKey: "store_array") ?? [String]()
    }
    
    class func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9]{6,14}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    } 
}

