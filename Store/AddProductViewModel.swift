//
//  AddViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import CoreData

class AddProductViewModel: AddProductModel {
    
    var product: Product!
    
    private let serializer: ProductSerialization & ProductDeserialization = ProductSerializer()
    
    func saveProduct(_ product: Product) {
        
        let managedContext = CoreDataStore.managedObjectContext
        let _ = serializer.serialize(product)
        
        do {
            try managedContext?.save()
        } catch let error {
            print("Error save context ", error.localizedDescription)
        }
    }
}
