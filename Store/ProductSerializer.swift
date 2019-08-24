//
//  ProductSerializer.swift
//  Store
//
//  Created by Vladimir on 21/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import CoreData

class ProductSerializer: ProductSerialization, ProductDeserialization {
    
    func serialize(_ product: Product) -> ProductEntity? {
        
        guard let managedObjectContext = CoreDataStore.managedObjectContext else {
            return nil
        }
                
        let productEntity = ProductEntity(context: managedObjectContext)
        
        productEntity.name = product.name
        productEntity.productDescription = product.description
        productEntity.cost = Int64(product.cost)
        
        return productEntity
    }
    
    func deserialize(_ productEntity: ProductEntity) -> Product {
        
        let name = productEntity.name
        let description = productEntity.productDescription
        let cost = Int(productEntity.cost)
        
        return Product(name: name, description: description, cost: cost)
    }
}
