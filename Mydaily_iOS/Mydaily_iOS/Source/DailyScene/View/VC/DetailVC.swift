//
//  SampleThreePartTableViewController.swift
//  DynamicCellHeight
//
//  Created by Don Mag on 3/23/17.
//  Copyright © 2017 DonMag. All rights reserved.
//

import UIKit

class DetailVC: UITableViewController, ThreePartCellDelegate {
    

    var myArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableVC()

        // create some random data
        for _ in 1...4 {
            
            let n = arc4random_uniform(6) + 4
            var str = ""
            for i in 1..<n {
                str += "Line \(i)\n"
            }
            
            
            myArray.append(str)
            
        }
        print(myArray)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - my cell delegate
    func moreTapped(cell: DetailTVC) {
        
        // this will "refresh" the row heights, without reloading
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "threePartCellID", for: indexPath) as! DetailTVC
        
        // Configure the cell...
        
        let str = myArray[indexPath.row]
        cell.labelBody.textColor = .white
        cell.myInit(theTitle: "아웃풋", theBody: str)
        
        cell.delegate = self
        
        return cell
    }
    
    
}
//SampleThreePartTableViewController
extension DetailVC {
    func setTableVC(){
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset.right = 16
        tableView.separatorInset.left = 16
    }
}
