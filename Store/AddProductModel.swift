//
//  AddProductModel.swift
//  Store
//
//  Created by Vladimir on 27/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol AddProductModel {
    var product: Product! { get set }
    
    func saveProduct(_ product: Product)
}
