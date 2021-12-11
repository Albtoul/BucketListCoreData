//
//  AddItemViewController.swift
//  BucketList
//
//  Created by Hell on 11/12/2021.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    weak var delegate:AddButtonsDelegate?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    var item: String?
    var index:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.saveButtonPressed(by: self, with: text, indexPath: index)
    }
    
}
