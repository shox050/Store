//
//  ListViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

class ListViewModel {
    
    var items: [Item] = []
    
    func getItems() {
        guard let path =  Bundle.main.path(forResource: "Items", ofType: "plist") else {
            print("No path for Items.plist")
            return
        }
        
        let pathUrl = URL(fileURLWithPath: path)
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: pathUrl)
            items = try decoder.decode([Item].self, from: data)
        } catch let error {
            print("getItems error: \(error.localizedDescription)")
        }
    }
}
