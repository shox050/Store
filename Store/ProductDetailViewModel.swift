//
//  DetailViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    private let constants = Constants()
    private var product: Product
    
    var name: String {
        return product.name
    }
    
    var description: String {
        return product.description
    }
    
    var cost: Int {
        return product.cost
    }
    
    init(_ product: Product) {
        self.product = product
    }
    
    func renderPdf(_ completion: @escaping (Data) -> Void) {
        
        let pageRect = Constants.RenderPDFSize.pageSize
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: Constants.Identifier.labelShopName)
        imageAttachment.bounds = Constants.RenderPDFSize.attachSize
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        let text = "\n\nName: \(product.name)\nDescription: \(product.description)\nCost: \(product.cost)"
        let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        let formatedText = NSAttributedString(string: text, attributes: textAttributes)
        
        let formattedTitle = NSMutableAttributedString(attributedString: imageString)
        formattedTitle.append(formatedText)
        
        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            
            formattedTitle.draw(in: pageRect.insetBy(dx: Constants.RenderPDFSize.offsetForDrawPage, dy: Constants.RenderPDFSize.offsetForDrawPage))
        }
        
        completion(data)
    }
}
