//
//  ViewController.swift
//  Todoey
//
//  Created by alaa alrabi on 10/21/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    //    var defaults  = UserDefaults.standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         loadItems()
       print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist"))
        
        
        
        
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
        //        UPDATING
        //        itemArray[indexPath.row].setValue("completed", forKey: "title")
        
        //this is the deleting part we need to delete from context then delete from local memroy :)
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//
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
            let newItem = Item(context: self.context)
            newItem.title = textFeild.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            
            //            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.saveItems()
            
            
        }
        Alert.addAction(action)
        
        present(Alert,animated: true,completion: nil)
        
    }
    // MARK: - Save data fucntion
    func saveItems(){
        
        do {
            try context.save()
            
        } catch{
            print("error saving messages")
            
        }
        self.tableView.reloadData()
        
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate :NSPredicate? = nil){
        
        // case is required to to spicify  the data type get the enittity am gonna get
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }else {
            request.predicate = categoryPredicate

        }
        do{
          itemArray =  try context.fetch(request)
        }catch{
            print("Error fetching data \(error.localizedDescription)")
        }
        tableView.reloadData()
        
    }
    
    
}
// MARK: - Search bar methods
extension ToDoListViewController : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request,predicate: predicate)
       
        
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

