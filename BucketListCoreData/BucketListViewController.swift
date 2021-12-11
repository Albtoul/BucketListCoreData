//
//  ViewController.swift
//  BucketList
//
//  Created by Hell on 11/12/2021.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddButtonsDelegate{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    func cancelButtonPressed(by controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveButtonPressed(by controller:AddItemViewController, with text:String, indexPath:IndexPath?){
        
        if let ip = indexPath {
            let item = list[ip.row]
            item.text = text
            
        }else{
            let newItem = BucketListItem(context: context)
            newItem.text = text
            list.append(newItem)
        }
        
        saveContext()
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    var list : [BucketListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getItems()
        // Do any additional setup after loading the view.
    }
    
    func getItems(){
        let request : NSFetchRequest<BucketListItem> = BucketListItem.fetchRequest()
        do{
            list = try context.fetch(request)
        }catch{
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].text
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemViewController
            addItemTableViewController.delegate = self
        }else if sender is IndexPath {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemViewController
            addItemTableViewController.delegate = self
            let indexPath = sender as! IndexPath
            let item = list[indexPath.row]
            addItemTableViewController.item = item.text!
            addItemTableViewController.index = indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        context.delete(item)
        saveContext()
        list.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}

