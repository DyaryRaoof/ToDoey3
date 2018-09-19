//
//  ViewController.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/15/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoeyViewController: UITableViewController {

     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    let realm =  try! Realm()
    
    var todoItems : Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
           loadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    // loadData()
        
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoeyCell", for: indexPath)
        
        
        
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Items"
        }
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        if let item = todoItems?[indexPath.row] {
           
            do {
                try realm.write {
                  item.done = !item.done
                    
                  
                }
            }catch {
                print("Coulnd't save data due to \(error)")
            }
           
        }
     tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
           
            if let currentCategory = self.selectedCategory {
               
                
                do {
                    try self.realm.write {
                        let item = Item()
                        item.title = textField.text!
                        item.dateCreated = Date()
                        
                        currentCategory.items.append(item)
                    }
                }catch {
                    print("Error saving new item\(error)")
                }
            }
           
            
            self.tableView.reloadData()
        }
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write Item"
           
        textField = alertTextField
        }
        alert.addAction(action)
        present(alert , animated: true)
        
    }
    
    
    func loadData (){
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    

}
 

//MARK: - SearchBar

 
extension ToDoeyViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
 

