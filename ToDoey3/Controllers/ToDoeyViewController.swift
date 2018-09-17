//
//  ViewController.swift
//  ToDoey3
//
//  Created by Dyary Raoof Bayz on 9/15/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit

class ToDoeyViewController: UITableViewController {

     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()

   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
      loadData()
        
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
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let item = Item()
            item.title = textField.text!
            
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
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
            
        }catch{
            print(error)
        }
        
        tableView.reloadData()
    }
    
    func loadData (){
        
                if let data = try? Data(contentsOf: dataFilePath!){
                let decoder = PropertyListDecoder()
                   
                    do {
                          itemArray = try decoder.decode([Item].self, from: data)
                        
                    }
                    catch{
                     
                        print(error)
                    }
        
    }
    }



}
