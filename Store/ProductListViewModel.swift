//
//  ListViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import CoreData

class ProductListViewModel {
    
    var products: [Product] = []
    
    private let serializer: ProductSerialization & ProductDeserialization = ProductSerializer()
    
    private let productGroup = DispatchGroup()
    private let executionQueue = DispatchQueue(label: "ProductQueue", qos: .background, attributes: .concurrent)

    
    func getProducts(_ completion: @escaping () -> Void) {
        executionQueue.async(group: productGroup) {
            self.getProductsFromPlist()
            self.getProductsFromCoreData()
        }
                
        productGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    private func getProductsFromPlist() {
        guard let path = Bundle.main.path(forResource: "Products", ofType: "plist") else {
            print("No path for Products.plist")
            return
        }
        
        let pathUrl = URL(fileURLWithPath: path)
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: pathUrl)
            let products = try decoder.decode([Product].self, from: data)
            executionQueue.async(group: productGroup, flags: .barrier) {
                self.products += products
            }
        } catch let error {
            print("func getProductsFromPlist catch error: \(error.localizedDescription)")
        }
    }
    
    private func getProductsFromCoreData() {
        let managedContext = CoreDataStore.managedObjectContext
        let fetchRequest = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        
        do {
            if let productsEntity = try managedContext?.fetch(fetchRequest) {
                let products = productsEntity.compactMap { serializer.deserialize($0) }
                executionQueue.async(group: productGroup, flags: .barrier) {
                    self.products += products
                }
            }
        } catch let error {
            print("func getProductsFromCoreData get error: ", error.localizedDescription)
        }
    }
}
