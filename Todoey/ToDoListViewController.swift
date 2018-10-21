//
//  ViewController.swift
//  Todoey
//
//  Created by alaa alrabi on 10/21/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    let itemArray = ["FInd mike","Buy Eggs","Destroy Demogorgon"]
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


}


