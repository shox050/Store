//
//  AddViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import CoreData

class AddViewModel {
    
    var item: Item!
    
    private let serializer: ItemSerialization & ItemDeserialization = ItemSerializer()
    
    func saveItem(_ item: Item) {
        
        let managedContext = CoreDataStore.managedObjectContext
        
        let _ = serializer.serialize(item)
        
        do {
            try managedContext?.save()
        } catch let error {
            print("Error save context ", error.localizedDescription)
        }
    }
}
