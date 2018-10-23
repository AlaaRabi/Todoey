//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by alaa alrabi on 10/23/18.
//  Copyright © 2018 alaa alrabi. All rights reserved.
//

import UIKit
import CoreData


class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
          
            let newCategory = Category(context: self.context)
            newCategory.name = textfeild.text!
           self.categoryArray.append(newCategory)
            
            self.saveCategory()
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
        
    }
  
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
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
                destinationVC.selectedCategory = categoryArray[indexPath.row]
            }
        }
    }
    
    
    
    // MARK: - Data minpulation methods

    func saveCategory(){
        do{
            try context.save()
            
        }catch {
            print("error saving category : \(error.localizedDescription)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(){
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        do{
         categoryArray =  try context.fetch(request)
           
        }catch {
            print("error fetching data: \(error.localizedDescription)")
        }
        tableView.reloadData()
        
    }
  
    
    
}
