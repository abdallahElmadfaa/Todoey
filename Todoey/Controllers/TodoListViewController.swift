//
//  ViewController.swift
//  Todoey
//
//  Created by Abdallah Elmadfa'a on 07/02/2022.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var todoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        searchBar.delegate = self

        //loadItems()
        
    }

    
    // Mark - tableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item  = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added!"
        }
        

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
        
//        law 3awz a3ml update fe Realm ⬇️⬇️
        if let item  = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status! \(error)")
            }
        }
        
//        law 3awz a3ml update fe Realm ⬇️⬇️
//        if let item  = todoItems?[indexPath.row] {
//            do {
//                try realm.write {
//                    realm.delete(item)
//                }
//            } catch {
//                print("Error deleting item! \(error)")
//            }
//        }

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    // Mark - Add new items
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // wwww
//            print("Success!")
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving  new items , \(error)")
                }
            }
           
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Create New Item"
            textField = alertTF

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
//    func saveItems () {
//
//
//        do {
//            try context.save()
//
//        } catch {
//            print("error saving context \(error)")
//        }
//
//
//        tableView.reloadData()
//    }
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
    }
    
}
//Mark: - Search Bar methods

extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("clickkkkkkkkkkkkkkkkkk =>>>>>>>>>>>>>>>>>")
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        //loadItems()
        
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}
