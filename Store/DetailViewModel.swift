//
//  DetailViewModel.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class DetailViewModel {
        
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
        
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 841)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "sparta")
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        let text = "\n\nName: \(product.name)\nDescription: \(product.description)\nCost: \(product.cost)"
        let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        
        let formatedText = NSAttributedString(string: text, attributes: textAttributes)
        
        let formattedTitle = NSMutableAttributedString(attributedString: imageString)
        formattedTitle.append(formatedText)
        
        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            
            formattedTitle.draw(in: pageRect.insetBy(dx: 50, dy: 50))
        }
        
        completion(data)
    }
}
