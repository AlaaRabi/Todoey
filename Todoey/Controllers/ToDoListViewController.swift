//
//  ViewController.swift
//  Todoey
//
//  Created by alaa alrabi on 10/21/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var toDoItem:Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    //MARK - Table View DataSoruce Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for :indexPath)
        
        if  let item = toDoItem?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            
            cell.accessoryType  = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No items added"
        }
        
        
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem?.count ?? 1
    }
    // MARK: - TableView Delegate methods bb
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item =  toDoItem?[indexPath.row] {
            do{
            try realm.write {
                item.done = !item.done

                }}catch{
                    print("error changing clicked item state")
            }
            
        }
       
        tableView.reloadData()
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
            
          
            if let category = self.selectedCategory {
                
                do{
                    try self.realm.write {
                        let newItem  = Item()
                        newItem.title = textFeild.text!
                        newItem.done = false
                        newItem.dateCreated = Date()
                        category.Items.append(newItem)
                        self.realm.add(newItem)
                    }
                    
                }catch{
                    print("Error :\(error)")
                }
                self.tableView.reloadData()
            }
            
            
        }
        Alert.addAction(action)
        
        present(Alert,animated: true,completion: nil)
        
    }
    
    
    func loadItems(){
        
        toDoItem = selectedCategory?.Items.sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
    
    
}
// MARK: - Search bar methods
extension ToDoListViewController : UISearchBarDelegate {


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItem = toDoItem?.filter(NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }


    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        // Stop doing the search stuff
//        // and clear the text in the search bar
//        searchBar.text = ""
//        // Hide the cancel button
//        searchBar.showsCancelButton = false
//        // You could also change the position, frame etc of the searchBar
//        searchBar.endEditing(true)
//        loadItems()
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}

