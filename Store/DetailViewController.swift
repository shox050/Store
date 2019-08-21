//
//  DetailViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol DetailController {
    func configure(with configuration: DetailConfiguration)
}

class DetailViewController: UIViewController {
    
    private var detailViewModel: DetailViewModel!
    
    var detailConfiguration: DetailConfiguration!
    
    @IBOutlet private weak var lName: UILabel!
    @IBOutlet private weak var lDescription: UILabel!
    @IBOutlet private weak var lCost: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(with: detailConfiguration)

    }
}

extension DetailViewController: DetailController {
    func configure(with configuration: DetailConfiguration) {
        
        detailViewModel = DetailViewModel(configuration.item)
        
        lName.text = detailViewModel.name
        
        lDescription.text = detailViewModel.description
        
        lCost.text = String(detailViewModel.cost)
    }
}
