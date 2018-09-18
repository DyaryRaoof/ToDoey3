//
//  ViewController.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/15/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import CoreData

class ToDoeyViewController: UITableViewController {

     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
    var itemArray = [Item]()
    
 let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
     loadData()
        
        print(dataFilePath)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoeyCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        //itemArray[indexPath.row].setValue("Completeed", forKey: "title")
        // the above method can be used for updating CRUD Coredata
        
        //using this we can delete items from our CoreData
     //   context.delete(itemArray[indexPath.row])
      //  itemArray.remove(at: indexPath.row)
        
         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
           
            
            let item = Item(context: self.context)
            
            item.title = textField.text!
            item.done = false
            
           self.itemArray.append(item)
            
            self.tableView.reloadData()
        }
        
        saveItems()
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write Item"
           
        textField = alertTextField
        }
        alert.addAction(action)
        present(alert , animated: true)
        
    }
    
    
    func saveItems(){
       
        do {
             try context.save()
        }catch{
            print(" Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData (with request : NSFetchRequest<Item> = Item.fetchRequest()){
    
    do{
        itemArray = try context.fetch(request)
    } catch {
        print("Error ! couldn't load request int to context do to \(error)")
    }
    
        tableView.reloadData()
    }
    

}

//MARK: - SearchBar
extension ToDoeyViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
         request.predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
       
        request.sortDescriptors  = [NSSortDescriptor(key: "title", ascending: true)]
       loadData(with: request)
    
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
