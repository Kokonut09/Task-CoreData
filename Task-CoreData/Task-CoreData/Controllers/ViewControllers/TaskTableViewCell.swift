//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Andrew Saeyang on 7/27/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    
    // MARK: - PROPERTIES
    
    weak var delegate: TaskCompletionDelegate?
    
    var task: Task? {
        didSet{
            updateViews()
        }
    }
    
    
    // MARK: - HELPER METHODS
    func updateViews(){
       
        guard let task = task else { return }
        taskNameLabel.text = task.name
        
        let image = task.isComplete ? ( UIImage(named: "complete") ?? UIImage() ) : ( UIImage(named: "incomplete") ?? UIImage() )
        print(image)
        completionButton.setBackgroundImage(image, for: .normal)
        
        
    }
    
    // MARK: - LIFECYCLES
    
    // MARK: - ACTIONS
    @IBAction func completionButtonTapped(_ sender: Any) {
        print("tappy tap")
        delegate?.taskCellButtonTapped(self)
        
    }
    

}
