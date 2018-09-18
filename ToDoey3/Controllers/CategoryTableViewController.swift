//
//  CategoryTableViewController.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/17/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoriesArray = [Categories]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadCategories()
        
    }
    //MARK: - TableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoriesArray[indexPath.row].name
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories() {
        do {
           try context.save()
        }catch {
            print("Couldn't Save to persistent container\(error)")
        }
    }
    
    func loadCategories (){
        let request: NSFetchRequest<Categories> = Categories.fetchRequest()
        
        do {
             categoriesArray = try context.fetch(request)
            tableView.reloadData()
        }catch {
            print ("Couldn't load categories \(error)")
        }
       
    }
    
    //MARK: - Add new Categories Methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory =  Categories(context: self.context)
            newCategory.name = textField.text
            
            self.categoriesArray.append(newCategory)
            
           self.loadCategories()
            
            print(self.dataFilePath)
            
            
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
       
            textField = alertTextField
        }
        present(alert , animated: true)
        
        
        saveCategories()
    }
    
}
