//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by alaa alrabi on 10/23/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

   
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfeild = UITextField()
        
       let alert  = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Type you Category Name"
            textfeild = alertTextFeild
        }
        let action =  UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
          
            let newCategory = Category()
            newCategory.name = textfeild.text!
            
           
            
            self.saveCategory(categroy: newCategory)
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
        
    }
  
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ??  "There is no Categoires added "
        
        return cell
    }
    // MARK: - Table view delegete Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! ToDoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categoryArray?[indexPath.row]
            }
        }
    }
    
    
    
    // MARK: - Data minpulation methods

    func saveCategory(categroy: Category){
        do{
            try  realm.write {
                realm.add(categroy)
            }
            
        }catch {
            print("error saving category : \(error.localizedDescription)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(){
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
  
    
    
}
