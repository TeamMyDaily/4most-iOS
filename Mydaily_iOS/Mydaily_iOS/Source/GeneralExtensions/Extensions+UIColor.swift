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

  @nonobjc class var blueGray10: UIColor {
    return UIColor(red: 241.0 / 255.0, green: 244.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGray20: UIColor {
    return UIColor(red: 238.0 / 255.0, green: 239.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGray30: UIColor {
    return UIColor(red: 206.0 / 255.0, green: 212.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGray40: UIColor {
    return UIColor(red: 173.0 / 255.0, green: 182.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGray50: UIColor {
    return UIColor(red: 163.0 / 255.0, green: 171.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGray60: UIColor {
    return UIColor(red: 160.0 / 255.0, green: 166.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGray70: UIColor {
    return UIColor(red: 134.0 / 255.0, green: 143.0 / 255.0, blue: 150.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGray80: UIColor {
    return UIColor(red: 131.0 / 255.0, green: 135.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var warmPink: UIColor {
    return UIColor(red: 246.0 / 255.0, green: 92.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)
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
