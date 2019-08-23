//
//  ListViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import CoreData

class ListViewModel {
    
    private let serializer: ItemSerialization & ItemDeserialization = ItemSerializer()
    
    var items: [Item] = []
    
    private let itemsGroup = DispatchGroup()
    
    private let executionQueue = DispatchQueue(label: "LoadItemsQueue", qos: .background, attributes: .concurrent)

    
    func getItems(_ completion: @escaping () -> Void) {
        
            self.getItemsFromPlist()
            self.getItemsFromCoreData()
        
        itemsGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
        
    }
    
    private func getItemsFromPlist() {
        guard let path =  Bundle.main.path(forResource: "Items", ofType: "plist") else {
            print("No path for Items.plist")
            return
        }
        
        let pathUrl = URL(fileURLWithPath: path)
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: pathUrl)
            
            let temporatyItems = try decoder.decode([Item].self, from: data)
            
            executionQueue.async(group: itemsGroup, flags: .barrier) {
                self.items += temporatyItems
            }
//                items += temporatyItems
            
        } catch let error {
            print("getItems error: \(error.localizedDescription)")
        }
    }
    
    private func getItemsFromCoreData() {
        
        let managedContext = CoreDataStore.managedObjectContext
        
        let fetchRequest = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        
        do {
            
            if let itemsEntity = try managedContext?.fetch(fetchRequest) {
                
                executionQueue.async(group: itemsGroup, flags: .barrier) {
                    self.items += itemsEntity.compactMap { self.serializer.deserialize($0) }
                }
                
//                    items += itemsEntity.compactMap { serializer.deserialize($0) }
                
            }
            
        } catch let error {
            print("Error loadItem ", error.localizedDescription)
        }
        
    }
}
