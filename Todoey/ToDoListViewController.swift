//
//  ViewController.swift
//  Todoey
//
//  Created by alaa alrabi on 10/21/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    var itemArray = [String]()
    var note:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Table View DataSoruce Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for :indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
         return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    // MARK: - TableView Delegate methods bb
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(itemArray[indexPath.row])")
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFeild = UITextField()
        
        let Alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        Alert.addTextField { (alerttextfeild) in
            alerttextfeild.placeholder = "Create a new item"
            textFeild = alerttextfeild
            
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen when add is pressed
            
//            let textField = Alert.textFields![0] // Force unwrapping because we know it exists.
          self.itemArray.append(textFeild.text!)
            self.tableView.reloadData()
            
        }
        Alert.addAction(action)
        
    present(Alert,animated: true,completion: nil)
        
    }
}


