//
//  AddViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol AddItemDelegate: class {
    func didAdd(new item: Item)
}

class AddViewController: UIViewController {
    
    weak var delegate: AddItemDelegate?
    
    private let addViewModel = AddViewModel()
    
    @IBOutlet private weak var tfName: UITextField!
    @IBOutlet private weak var tfDescription: UITextField!
    @IBOutlet private weak var tfCost: UITextField!
    
    
    @IBAction private func actionAdd(_ sender: UIButton) {
        
        addItem()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}


extension AddViewController {
    
    private func addItem() {
        guard let name = tfName.text, !name.isEmpty else {
            showAlert(title: "Alert", message: "Please, enter name")
            tfName.becomeFirstResponder()
            return
        }
        
        guard let description = tfDescription.text, !description.isEmpty else {
            showAlert(title: "Alert", message: "Please, enter description")
            tfDescription.becomeFirstResponder()
            return
        }
        
        guard let strCost = tfCost.text, !strCost.isEmpty else {
            showAlert(title: "Alert", message: "Please, enter cost")
            tfCost.becomeFirstResponder()
            return
        }
        
        guard let cost = Int(strCost) else {
            showAlert(title: "Alert", message: "Only numbers can be entered")
            tfCost.text = ""
            tfCost.becomeFirstResponder()
            return
        }
        
        let item = Item(name: name, description: description, cost: cost)
        
        addViewModel.item = item
//        addViewModel.saveItem(item)
        delegate?.didAdd(new: addViewModel.item)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    
}
