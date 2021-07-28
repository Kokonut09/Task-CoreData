//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Andrew Saeyang on 7/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - OUTLETS
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextField: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - PROPERTIES
    var task: Task?
    
    //var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - HELPER METHODS
    func updateViews(){
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextField.text = task.notes
        
        //because date is optional, nil coalecnce
        taskDueDatePicker.date = task.dueDate ?? Date()
        
    }
    
    // MARK: - ACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
              
        let notes = taskNotesTextField.text
        let date = taskDueDatePicker.date
        
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: date)
            
        }else{
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: date)
            
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    //or when dragging set it to UIDatePicker
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        guard let picker = sender as? UIDatePicker else { return }
        
        taskDueDatePicker.date = picker.date
        
    }
}// End of class
