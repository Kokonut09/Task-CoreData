//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by Andrew Saeyang on 7/27/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        TaskController.shared.fetchTask()
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell()}
        
        cell.task = TaskController.shared.tasks[indexPath.row]
        // Configure the cell...
        //cell.textLabel?.text = task.name
        cell.delegate = self
        
        //cell.task = task
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            
            TaskController.shared.deleteTaskWith(task: taskToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Identifier
        if segue.identifier == "toDetailVC"{
            
            // Index Path
            // Destination
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            
            // Object to send
            let task = TaskController.shared.tasks[indexPath.row]
            
            // Object to Recieve
            destination.task = task
            
            
        }
    }
}// End of class

extension TaskListTableViewController: TaskCompletionDelegate{
    
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        TaskController.shared.toggleIsComplete(task: task)
        
        sender.updateViews()
        //tableView.reloadData()
    }
} // end of extension
