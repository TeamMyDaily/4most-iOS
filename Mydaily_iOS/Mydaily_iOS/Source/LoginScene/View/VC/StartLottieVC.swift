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
        
        print("로티 시작")
        setupLottieView()
        print("로티 끝남")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [self] in
            goOnBoardPopUp()
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        print(viewWillAppear)
       // goOnBoardPopUp()
    }

    func setupLottieView() {
        view.backgroundColor = UIColor.white
        animationView = .init(name: "newios2_data")
        animationView!.frame = CGRect.zero
        animationView!.contentMode = .scaleAspectFit
//        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        animationView!.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView!)
        
        NSLayoutConstraint.activate([
            animationView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            animationView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            animationView!.widthAnchor.constraint(equalToConstant: 600),
            animationView!.heightAnchor.constraint(equalToConstant: 600),
        ])
        animationView!.play()
        print("애니메이션 끝남")
    }
    
    
    func goOnBoardPopUp(){
        print("goOnBoardPopUp 시작")
//        let keywordStoryboard = UIStoryboard(name: "Keyword", bundle: nil)
//        print(keywordStoryboard)
        let dvc = self.storyboard?.instantiateViewController(identifier: OnBoardPopUpVC.identifier) as! OnBoardPopUpVC
        print(dvc)
       
        dvc.checkOnBoard(check: true)
        
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
    }

    
}

