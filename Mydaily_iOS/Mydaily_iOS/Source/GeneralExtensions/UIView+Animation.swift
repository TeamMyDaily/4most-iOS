//
//  UIView+Animation.swift
//  placepic
//
//  Created by elesahich on 2020/06/29.
//  Copyright © 2020 elesahich. All rights reserved.
//
import UIKit

public extension UIView {
    func startRotating(
        clockwise: Bool = true,
        duration: Double = 1,
        repeatCount: Float = .infinity
    ) {
        let keyPath = "transform.rotation"
        guard layer.animation(forKey: keyPath) == nil else { return }
        
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.fromValue = 0.0
        
        let toValue = clockwise ? CGFloat(.pi * 2.0) : CGFloat(-.pi * 2.0)
        animation.toValue = toValue
        
        layer.add(animation, forKey: keyPath)
    }
    
    func stopRotating() {
        let keyPath = "transform.rotation"
        guard layer.animation(forKey: keyPath) != nil else { return }
        layer.removeAnimation(forKey: keyPath)
    }
    
    func startPulse(
        fromScale: CGFloat = 1,
        toScale: CGFloat = 1.1,
        duration: CFTimeInterval = 0.2,
        repeatCount: Float = .infinity
    ) {
        let keyPath = "transform.scale"
        guard layer.animation(forKey: keyPath) == nil else { return }
        
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration / 2
        animation.repeatCount = repeatCount
        animation.fromValue = fromScale
        animation.toValue = toScale
        animation.autoreverses = true
        
        layer.add(animation, forKey: keyPath)
    }
    
    func stopPulse() {
        let keyPath = "transform.scale"
        guard layer.animation(forKey: keyPath) != nil else { return }
        layer.removeAnimation(forKey: keyPath)
    }
    
    func fadeTransition(_ duration: CFTimeInterval = 0.2) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut
        )
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
