//
//  ItemSerializer.swift
//  Store
//
//  Created by Vladimir on 21/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import CoreData

class ItemSerializer: ItemSerialization, ItemDeserialization {
    
    func serialize(_ item: Item) -> ItemEntity? {
        
        guard let managedObjectContext = CoreDataStore.managedObjectContext else {
            return nil
        }
                
        let itemEntity = ItemEntity(context: managedObjectContext)
        
        itemEntity.name = item.name
        itemEntity.itemDescription = item.description
        itemEntity.cost = Int64(item.cost)
        
        return itemEntity
    }
    
    func deserialize(_ itemEntity: ItemEntity) -> Item {
        
        let name = itemEntity.name
        let description = itemEntity.itemDescription
        let cost = Int(itemEntity.cost)
        
        return Item(name: name, description: description, cost: cost)
    }
}
