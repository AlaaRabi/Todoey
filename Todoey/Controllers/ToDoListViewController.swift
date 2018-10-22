//
//  ViewController.swift
//  Todoey
//
//  Created by alaa alrabi on 10/21/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    var itemArray = [Item]()
//    var defaults  = UserDefaults.standard
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     loadItems()
    print(filePath)



    }
    
    //MARK - Table View DataSoruce Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for :indexPath)
        cell.textLabel?.text = item.title
        
        cell.accessoryType  = item.done ? .checkmark : .none
        
        
         return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    // MARK: - TableView Delegate methods bb
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done
        

            saveItems()
        
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
            let item = Item()
            item.title = textFeild.text!
          self.itemArray.append(item)
            
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
           self.saveItems()
            
            
        }
        Alert.addAction(action)
        
    present(Alert,animated: true,completion: nil)
        
    }
    // MARK: - Save data fucntion
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data  = try encoder.encode(itemArray)
            try  data.write(to: filePath!)
        }catch{
            print("Something wrong with encoding :)")
        }
        self.tableView.reloadData()

    }
    func loadItems(){
        if  let data = try? Data(contentsOf: filePath!) {
            let decoder =  PropertyListDecoder()
            do {
            itemArray = try  decoder.decode([Item].self, from: data)
            }catch {
                print("somthing went wrong when decoding ")
            }
        }
    }
    
}


