//
//  DetailViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailViewModel = DetailViewModel()
    
    @IBOutlet private weak var lName: UILabel!
    
    @IBOutlet private weak var lDescription: UILabel!
    
    @IBOutlet private weak var lCost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lName.text = detailViewModel.item.name

        lDescription.text = detailViewModel.item.description

        lCost.text = String(detailViewModel.item.cost)
    }
}
