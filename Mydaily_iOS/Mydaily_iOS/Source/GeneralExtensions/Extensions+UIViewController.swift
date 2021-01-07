//
//  Extensions+UIViewController.swift
//  placepic
//
//  Created by elesahich on 2020/10/17.
//  Copyright © 2020 elesahich. All rights reserved.
//

import Foundation
import UIKit

func topViewController() -> UIViewController? {
    if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
        if var viewController = window.rootViewController {
            while viewController.presentedViewController != nil {
                viewController = viewController.presentedViewController!
            }
            print("topViewController -> \(String(describing: viewController))")
            return viewController
        }
    }
    return nil
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupStatusBar(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let margin = view.layoutMarginsGuide
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            statusbarView.frame = CGRect.zero
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
    
    func setupNavigationBar(_ color: UIColor) {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = color
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
    
//    func _configure(with dataSource: TPDataSource, delegate: TPProgressDelegate? = nil, state: Int, containVC: ContainerViewController) {
////        let vc = ContainerViewController()
//
//        if state == 0 {
//            containVC.dataSource = dataSource
//            containVC.delegate = delegate
//            self.add(containVC)
//            containVC.view.pinEdges(to: self.view)
//        }
//        else{
//            containVC.removeFromParent()
//        }
//    }
}

public extension UIViewController {
    func add(_ child: UIViewController, to: UIView? = nil, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        if let toView = to {
            toView.addSubview(child.view)
        } else {
            view.addSubview(child.view)
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    var bottomInset: CGFloat{
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return bottomLayoutGuide.length
        }
    }
    
    var topInset: CGFloat{
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        } else {
            return topLayoutGuide.length
        }
    }
    
//    func _configure(with dataSource: TPDataSource, delegate: TPProgressDelegate? = nil, state: Int, containVC: ContainerViewController) {
////        let vc = ContainerViewController()
//
//        if state == 0 {
//            containVC.dataSource = dataSource
//            containVC.delegate = delegate
//            self.add(containVC)
//            containVC.view.pinEdges(to: self.view)
//        }
//        else{
//            containVC.removeFromParent()
//        }
//    }
    
//    func _configure(with dataSource: TPDataSource, delegate: TPProgressDelegate? = nil) {
//        let vc = ContainerViewController()
//        vc.dataSource = dataSource
//        vc.delegate = delegate
//        self.add(vc)
//        vc.view.pinEdges(to: self.view)
//    }
}
