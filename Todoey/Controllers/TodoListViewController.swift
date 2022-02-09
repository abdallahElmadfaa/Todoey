//
//  ViewController.swift
//  Todoey
//
//  Created by Abdallah Elmadfa'a on 07/02/2022.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
   // let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print(dataFilePath!)
        
//        let newItem = item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//        
//        let newItem2 = item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//        
//        let newItem3 = item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        
//        if let items = UserDefaults.standard.array(forKey: "TodoListArray") as? [item] {
//            itemArray = items
//        }
        
        loadItems()
        
    }

    
    // Mark - tableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item  = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    // Mark tableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
  
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
       // tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    // Mark - Add new items
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // wwww
            print("Success!")
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
           
        }
        
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Create New Item"
            textField = alertTF

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveItems () {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error Encoding item array \(error)")
        }

        
        tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([item].self, from: data)
            } catch{
                print("Error decoding items \(error)")
            }
        }
        

    }
    


}
