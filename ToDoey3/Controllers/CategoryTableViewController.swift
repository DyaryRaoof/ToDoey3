//
//  CategoryTableViewController.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/17/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryTableViewController:  SwipeTableViewController {
    
   

    let realm = try! Realm()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
   
    var categoriesArray : Results<Category>?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    //MARK: - TableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoriesArray?[indexPath.row].name ?? "No Categories"
        
        
        if let category = categoriesArray?[indexPath.row]{
            
            guard  let categoryColor = UIColor(hexString: (category.color)) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            
        }
        return cell
    }
    
    // Mark: = TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoeyViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoriesArray?[indexPath.row]
        }
    }
    
    
    //MARK: - Delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        
         if let categoryForDeletion = self.categoriesArray?[indexPath.row] {
         do {
         try self.realm.write {
         self.realm.delete(categoryForDeletion)
         }
         }catch{
         print("Couldn't delete category \(error)")
         }
         
         }
 
        
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Couldn't Save to persistent container\(error)")
        }
    }
    
   func loadCategories (){
      categoriesArray = realm.objects(Category.self)
      tableView.reloadData()
    }
    
    //MARK: - Add new Categories Methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory =  Category()
            newCategory.name = textField.text!
            newCategory.color =  UIColor.randomFlat.hexValue()
            
            
           
            self.save( category: newCategory)
          
           self.loadCategories()
            self.tableView.reloadData()
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
       
            textField = alertTextField
        }
        present(alert , animated: true)
        
        
       
    }
    
}



