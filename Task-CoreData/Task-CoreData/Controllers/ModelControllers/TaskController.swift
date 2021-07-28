//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Andrew Saeyang on 7/27/21.
//

import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    // MARK: - PROPERTIES
    
    var tasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        
        let reqeust = NSFetchRequest<Task>(entityName: "Task")
        
        reqeust.predicate = NSPredicate(value: true)
        
        return reqeust
        
    }()
    
    // MARK: - CRUD
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?){
        let taskToAdd = Task(name: name, notes: notes, dueDate: dueDate)
        
        tasks.append(taskToAdd)
        
        CoreDataStack.saveContext()
    }
    
    func fetchTask(){
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        self.tasks = tasks
        
        CoreDataStack.saveContext()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?){
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task){
        task.isComplete.toggle()
        
        CoreDataStack.saveContext()
    }
    
    func deleteTaskWith(task: Task){
        
        guard let index = tasks.firstIndex(of: task) else { return }
        
        print("We good deletin")
        tasks.remove(at: index)
        
        //IMPORTANT TO REMVOE FROM PERSISTANCE
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
}// End of class
