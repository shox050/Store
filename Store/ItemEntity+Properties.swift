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


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var name: String
    @NSManaged public var itemDescription: String
    @NSManaged public var cost: Int64

}
