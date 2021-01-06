//
//  Extensions+UIView.swift
//  placepic
//
//  Created by elesahich on 2020/07/17.
//  Copyright © 2020 elesahich. All rights reserved.
//

import Foundation
import UIKit

internal extension UIView {
    func constraint(to view: UIView,
                    attribute: NSLayoutConstraint.Attribute,
                    secondAttribute: NSLayoutConstraint.Attribute,
                    inset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = NSLayoutConstraint(item: self,
                                   attribute: attribute,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: secondAttribute,
                                   multiplier: 1,
                                   constant: inset)
        c.isActive = true
    }
    
    func constraint(_ anchor: NSLayoutDimension, constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        anchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func pinEdges(to view: UIView, insets: UIEdgeInsets = .zero){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: self,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: view,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: insets.top)
        
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: insets.bottom)
        
        let leading = NSLayoutConstraint(item: self,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: insets.left)
        
        let trailing = NSLayoutConstraint(item: self,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: insets.right)
        NSLayoutConstraint.activate([
            top, bottom, leading, trailing
        ])
    }
}


extension UIView {
    func makeShadow(_ color: UIColor, _ opacity: Float, _ offset: CGSize, _ radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    @IBInspectable
    var ibCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue
        }
    }
    
    
    func addActivityIndicator() {
        //    creating a view (let's call it "loading" view) which will be added on top of the view you want to have activity indicator on (parent view)
        let view = UIView()
        //    setting up a background for a view so it would make content under it look like not active
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        //    adding "loading" view to a parent view
        //    setting up auto-layout anchors so it would cover whole parent view
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //    creating array with images, which will be animated
        //    in my case I have 30 images with names activity0.png ... activity29.png
        var imagesArray: [UIImage] = []
        imagesArray.append(UIImage(named: "circleCafe")!)
        imagesArray.append(UIImage(named: "circleEtc")!)
        imagesArray.append(UIImage(named: "circleRestaurant")!)
        imagesArray.append(UIImage(named: "circleStudy")!)
        imagesArray.append(UIImage(named: "circleCafe")!)
        imagesArray.append(UIImage(named: "circleEtc")!)
        imagesArray.append(UIImage(named: "circleRestaurant")!)
        imagesArray.append(UIImage(named: "circleStudy")!)
        
        //    creating UIImageView with array of images
        //    setting up animation duration and starting animation
        let activityImage = UIImageView()
        activityImage.animationImages = imagesArray
        activityImage.animationDuration = TimeInterval(1)
        activityImage.startAnimating()
        
        //    adding UIImageView on "loading" view
        //    setting up auto-layout anchors so it would be in center of "loading" view with 30x30 size
        view.addSubview(activityImage)
        activityImage.translatesAutoresizingMaskIntoConstraints = false
        activityImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func removeActivityIndicator() {
        //    checking if a view has subviews on it
        guard let lastSubView = self.subviews.last else { return }
        //    removing last subview with an assumption that last view is a "loading" view
        lastSubView.removeFromSuperview()
        
    }
}

extension CALayer {
  func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
    for edge in arr_edge {
      let border = CALayer()
      switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
          break
        case UIRectEdge.right:
          border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
          break
         default:
           break
      }
      border.backgroundColor = color.cgColor
      self.addSublayer(border)
    }
  }
}
