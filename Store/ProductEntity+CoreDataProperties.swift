//
//  ItemEntity+CoreDataProperties.swift
//  Store
//
//  Created by Vladimir on 21/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var productDescription: String
    @NSManaged public var cost: Int64

}
