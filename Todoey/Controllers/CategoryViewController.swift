//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abdallah Elmadfa'a on 10/02/2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Categorry]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        
    }

    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            let newCategory = Categorry(context: self.context)
            newCategory.name = textField.text!
    
            self.categories.append(newCategory)
            
            self.saveItems()
           
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
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell" , for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
    
    //Mark : - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    //Mark : - Data Manipulation Methods
    func saveItems () {
        do {
            try context.save()

        } catch {
            print("error saving category \(error)")
        }

        tableView.reloadData()
    }
    
    
    func loadItems() {
        let request : NSFetchRequest<Categorry> = Categorry.fetchRequest()
        do{
            categories = try context.fetch(request)
        } catch{
            print("Error loading categories\(error)")
        }
        
        tableView.reloadData()
    }

    
    
}
