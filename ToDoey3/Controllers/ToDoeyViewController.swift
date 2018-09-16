//
//  ViewController.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/15/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit

class ToDoeyViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        if let items = defaults.array(forKey: "ss") as? [Item]{
            itemArray = items
        }
        let arrayItem = Item()
        arrayItem.title = "Ali"
        itemArray.append(arrayItem)
        
        
        let arrayItem3 = Item()
        arrayItem3.title = "ss"
        itemArray.append(arrayItem3)
        
        itemArray.append(arrayItem3)
        itemArray.append(arrayItem3)
        itemArray.append(arrayItem3)
        itemArray.append(arrayItem3)
        itemArray.append(arrayItem3)
        itemArray.append(arrayItem3)
        
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
     
        
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let item = Item()
            item.title = textField.text!
            
           self.itemArray.append(item)
            
           self.defaults.set(self.itemArray, forKey: "s")
           
           
     
           
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write Item"
           
        textField = alertTextField
        }
        alert.addAction(action)
        present(alert , animated: true)
        
    }
    
}



