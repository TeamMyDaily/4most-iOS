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

      super.viewDidLoad()
      
      // 2. Start AnimationView with animation name (without extension)
      
      animationView = .init(name: "ios_data")
      
      animationView!.frame = view.bounds
      
      // 3. Set animation content mode
      
      animationView!.contentMode = .scaleAspectFit
      
      // 4. Set animation loop mode
      
      animationView!.loopMode = .loop
      
      // 5. Adjust animation speed
      
      animationView!.animationSpeed = 0.5
      
      view.addSubview(animationView!)
      
      // 6. Play animation
      
      animationView!.play()
      
    }

}
