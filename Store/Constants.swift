//
//  Constants.swift
//  Store
//
//  Created by Vladimir on 27/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

//struct Constants {
//    let pageSize = CGRect(x: 0, y: 0, width: 595, height: 841)
//    let attachSize = CGRect(x: 0, y: 0, width: 200, height: 200)
//    let offsetForDrawPage: CGFloat = 50.0
//
//    let segueIdentifierDetailVC = "showProductDetailViewController"
//    let cellIdentifier = "storeCell"
//    let labelShopName = "sparta"
//
//
////    private struct MimeType {
////        let pdf = "application/pdf"
////    }
//}


struct Constants {
    struct RenderPDFSize {
        static let pageSize = CGRect(x: 0, y: 0, width: 595, height: 841)
        static let attachSize = CGRect(x: 0, y: 0, width: 200, height: 200)
        static let offsetForDrawPage: CGFloat = 50.0
    }
    
    struct Identifier {
        static let segueIdentifierDetailVC = "showProductDetailViewController"
        static let cellIdentifier = "storeCell"
        static let labelShopName = "sparta"
        static let attachmentName = "Attach.pdf"
        static let entityName = "ProductEntity"
        static let sourceFile = "Products"
        static let typeSourceFile = "plist"
    }
    
    struct MimeType {
        static let pdf = "application/pdf"
    }
    
    struct DispatchQueueLabel {
        static let executionQueue = "ExecutionQueue"
    }
}
