//
//  Extensions+UIColor.swift
//  ToyProject@Crecker
//
//  Created by elesahich on 2020/05/27.
//  Copyright © 2020 elesahich. All rights reserved.
//
import UIKit

extension UIColor {
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var gray10: UIColor {
        return UIColor(white: 248.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray20: UIColor {
        return UIColor(white: 243.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray30: UIColor {
        return UIColor(white: 241.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray60: UIColor {
        return UIColor(white: 99.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray50: UIColor {
        return UIColor(white: 189.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray40: UIColor {
        return UIColor(white: 205.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray70: UIColor {
        return UIColor(white: 79.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray80: UIColor {
        return UIColor(white: 64.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray90: UIColor {
        return UIColor(white: 54.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 117.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainLightOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 138 / 255.0, blue: 123 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainPaleOrange: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 199 / 255.0, blue: 186 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainDarkOrange: UIColor {
        return UIColor(red: 236.0 / 255.0, green: 104 / 255.0, blue: 74 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainBlack: UIColor {
        return UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainGray: UIColor {
        return UIColor(red: 201.0 / 255.0, green: 201.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainLightGray: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mainBlue: UIColor {
        return UIColor(red: 47.0 / 255.0, green: 128.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
}


extension UIColor {
    convenience init(hexString: String) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
