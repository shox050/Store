//
//  ProductListModel.swift
//  Store
//
//  Created by Vladimir on 27/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol ProductListModel {
    var products: [Product] { get set }
    
    func loadProducts(_ completion: @escaping () -> Void)
}
