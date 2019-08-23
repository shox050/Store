//
//  ItemSerialization.swift
//  Store
//
//  Created by Vladimir on 21/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol ItemSerialization {
    func serialize(_ item: Item) -> ItemEntity?
}

protocol ItemDeserialization {
    func deserialize(_ itemEntity: ItemEntity) -> Item
}
