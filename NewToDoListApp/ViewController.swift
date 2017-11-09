//
//  ViewController.swift
//  NewToDoListApp
//
//  Created by Vidyadhar V. Thatte on 11/1/17.
//  Copyright © 2017 VdThatte. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskInutField: UITextField!
    @IBOutlet weak var tasksTable: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks : [NSManagedObject] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let person = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "task") as? String
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tasks = []
        do {
            self.tasks = try context.fetch(Tasks.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let textField = self.taskInutField,
            let nameToSave = textField.text else {
                return
        }
        print(nameToSave)
        self.save(name: nameToSave)
        self.tasksTable.reloadData()
        
    }
    
    func save(name: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "task")
        print(person)
        do {
            try managedContext.save()
            tasks.append(person)
            self.taskInutField.text = ""
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    

}

