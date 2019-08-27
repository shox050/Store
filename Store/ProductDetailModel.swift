//
//  ProductDetailModel.swift
//  Store
//
//  Created by Vladimir on 27/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol ProductDetailModel {
    
    var name: String { get }
    var description: String { get }
    var cost: Int { get }
    
    func renderPdf(_ completion: @escaping (Data) -> Void)
}
