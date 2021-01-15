//
//  StartLottieVC.swift
//  Mydaily_iOS
//
//  Created by 이유진 on 2021/01/14.
//

import UIKit
import Lottie

class StartLottieVC: UIViewController {
    
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        setupLottieView()
        print("dd")
    }
    
    func setupLottieView() {
        view.backgroundColor = UIColor.white
        animationView = .init(name: "lottie")
        animationView!.frame = CGRect.zero
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        animationView!.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView!)
        
        NSLayoutConstraint.activate([
            animationView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 75),
            animationView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            animationView!.widthAnchor.constraint(equalToConstant: 600),
            animationView!.heightAnchor.constraint(equalToConstant: 600),

        ])
        
        animationView!.play()
    }
    
}
