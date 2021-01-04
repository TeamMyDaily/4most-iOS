//
//  NextKeywordVC.swift
//  Mydaily_iOS
//
//  Created by 장혜령 on 2021/01/05.
//

import UIKit

class NextKeywordVC: UIViewController {
    static let identifier = "NextKeywordVC"
    
    var keywordList: [[String]] = []
    
    @IBOutlet var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printReceiveList()
        
    }
    
    func setkeywordContentView(){
        let content = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height - 100))
        //footer.backgroundColor = .systemRed
        //오토레이아웃을 코드로 지정 할 때 사용
    }

    func printReceiveList(){
        testLabel.numberOfLines = 0
        for i in keywordList{
            print("-----\(i)-----")
            testLabel.text! += "-------------\n"
            for j in i {
                print(j)
                testLabel.text! += (j + "\n")
            }
        }
    }
    
    func setReceivedKeywordList(list: [[String]]){
        keywordList = list
    }
    
    
}
