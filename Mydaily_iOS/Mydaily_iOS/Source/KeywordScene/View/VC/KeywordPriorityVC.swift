//
//  KeywordPriorityVC.swift
//  Mydaily_iOS
//
//  Created by honglab on 2021/01/05.
//

import UIKit

class KeywordPriorityVC: UIViewController {
    static let identifier = "KeywordPriorityVC"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keywordTableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    var model = Model()
    
    var keywordList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        setTableViewDelegate()
        model.setModelList(list: keywordList)
    }
    
    func setTableViewDelegate(){
        keywordTableView.dragInteractionEnabled = true // Enable intra-app drags for iPhone.
        keywordTableView.dragDelegate = self
        keywordTableView.dropDelegate = self
        keywordTableView.delegate = self
        keywordTableView.register(UINib(nibName: "KeywordPriorityTVC", bundle: .main), forCellReuseIdentifier: KeywordPriorityTVC.identifier)
    }
    
    func setTitleLabel(){
        titleLabel.numberOfLines = 0
        titleLabel.text = "키워드에 대한\n우선순위를 세워보세요!"
    }
    
    func setCompleteButton(){
        completeButton.titleLabel?.font =  UIFont(name: "System-Bold", size: 18.0)
        completeButton.layer.cornerRadius = 15
        completeButton.isEnabled = false
    }
    
    func setReceivedKeywordList(list: [String]){
        keywordList = list
        print("------------------")
        for txt in list{
            print(txt)
        }
    }
}

extension KeywordPriorityVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordPriorityTVC.identifier) as? KeywordPriorityTVC else{
            return UITableViewCell()
        }
        print("table셀 이상해,,")
        cell.setKeywordLabel(text: keywordList[indexPath.row])
        
        return cell
    }
}

extension KeywordPriorityVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        model.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension KeywordPriorityVC: UITableViewDragDelegate{
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return model.dragItems(for: indexPath)
    }
    
}


//먼저 drop 하려면 3개의 함수구현 해야 함
extension KeywordPriorityVC: UITableViewDropDelegate{
    
    //그중 1번 This project’s implementation allows a user to drop only instances of the NSString class
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return model.canHandle(session)
    }
    
    
    //2번 어떤 데이터를 가져다 쓸건지 -> 실제로는 copy해서 사용
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        print("dropSessionDidUpdate \(session)")
        
        // Accept only one drag item.
        guard session.items.count == 1 else { return dropProposal }
        
        
        dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        // The .move drag operation is available only for dragging within this app and while in edit mode.
        
        if tableView.hasActiveDrag {
            if tableView.isEditing {
                dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            // Drag is coming from outside the app.
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
         
        return dropProposal
    }
    
    //마지막 3번 정말 item이 drop 될 때,
    //your table view has one opportunity to request particular data representations of the drag items
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
       
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // Get last index path of table view.
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            // Consume drag items.
            let stringItems = items as! [String]
            
            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                self.model.addItem(item, at: indexPath.row)
                indexPaths.append(indexPath)
            }

            tableView.insertRows(at: indexPaths, with: .automatic)
        }
       
    }
}
