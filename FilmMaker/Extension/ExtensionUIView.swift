//
//  ExtensionUIView.swift
//  BeedaWallet
//
//  Created by RASHED on 10/14/22.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            var masked = CACornerMask()
            if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
            if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
            if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
            if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
            self.layer.maskedCorners = masked
        }
        else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

extension UIView {
    func roundCornersWithRadious() {
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 0.20).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
    
    func roundCornersWithSmallRadious() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 0.20).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 3.0
        self.layer.masksToBounds = false
    }
    
    func addBottomShadow() {
        // self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 0.20).cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                          y: bounds.maxY - layer.shadowRadius,
                                                          width: bounds.width,
                                                          height: layer.shadowRadius)).cgPath
    }
    
    func addUpperShadow() {
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0
        self.layer.shadowColor = UIColor(red: 0.09, green: 0.23, blue: 0.87, alpha: 0.20).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height : -5.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6
    }
    
    func setBorder() {
        self.layer.borderWidth = 1.3
        self.layer.borderColor = UIColor(red: 0.95, green: 0.95, blue: 1.00, alpha: 1.00).cgColor
        self.layer.cornerRadius = 6
    }
    
}
