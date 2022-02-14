//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abdallah Elmadfa'a on 10/02/2022.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            let newCategory = Category()
            newCategory.name = textField.text!
    
            
            self.save(category: newCategory)
           
        }
        
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Create New Category"
            textField = alertTF

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        
    }
    
    
    //Mark : - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell" , for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "NO CATEGORIES ADDED"
        
        return cell
    }
    
    
    
    //Mark : - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    //Mark : - Data Manipulation Methods
    func save (category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }

        } catch {
            print("error saving category \(error)")
        }

        tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    
    
}
