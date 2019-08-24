//
//  ProductSerialization.swift
//  Store
//
//  Created by Vladimir on 21/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol ProductSerialization {
    func serialize(_ product: Product) -> ProductEntity?
}

protocol ProductDeserialization {
    func deserialize(_ productEntity: ProductEntity) -> Product
}
