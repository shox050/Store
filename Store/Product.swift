//
//  Product.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let name: String
    let description: String
    let cost: Int
}
