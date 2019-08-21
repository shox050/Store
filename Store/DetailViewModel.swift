//
//  DetailViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    private var item: Item
    
    var name: String {
        return item.name
    }
    
    var description: String {
        return item.description
    }
    
    var cost: Int {
        return item.cost
    }
    
    init(_ item: Item) {
        self.item = item
    }
    
}
